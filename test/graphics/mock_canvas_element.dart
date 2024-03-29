// Copyright (c) 2013-2014, the Lithium-Ion Engine Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

part of graphics_mocks;

@proxy
class MockCanvasElement extends Mock implements CanvasElement {
  MockCanvasElement() {
    when(callsTo('getContext3d')).alwaysReturn(new MockRenderingContext());
  }

  MockCanvasElement.noExtensions() {
    var extensions = [];

    when(callsTo('getContext3d')).alwaysReturn(new MockRenderingContext(extensions));
  }

  MockCanvasElement.specifyExtensions(List extensions) {
    when(callsTo('getContext3d')).alwaysReturn(new MockRenderingContext(extensions));
  }

  // Present to remove analyzer errors
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
