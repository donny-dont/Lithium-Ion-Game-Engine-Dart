// Copyright (c) 2013-2014, the Lithium-Ion Engine Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

part of lithium_graphics;

/// Contains depth-stencil state for the device.
class DepthStencilState extends GraphicsResource {
  //---------------------------------------------------------------------
  // Member variables
  //---------------------------------------------------------------------

  /// Whether depth buffering is enabled or disabled.
  ///
  /// The default is true.
  bool depthBufferEnabled = true;
  /// Whether writing to the depth buffer is enabled or disabled.
  ///
  /// The default is true.
  bool depthBufferWriteEnabled = true;
  /// The comparison function for the depth-buffer test.
  ///
  /// The default is CompareFunction.LessEqual.
  CompareFunction depthBufferFunction = CompareFunction.LessEqual;

  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  /// Creates an instance of the [DepthStencilState] class.
  DepthStencilState(GraphicsDevice device)
    : super._internalWithoutBinding(device);

  /// Creates an instance of [DepthState] with a writable depth buffer.
  DepthStencilState.depthWrite(String name, GraphicsDevice device)
    : super._internalWithoutBinding(device)
    , depthBufferEnabled = true
    , depthBufferWriteEnabled = true;

  /// Creates an instance of [DepthState] with a read-only depth buffer.
  DepthStencilState.depthRead(String name, GraphicsDevice device)
    : super._internalWithoutBinding(device)
    , depthBufferEnabled = true
    , depthBufferWriteEnabled = false;

  /// Creates an instance of [DepthState] which doesn't use a depth buffer.
  DepthStencilState.none(String name, GraphicsDevice device)
    : super._internalWithoutBinding(device)
    , depthBufferEnabled = false
    , depthBufferWriteEnabled = false;
}
