// Copyright (c) 2013, the Lihtium-Ion Engine Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

library vertex_declaration_test;

import 'package:unittest/unittest.dart';
import 'package:lithium_ion/graphics.dart';

import 'graphics_mocks.dart';
import '../test_helpers.dart';

var graphicsDevice;

void testStrides(VertexDeclaration declaration, dynamic strides) {
  if (strides is int) {
    strides = [ strides ];
  }

  int strideCount = strides.length;
  expect(strideCount, declaration.slots);

  for (int i = 0; i < strideCount; ++i) {
    expect(strides[i], declaration.getVertexStride(i));
  }
}

void testNamedConstructor(VertexDeclaration declaration, List<int> elements) {
  var allElements = [
      VertexElementUsage.Position,
      VertexElementUsage.Normal,
      VertexElementUsage.Tangent,
      VertexElementUsage.Binormal,
      VertexElementUsage.TextureCoordinate,
      VertexElementUsage.Color,
      VertexElementUsage.PointSize
  ];

  int allElementCount = allElements.length;

  for (int i = 0; i < allElementCount; ++i) {
    int usage = allElements[i];
    bool hasElement = elements.contains(usage);

    expect(declaration.hasElement(usage, 0), hasElement);

    for (int j = 1; j < 8; ++j) {
      expect(declaration.hasElement(usage, j), false);
    }
  }
}

void main() {
  graphicsDevice = createMockGraphicsDevice();

  // Construction
  test('construction', () {
    var elements;
    var declaration;

    // Test position constructor
    declaration = new VertexDeclaration.position(graphicsDevice);
    testNamedConstructor(declaration, [ VertexElementUsage.Position ]);

    // Test positionColor constructor
    declaration = new VertexDeclaration.positionColor(graphicsDevice);
    testNamedConstructor(declaration, [ VertexElementUsage.Position, VertexElementUsage.Color ]);

    // Test positionColorSize constructor
    declaration = new VertexDeclaration.positionColorSize(graphicsDevice);
    testNamedConstructor(declaration, [ VertexElementUsage.Position, VertexElementUsage.Color, VertexElementUsage.PointSize ]);

    // Test positionNormalTexture constructor
    declaration = new VertexDeclaration.positionNormalTexture(graphicsDevice);
    testNamedConstructor(declaration, [ VertexElementUsage.Position, VertexElementUsage.Normal, VertexElementUsage.TextureCoordinate ]);

    // Test positionTexture constructor
    declaration = new VertexDeclaration.positionTexture(graphicsDevice);
    testNamedConstructor(declaration, [ VertexElementUsage.Position, VertexElementUsage.TextureCoordinate ]);

    // Test assertions
    expect(() { declaration = new VertexDeclaration(graphicsDevice, null); }, throwsAssertionError);

    // Test repeating elements
    elements = [
        new VertexElement(0, VertexElementFormat.Vector3, VertexElementUsage.Position),
        new VertexElement(0, VertexElementFormat.Vector3, VertexElementUsage.Position)
    ];

    expect(() { declaration = new VertexDeclaration(graphicsDevice, elements); }, throwsAssertionError);

    // Test bad strides
    elements = [
        new VertexElement(0, VertexElementFormat.Vector3, VertexElementUsage.Position),
        new VertexElement(3, VertexElementFormat.Vector3, VertexElementUsage.Normal)
    ];

    expect(() { declaration = new VertexDeclaration(graphicsDevice, elements, [2, 2]); }, throwsAssertionError);
  });

  // Strides
  test('getVertexStride', () {
    var declaration;

    // Test computed strides
    var elements = [
        new VertexElement(0, VertexElementFormat.Vector3, VertexElementUsage.Position         , slot:  0),
        new VertexElement(0, VertexElementFormat.Vector3, VertexElementUsage.Normal           , slot:  1),
        new VertexElement(0, VertexElementFormat.Vector3, VertexElementUsage.Tangent          , slot:  2),
        new VertexElement(0, VertexElementFormat.Vector3, VertexElementUsage.Binormal         , slot:  3),
        new VertexElement(0, VertexElementFormat.Vector2, VertexElementUsage.TextureCoordinate, slot:  4),
        new VertexElement(0, VertexElementFormat.Vector4, VertexElementUsage.Color            , slot:  5),
        new VertexElement(0, VertexElementFormat.Scalar , VertexElementUsage.PointSize        , slot:  6),
        new VertexElement(0, VertexElementFormat.Vector3, VertexElementUsage.Position         , slot:  7, usageIndex: 1),
        new VertexElement(0, VertexElementFormat.Vector3, VertexElementUsage.Normal           , slot:  8, usageIndex: 1),
        new VertexElement(0, VertexElementFormat.Vector3, VertexElementUsage.Tangent          , slot:  9, usageIndex: 1),
        new VertexElement(0, VertexElementFormat.Vector3, VertexElementUsage.Binormal         , slot: 10, usageIndex: 1),
        new VertexElement(0, VertexElementFormat.Vector2, VertexElementUsage.TextureCoordinate, slot: 11, usageIndex: 1),
        new VertexElement(0, VertexElementFormat.Vector4, VertexElementUsage.Color            , slot: 12, usageIndex: 1),
        new VertexElement(0, VertexElementFormat.Scalar , VertexElementUsage.PointSize        , slot: 13, usageIndex: 1)
    ];

    declaration = new VertexDeclaration(graphicsDevice, elements);
    testStrides(declaration, [ 12, 12, 12, 12, 8, 16, 4, 12, 12, 12, 12, 8, 16, 4 ]);

    // Test declared strides
    var strides = [ 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16];
    declaration = new VertexDeclaration(graphicsDevice, elements, strides);

    testStrides(declaration, strides);

    // Test position constructor
    declaration = new VertexDeclaration.position(graphicsDevice);
    testStrides(declaration, 12);

    declaration = new VertexDeclaration.position(graphicsDevice, true);
    testStrides(declaration, 16);

    // Test positionColor constructor
    declaration = new VertexDeclaration.positionColor(graphicsDevice);
    testStrides(declaration, 12 + 16);

    declaration = new VertexDeclaration.positionColor(graphicsDevice, true);
    testStrides(declaration, 16 * 2);

    // Test positionColorSize constructor
    declaration = new VertexDeclaration.positionColorSize(graphicsDevice);
    testStrides(declaration, 12 + 16 + 4);

    declaration = new VertexDeclaration.positionColorSize(graphicsDevice, true);
    testStrides(declaration, 16 * 3);

    // Test positionNormalTexture constructor
    declaration = new VertexDeclaration.positionNormalTexture(graphicsDevice);
    testStrides(declaration, 12 + 12 + 8);

    declaration = new VertexDeclaration.positionNormalTexture(graphicsDevice, true);
    testStrides(declaration, 16 * 3);

    // Test positionTexture constructor
    declaration = new VertexDeclaration.positionTexture(graphicsDevice);
    testStrides(declaration, 12 + 8);

    declaration = new VertexDeclaration.positionTexture(graphicsDevice, true);
    testStrides(declaration, 16 * 2);
  });
}
