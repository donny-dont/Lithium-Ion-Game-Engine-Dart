// Copyright (c) 2013, the Lihtium-Ion Engine Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

library foundation_test;

import 'package:unittest/unittest.dart';

import 'graphics/buffer_usage_test.dart' as buffer_usage_test;
import 'graphics/graphics_device_test.dart' as graphics_device_test;
import 'graphics/graphics_context_test.dart' as graphics_context_test;
import 'graphics/vertex_buffer_test.dart' as vertex_buffer_test;
import 'graphics/viewport_test.dart' as viewport_test;

void main() {
  group('Graphics library', () {
    group('BufferUsage tests', buffer_usage_test.main);
    group('GraphicsDevice tests', graphics_device_test.main);
    group('GraphicsContext tests', graphics_context_test.main);
    group('VertexBuffer tests', vertex_buffer_test.main);
    group('Viewport tests', viewport_test.main);
  });
}
