// Copyright (c) 2013, the Lihtium-Ion Engine Project Authors.
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
    device.onResourceCreated.listen((_) { resources++; });
    device.onResourceDestroyed.listen((_) { resources--; });

    // Create all the GraphicsResource subclasses
    var viewport = new Viewport(device);

    expect(resources, 1);

    // Destory all the GraphicsResource subclasses
    viewport.dispose();

    expect(resources, 0);
  });
}