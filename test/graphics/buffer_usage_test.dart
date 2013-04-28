// Copyright (c) 2012, the Lihtium-Ion Engine project authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

library buffer_usage_test;

import 'dart:web_gl' as WebGL;

import 'package:unittest/unittest.dart';
import 'package:lithium_ion/graphics.dart';

var throwsAssertionError = throwsA(new isInstanceOf<AssertionError>());

void main() {
  test('values', () {
    expect(BufferUsage.Static , WebGL.STATIC_DRAW);
    expect(BufferUsage.Dynamic, WebGL.DYNAMIC_DRAW);
  });

  test('stringify', () {
    expect(BufferUsage.stringify(BufferUsage.Static) , 'Static');
    expect(BufferUsage.stringify(BufferUsage.Dynamic), 'Dynamic');

    expect(() { BufferUsage.stringify(-1); }, throwsAssertionError);
  });

  test('parse', () {
    expect(BufferUsage.parse('Static') , BufferUsage.Static);
    expect(BufferUsage.parse('Dynamic'), BufferUsage.Dynamic);

    expect(() { BufferUsage.parse('NotValid'); }, throwsAssertionError);
  });

  test('isValid', () {
    expect(BufferUsage.isValid(BufferUsage.Static) , true);
    expect(BufferUsage.isValid(BufferUsage.Dynamic), true);

    expect(BufferUsage.isValid(-1), false);
  });
}
