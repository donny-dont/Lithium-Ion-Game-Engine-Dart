// Copyright (c) 2012, the Lihtium-Ion Engine project authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

library index_element_size_test;

import 'dart:web_gl' as WebGL;

import 'package:unittest/unittest.dart';
import 'package:lithium_ion/graphics.dart';

var throwsAssertionError = throwsA(new isInstanceOf<AssertionError>());

void main() {
  test('values', () {
    expect(IndexElementSize.Short  , WebGL.UNSIGNED_SHORT);
    expect(IndexElementSize.Integer, WebGL.UNSIGNED_INT);
  });

  test('stringify', () {
    expect(IndexElementSize.stringify(IndexElementSize.Short)  , 'Short');
    expect(IndexElementSize.stringify(IndexElementSize.Integer), 'Integer');

    expect(() { IndexElementSize.stringify(-1); }, throwsAssertionError);
  });

  test('parse', () {
    expect(IndexElementSize.parse('Short')  , IndexElementSize.Short);
    expect(IndexElementSize.parse('Integer'), IndexElementSize.Integer);

    expect(() { IndexElementSize.parse('NotValid'); }, throwsAssertionError);
  });

  test('isValid', () {
    expect(IndexElementSize.isValid(IndexElementSize.Short)  , true);
    expect(IndexElementSize.isValid(IndexElementSize.Integer), true);

    expect(IndexElementSize.isValid(-1), false);
  });
}
