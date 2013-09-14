// Copyright (c) 2013, the Lihtium-Ion Engine Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

library vertex_element_test;

import 'package:unittest/unittest.dart';
import 'package:lithium_ion/graphics.dart';

import '../test_helpers.dart';

void testConstructor(int offset, int format, int usage, int usageIndex, int slot) {
  var element = new VertexElement(offset, format, usage, usageIndex: usageIndex, slot: slot);

  expect(element.slot      , slot);
  expect(element.offset    , offset);
  expect(element.usageIndex, usageIndex);
  expect(element.format    , format);
  expect(element.usage     , usage);
}

void main() {
  // Construction
  test('construction', () {
    for (int i = 0; i < 16; ++i) {
      // Test offsets
      testConstructor(i, VertexElementFormat.Scalar, VertexElementUsage.Position, 0, 0);

      // Test usage indices
      testConstructor(0, VertexElementFormat.Scalar, VertexElementUsage.Position, i, 0);

      // Test slots
      testConstructor(0, VertexElementFormat.Scalar, VertexElementUsage.Position, 0, i);
    }

    // Test formats
    testConstructor(0, VertexElementFormat.Scalar , VertexElementUsage.Position, 0, 0);
    testConstructor(0, VertexElementFormat.Vector2, VertexElementUsage.Position, 0, 0);
    testConstructor(0, VertexElementFormat.Vector3, VertexElementUsage.Position, 0, 0);
    testConstructor(0, VertexElementFormat.Vector4, VertexElementUsage.Position, 0, 0);

    // Test usage
    testConstructor(0, VertexElementFormat.Vector3, VertexElementUsage.Position         , 0, 0);
    testConstructor(0, VertexElementFormat.Vector3, VertexElementUsage.Normal           , 0, 0);
    testConstructor(0, VertexElementFormat.Vector3, VertexElementUsage.Tangent          , 0, 0);
    testConstructor(0, VertexElementFormat.Vector3, VertexElementUsage.Binormal         , 0, 0);
    testConstructor(0, VertexElementFormat.Vector3, VertexElementUsage.TextureCoordinate, 0, 0);
    testConstructor(0, VertexElementFormat.Vector3, VertexElementUsage.Color            , 0, 0);
    testConstructor(0, VertexElementFormat.Vector3, VertexElementUsage.PointSize        , 0, 0);

    // Test assertions
    expect(() { testConstructor(-1, VertexElementFormat.Scalar, VertexElementUsage.Position, 0, 0); }, throwsAssertionError);
    expect(() { testConstructor( 0, -1, VertexElementUsage.Position, 0, 0); }, throwsAssertionError);
    expect(() { testConstructor( 0, VertexElementFormat.Scalar, -1, 0, 0); }, throwsAssertionError);
    expect(() { testConstructor( 0, VertexElementFormat.Scalar, VertexElementUsage.Position, -1, 0); }, throwsAssertionError);
    expect(() { testConstructor( 0, VertexElementFormat.Scalar, VertexElementUsage.Position, 0, -1); }, throwsAssertionError);
  });
}
