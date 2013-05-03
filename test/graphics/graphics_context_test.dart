// Copyright (c) 2013, the Lihtium-Ion Engine Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

library graphics_context_test;

import 'package:unittest/mock.dart';
import 'package:unittest/unittest.dart';
import 'package:lithium_ion/graphics.dart';

import 'graphics_mocks.dart';

part 'graphics_context_drawing_test.dart';
part 'graphics_context_state_test.dart';

//---------------------------------------------------------------------
// GraphicsContext testing utility functions
//---------------------------------------------------------------------

void verifyInitialPipelineState(GraphicsDevice graphicsDevice) {
  int calls = 0;
  var gl = graphicsDevice.gl as MockRenderingContext;

  calls += verifyInitialViewport(graphicsDevice, gl);

  // Number of GL calls in GraphicsContext._initializeState
  expect(gl.log.logs.length, calls);
}

//---------------------------------------------------------------------
// Test entry point
//---------------------------------------------------------------------

void main() {
  // State tests
  testViewport();

  // Drawing tests
  testVertexDeclaration();
}
