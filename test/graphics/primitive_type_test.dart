// Copyright (c) 2012, the Lihtium-Ion Engine project authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

library primitive_type_test;

import 'dart:web_gl' as WebGL;

import 'package:unittest/unittest.dart';
import 'package:lithium_ion/graphics.dart';

import '../test_helpers.dart';

void main() {
  test('values', () {
    expect(PrimitiveType.PointList    , WebGL.POINTS);
    expect(PrimitiveType.LineList     , WebGL.LINES);
    expect(PrimitiveType.LineStrip    , WebGL.LINE_STRIP);
    expect(PrimitiveType.TriangleList , WebGL.TRIANGLES);
    expect(PrimitiveType.TriangleStrip, WebGL.TRIANGLE_STRIP);
  });

  test('stringify', () {
    expect(PrimitiveType.stringify(PrimitiveType.PointList)    , 'PointList');
    expect(PrimitiveType.stringify(PrimitiveType.LineList)     , 'LineList');
    expect(PrimitiveType.stringify(PrimitiveType.LineStrip)    , 'LineStrip');
    expect(PrimitiveType.stringify(PrimitiveType.TriangleList) , 'TriangleList');
    expect(PrimitiveType.stringify(PrimitiveType.TriangleStrip), 'TriangleStrip');

    expect(() { PrimitiveType.stringify(-1); }, throwsAssertionError);
  });

  test('parse', () {
    expect(PrimitiveType.parse('PointList')    , PrimitiveType.PointList);
    expect(PrimitiveType.parse('LineList')     , PrimitiveType.LineList);
    expect(PrimitiveType.parse('LineStrip')    , PrimitiveType.LineStrip);
    expect(PrimitiveType.parse('TriangleList') , PrimitiveType.TriangleList);
    expect(PrimitiveType.parse('TriangleStrip'), PrimitiveType.TriangleStrip);

    expect(() { PrimitiveType.parse('NotValid'); }, throwsAssertionError);
  });

  test('isValid', () {
    expect(PrimitiveType.isValid(PrimitiveType.PointList)    , true);
    expect(PrimitiveType.isValid(PrimitiveType.LineList)     , true);
    expect(PrimitiveType.isValid(PrimitiveType.LineStrip)    , true);
    expect(PrimitiveType.isValid(PrimitiveType.TriangleList) , true);
    expect(PrimitiveType.isValid(PrimitiveType.TriangleStrip), true);

    expect(PrimitiveType.isValid(-1), false);
  });
}
