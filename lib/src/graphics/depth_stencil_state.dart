// Copyright (c) 2013, the Lihtium-Ion Engine Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

part of lithium_graphics;

/// Contains depth-stencil state for the device.
class DepthStencilState extends GraphicsResource {
  //---------------------------------------------------------------------
  // Member variables
  //---------------------------------------------------------------------

  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  /// Creates an instance of the [DepthStencilState] class.
  DepthStencilState(GraphicsDevice device)
    : super._internal(device)
  {
    _graphicsDevice._createWithoutBinding(this);
  }

  //---------------------------------------------------------------------
  // Public methods
  //---------------------------------------------------------------------

  /// Immediately releases the unmanaged resources used by this object.
  void dispose() {
    _graphicsDevice._destroyWithoutBinding(this);
  }
}
