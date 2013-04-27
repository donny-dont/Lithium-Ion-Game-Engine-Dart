// Copyright (c) 2013, the Lihtium-Ion Engine Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

library graphics_mocks;

import 'dart:html';
import 'dart:web_gl' as WebGL;

import 'package:unittest/mock.dart';
import 'package:unittest/unittest.dart';
import 'package:lithium_ion/graphics.dart';

part 'mock_canvas_element.dart';
part 'mock_rendering_context.dart';

GraphicsDevice createMockGraphicsDevice() {
  return new GraphicsDevice(new MockCanvasElement());
}
