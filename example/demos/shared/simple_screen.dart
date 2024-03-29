// Copyright (c) 2013-2014, the Lithium-Ion Engine project authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

part of lithium_demos;

/// The base [Screen] class of a simple demo.
///
/// Wraps common behaviors for simple demos so the implementation can be
/// expressed in the most straightforward manner.
abstract class SimpleScreen extends Screen {
  //---------------------------------------------------------------------
  // Member variables
  //---------------------------------------------------------------------

  /// The [GraphicsDevice] used by the [SimpleScreen].
  ///
  /// All [GraphicsResource]s are created through the [GraphicsDevice].
  GraphicsDevice _graphicsDevice;
  /// The [GraphicsContext] to use for rendering.
  GraphicsContext _graphicsContext;
  /// The [TextureManager] used by the [SimpleScreen].
  TextureManager _textureManager;
  /// The [Viewport] used by the [SimpleScreen].
  Viewport _viewport;
  /// Whether the [SimpleScreen] is loaded already.
  bool _isLoaded = false;

  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  SimpleScreen();

  //---------------------------------------------------------------------
  // Properties
  //---------------------------------------------------------------------

  GraphicsDevice get graphicsDevice => _graphicsDevice;
  set graphicsDevice(GraphicsDevice value) { _graphicsDevice = value; }

  //---------------------------------------------------------------------
  // Screen methods
  //---------------------------------------------------------------------

  /// Loads all resources for the [SimpleScreen].
  ///
  /// All resources required by the [SimpleScreen] should be loaded by the time
  /// the [Future] completes.
  Future<bool> onLoad() {
    if (_isLoaded) {
      return new Future.value(true);
    } else {
      // Get references to the services
      var services = application.services;
      _graphicsDevice = services.graphicsDeviceManager.graphicsDevice;
      _graphicsContext = _graphicsDevice.graphicsContext;
      _textureManager = new TextureManager(_graphicsDevice);
      _viewport = new Viewport(_graphicsDevice);

      return _onLoad();
    }
  }

  /// Unloads all resources for the [SimpleScreen].
  ///
  /// All resources loaded during [onLoad] should be disposed of by the time
  /// the method completes.
  void onUnload() {
    if (_isLoaded) {
      _onUnload();

      _isLoaded = false;
    }
  }

  /// Updates the state of the [SimpleScreen].
  void onUpdate() {
    _onUpdate();
  }

  /// Renders the [SimpleScreen].
  void onDraw() {
    _onDraw();
  }

  void onResize(int width, int height) {
    _viewport.width = width;
    _viewport.height = height;

    _graphicsContext.viewport = _viewport;
  }

  //---------------------------------------------------------------------
  // Private methods
  //---------------------------------------------------------------------

  /// Loads all resources for the [SimpleScreen].
  Future<bool> _onLoad();

  /// Unloads all resources for the [SimpleScreen].
  void _onUnload();

  /// Updates the state of the [SimpleScreen].
  void _onUpdate();

  /// Renders the [SimpleScreen].
  void _onDraw();
}
