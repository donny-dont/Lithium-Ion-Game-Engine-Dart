// Copyright (c) 2013, the Lihtium-Ion Engine Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

part of graphics_context_test;

//---------------------------------------------------------------------
// Viewport testing utility functions
//---------------------------------------------------------------------

void copyViewport(Viewport original, Viewport copy) {
  copy.x = original.x;
  copy.y = original.y;

  copy.width  = original.width;
  copy.height = original.height;

  copy.minDepth = original.minDepth;
  copy.maxDepth = original.maxDepth;
}

int verifyInitialViewport(GraphicsDevice graphicsDevice, MockRenderingContext gl) {
  var viewport = new Viewport(graphicsDevice);

  // Make sure initial Viewport was used
  gl.getLogs(callsTo('viewport')).verify(happenedOnce);
  gl.getLogs(callsTo('depthRange', viewport.minDepth, viewport.maxDepth)).verify(happenedOnce);

  return 2;
}

int verifyViewport(MockRenderingContext gl, Viewport viewport, Viewport viewportLast, [bool copyState = true]) {
  // Check to see if the viewport dimensions changed
  if ((viewport.x      != viewportLast.x)     ||
      (viewport.y      != viewportLast.y)     ||
      (viewport.width  != viewportLast.width) ||
      (viewport.height != viewportLast.height))
  {
    gl.getLogs(callsTo('viewport', viewport.x, viewport.y, viewport.width, viewport.height)).verify(happenedOnce);
  } else {
    gl.getLogs(callsTo('viewport')).verify(neverHappened);
  }

  // Check to see if the depth changed
  if ((viewport.minDepth != viewportLast.minDepth) || (viewport.maxDepth != viewportLast.maxDepth)) {
    gl.getLogs(callsTo('depthRange', viewport.minDepth, viewport.maxDepth)).verify(happenedOnce);
  } else {
    gl.getLogs(callsTo('depthRange')).verify(neverHappened);
  }

  // Copy the state if requested
  if (copyState) {
    copyViewport(viewport, viewportLast);
  }

  // Clear the log
  int numEntries = gl.log.logs.length;
  gl.clearLogs();

  // Return the number of entries
  return numEntries;
}

void testViewportTransitions() {
  var graphicsDevice = createMockGraphicsDevice();
  var gl = graphicsDevice.gl as MockRenderingContext;
  var graphicsContext = graphicsDevice.graphicsContext;

  // Clear logs
  gl.clearLogs();

  // Create the initial viewport
  var viewport = new Viewport(graphicsDevice);

  viewport.x = 100;
  viewport.y = 100;
  viewport.width  = 800;
  viewport.height = 600;
  viewport.minDepth = 0.3;
  viewport.maxDepth = 0.7;

  graphicsContext.viewport = viewport;
  int numEntries;

  gl.getLogs(callsTo('viewport')).verify(happenedOnce);
  gl.getLogs(callsTo('depthRange')).verify(happenedOnce);

  expect(gl.log.logs.length, 2);

  gl.clearLogs();

  // Create another Viewport to provide a comparison
  var viewportLast = new Viewport(graphicsDevice);
  copyViewport(viewport, viewportLast);

  // Set the same state values again
  // This should result in zero calls
  graphicsContext.viewport = viewport;
  expect(verifyViewport(gl, viewport, viewportLast), 0);

  // Change the x
  viewport.x = 200;
  graphicsContext.viewport = viewport;
  expect(verifyViewport(gl, viewport, viewportLast), 1);

  // Change the y
  viewport.y = 200;
  graphicsContext.viewport = viewport;
  expect(verifyViewport(gl, viewport, viewportLast), 1);

  // Change the width
  viewport.width = 200;
  graphicsContext.viewport = viewport;
  expect(verifyViewport(gl, viewport, viewportLast), 1);

  // Change the height
  viewport.height = 200;
  graphicsContext.viewport = viewport;
  expect(verifyViewport(gl, viewport, viewportLast), 1);

  // Change the minDepth
  viewport.minDepth = 0.0;
  graphicsContext.viewport = viewport;
  expect(verifyViewport(gl, viewport, viewportLast), 1);

  // Change the x
  viewport.maxDepth = 1.0;
  graphicsContext.viewport = viewport;
  expect(verifyViewport(gl, viewport, viewportLast), 1);
}

void testViewport() {
  test('set viewport', () {
    testViewportTransitions();
  });
}
