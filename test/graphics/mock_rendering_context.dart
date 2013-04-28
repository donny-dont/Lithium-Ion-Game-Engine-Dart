// Copyright (c) 2013, the Lihtium-Ion Engine Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

part of graphics_mocks;

class MockBuffer implements WebGL.Buffer { }

class MockContextAttributes implements WebGL.ContextAttributes {
  bool alpha = true;
  bool depth = true;
  bool stencil = false;
  bool antialias = true;
  bool premultipliedAlpha = true;
  bool preserveDrawingBuffer = false;
}

class MockRenderingContext extends Mock implements WebGL.RenderingContext {
  MockRenderingContext() {
    when(callsTo('getParameter')).alwaysReturn(4);
    when(callsTo('getExtension')).alwaysReturn(null);
    when(callsTo('getContextAttributes')).alwaysReturn(new MockContextAttributes());

    when(callsTo('createBuffer')).alwaysReturn(new MockBuffer());
  }
}
