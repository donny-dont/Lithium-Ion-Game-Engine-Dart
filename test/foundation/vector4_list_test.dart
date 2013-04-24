// Copyright (c) 2013, the Lihtium-Ion Engine Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

library vector4_list_test;

import 'dart:typeddata';
import 'package:unittest/unittest.dart';
import 'package:lithium_ion/lithium_foundation.dart';
import 'strided_list_test_helper.dart';

void main() {
  const int elementCount = 4;
  const int bytesPerElement = Vector4List.BYTES_PER_ELEMENT;
  const int size = 4096;
  const int listSize = size ~/ elementCount;

  test('no stride', () {
    var test = createSequentialList(size);
    var list = new Vector4List.view(test.buffer);

    expect(list.length, listSize);

    int testIndex = 0;
    for (int i = 0; i < listSize; ++i) {
      var element = list[i];

      expect(element.x, test[testIndex++]);
      expect(element.y, test[testIndex++]);
      expect(element.z, test[testIndex++]);
      expect(element.w, test[testIndex++]);
    }
  });

  test('stride and offset', () {
    var test = createSequentialList(size);
    var array = test.buffer;

    for (int k = 1; k < listSize; ++k) {
      int length = size ~/ (k * elementCount);

      for (int j = 0; j < k; ++j) {
        var list = new Vector4List.view(array, j * bytesPerElement, k * bytesPerElement);

        expect(list.length, length);

        for (int i = 0; i < length; ++i) {
          var value = list[i];
          int testIndex = elementCount * ((k * i) + j);

          expect(value.x, test[testIndex++]);
          expect(value.y, test[testIndex++]);
          expect(value.z, test[testIndex++]);
          expect(value.w, test[testIndex]);
        }
      }
    }
  });
}
