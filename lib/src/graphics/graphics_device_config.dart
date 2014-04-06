// Copyright (c) 2013-2014, the Lithium-Ion Engine project authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

part of lithium_graphics;

/// Specifies the configuration of the [GraphicsDevice].
///
/// When creating a [WebGL.RenderingContext] there are various options that can
/// be passed in to specify the configuration. These options can only be
/// specified when the [GraphicsDevice] is created. Afterwards they cannot be
/// modified.
///
/// It should be noted that the underlying WebGL implementation takes these
/// values as a suggestion. If the underlying hardware does not support the
/// configuration it will be ignored. After creating the [GraphicsDevice] the
/// [GraphicsDeviceCapabilities] should be queried directly.
///
///     GraphicsDeviceConfig config = new GraphicsDeviceConfig();
///     config.stencilBuffer = true;
///
///     GraphicsDevice device = new GraphicsDevice(surface, config);
///
///     print('Has depth ${device.capabilities.depthBuffer}');
///     print('Has stencil ${device.capabilities.stencilBuffer}');
class GraphicsDeviceConfig {
  //---------------------------------------------------------------------
  // Member variables
  //---------------------------------------------------------------------

  /// Whether a debug context should be created.
  bool _debug = false;
  /// Whether a depth buffer should be created.
  bool _depthBuffer = true;
  /// Whether a stencil buffer should be created.
  bool _stencilBuffer = false;

  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  /// Creates an instance of the [GraphicsDeviceConfig] class.
  ///
  /// The default values of [WebGL.ContextAttributes] are used.
  ///
  ///     GraphicsDeviceConfig config = new GraphicsDeviceConfig();
  ///     config.debug = false;
  ///     config.depthBuffer = true;
  ///     config.stencilBuffer = false;
  GraphicsDeviceConfig();

  //---------------------------------------------------------------------
  // Properties
  //---------------------------------------------------------------------

  /// Whether a debug context should be created.
  bool get debug => _debug;
  set debug(bool value) { _debug = value; }

  /// Whether a depth buffer should be created.
  bool get depthBuffer => _depthBuffer;
  set depthBuffer(bool value) { _depthBuffer = value; }

  /// Whether a stencil buffer should be created.
  bool get stencilBuffer => _stencilBuffer;
  set stencilBuffer(bool value) { _stencilBuffer = value; }
}
