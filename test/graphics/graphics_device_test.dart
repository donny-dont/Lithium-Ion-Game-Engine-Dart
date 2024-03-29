// Copyright (c) 2013-2014, the Lithium-Ion Engine Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

library graphics_device_test;

import 'package:unittest/unittest.dart';
import 'package:lithium_ion/graphics.dart';

import 'graphics_mocks.dart';

void main() {
  var surface = new MockCanvasElement();

  test('resource creation', () {
    var device = new GraphicsDevice(surface);

    int resources = 0;

    // Attach to the events
    device.onResourceCreated.listen  ((_) { print('Resource created'); resources++; });
    device.onResourceDestroyed.listen((_) { print('Resource destroyed'); resources--; });

    // Create all the GraphicsResource subclasses
    var viewport = new Viewport(device);
    var vertexBuffer = new VertexBuffer.static(device);
    var indexBuffer = new IndexBuffer.static(device);
    var vertexDeclaration = new VertexDeclaration.position(device);
    var mesh = new Mesh(device, vertexDeclaration, [vertexBuffer], indexBuffer);

    expect(resources, 5);

    // Destory all the GraphicsResource subclasses
    viewport.dispose();
    vertexBuffer.dispose();
    indexBuffer.dispose();
    vertexDeclaration.dispose();
    mesh.dispose();

    expect(resources, 0);
  });
}
