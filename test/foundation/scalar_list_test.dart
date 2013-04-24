// Copyright (c) 2013, the Lihtium-Ion Engine Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

library scalar_list_test;

import 'dart:typeddata';
import 'package:unittest/unittest.dart';
import 'package:lithium_ion/lithium_foundation.dart';
import 'strided_list_test_helper.dart';

void main() {
  const int size = 1024;

  test('no stride', () {
    var test = createSequentialList(size);
    var list = new ScalarList.view(test.buffer);

    expect(list.length, test.length);

    for (int i = 0; i < size; ++i) {
      expect(list[i], test[i]);
    }
  });

  test('stride and offset', () {
    var test = createSequentialList(size);
    var array = test.buffer;

    for (int k = 1; k < size; ++k) {
      int length = size ~/ k;

      for (int j = 0; j < k; ++j) {
        ScalarList list = new ScalarList.view(array, j * 4, k * 4);

        expect(list.length, length);

        for (int i = 0; i < length; ++i) {
          expect(list[i], test[(k * i) + j]);
        }
      }
    }
  });
}
