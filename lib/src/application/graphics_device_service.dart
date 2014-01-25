// Copyright (c) 2012, the Lihtium-Ion Engine project authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

part of lithium_application;

/// Defines the interface for an object that manages a [GraphicsDevice].
class GraphicsDeviceManager implements Service {
  //---------------------------------------------------------------------
  // Member variables
  //---------------------------------------------------------------------

  /// The [GraphicsDevice] that the service holds.
  GraphicsDevice _graphicsDevice;

  //---------------------------------------------------------------------
  // Properties
  //---------------------------------------------------------------------

  /// The [GraphicsDevice] that the service holds.
  GraphicsDevice get graphicsDevice => _graphicsDevice;

  //---------------------------------------------------------------------
  // Public methods
  //---------------------------------------------------------------------

  /// Creates the [GraphicsDevice].
  void createDevice(Html.CanvasElement surface) {
    var config = new GraphicsDeviceConfig();
    config.debug = true;

    _graphicsDevice = new GraphicsDevice(surface, config);
  }
}
