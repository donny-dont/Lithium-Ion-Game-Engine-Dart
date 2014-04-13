// Copyright (c) 2013-2014, the Lithium-Ion Engine Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

library vertex_list_test;

import 'package:unittest/unittest.dart';
import 'package:lithium_ion/graphics.dart';

import 'graphics_mocks.dart';

var graphicsDevice;

void main() {
  graphicsDevice = createMockGraphicsDevice();

  test('constructor', () {
    const int vertexCount = 80;

    var declaration = new VertexDeclaration.positionColor(graphicsDevice);
    var list = new VertexList(declaration, vertexCount);

    expect(list.positions != null, true);
    expect(list.colors    != null, true);

    expect(list.normals            != null, false);
    expect(list.binormals          != null, false);
    expect(list.textureCoordinates != null, false);
    expect(list.pointSizes         != null, false);

    expect(list.positions.length, vertexCount);
    expect(list.colors.length   , vertexCount);
  });

  test('instanced', () {
    const int vertexCount = 80;
    const int instanceCount = 10;

    var elements = [
        new VertexElement( 0, VertexElementFormat.Vector3, VertexElementUsage.Position         , slot: 0, instanceDataStepRate: 0),
        new VertexElement( 0, VertexElementFormat.Vector3, VertexElementUsage.Color            , slot: 1, instanceDataStepRate: 1),
        new VertexElement(12, VertexElementFormat.Vector3, VertexElementUsage.TextureCoordinate, slot: 1, instanceDataStepRate: 1)
    ];

    var declaration = new VertexDeclaration(graphicsDevice, elements);
    var list = new VertexList(declaration, vertexCount, instanceCount);

    var instanceColors = list.getElement(VertexElementUsage.Color, 0);

    expect(instanceColors.length, instanceCount);
  });
}
