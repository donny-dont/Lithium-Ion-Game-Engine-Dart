// Copyright (c) 2013, the Lihtium-Ion Engine Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

library vertex_list_test;

import 'dart:typed_data';

import 'package:unittest/unittest.dart';
import 'package:lithium_ion/graphics.dart';

import 'graphics_mocks.dart';
import '../test_helpers.dart';

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
}
