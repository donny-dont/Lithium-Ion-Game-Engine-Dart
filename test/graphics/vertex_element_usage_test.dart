// Copyright (c) 2013, the Lihtium-Ion Engine Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

library vertex_element_usage_test;

import 'package:unittest/unittest.dart';
import 'package:lithium_ion/graphics.dart';

var throwsAssertionError = throwsA(new isInstanceOf<AssertionError>());

void main() {
  test('values', () {
    expect(VertexElementUsage.Position         , 0);
    expect(VertexElementUsage.Normal           , 1);
    expect(VertexElementUsage.Tangent          , 2);
    expect(VertexElementUsage.Binormal         , 3);
    expect(VertexElementUsage.TextureCoordinate, 4);
    expect(VertexElementUsage.Color            , 5);
    expect(VertexElementUsage.PointSize        , 6);
  });

  test('stringify', () {
    expect(VertexElementUsage.stringify(VertexElementUsage.Position)         , 'Position');
    expect(VertexElementUsage.stringify(VertexElementUsage.Normal)           , 'Normal');
    expect(VertexElementUsage.stringify(VertexElementUsage.Tangent)          , 'Tangent');
    expect(VertexElementUsage.stringify(VertexElementUsage.Binormal)         , 'Binormal');
    expect(VertexElementUsage.stringify(VertexElementUsage.TextureCoordinate), 'TextureCoordinate');
    expect(VertexElementUsage.stringify(VertexElementUsage.Color)            , 'Color');
    expect(VertexElementUsage.stringify(VertexElementUsage.PointSize)        , 'PointSize');

    expect(() { VertexElementUsage.stringify(-1); }, throwsAssertionError);
  });

  test('parse', () {
    expect(VertexElementUsage.parse('Position')         , VertexElementUsage.Position);
    expect(VertexElementUsage.parse('Normal')           , VertexElementUsage.Normal);
    expect(VertexElementUsage.parse('Tangent')          , VertexElementUsage.Tangent);
    expect(VertexElementUsage.parse('Binormal')         , VertexElementUsage.Binormal);
    expect(VertexElementUsage.parse('TextureCoordinate'), VertexElementUsage.TextureCoordinate);
    expect(VertexElementUsage.parse('Color')            , VertexElementUsage.Color);
    expect(VertexElementUsage.parse('PointSize')        , VertexElementUsage.PointSize);

    expect(() { VertexElementUsage.parse('NotValid'); }, throwsAssertionError);
  });

  test('isValid', () {
    expect(VertexElementUsage.isValid(VertexElementUsage.Position)         , true);
    expect(VertexElementUsage.isValid(VertexElementUsage.Normal)           , true);
    expect(VertexElementUsage.isValid(VertexElementUsage.Tangent)          , true);
    expect(VertexElementUsage.isValid(VertexElementUsage.Binormal)         , true);
    expect(VertexElementUsage.isValid(VertexElementUsage.TextureCoordinate), true);
    expect(VertexElementUsage.isValid(VertexElementUsage.Color)            , true);
    expect(VertexElementUsage.isValid(VertexElementUsage.PointSize)        , true);

    expect(VertexElementUsage.isValid(-1), false);
  });
}
