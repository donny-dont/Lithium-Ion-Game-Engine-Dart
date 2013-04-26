// Copyright (c) 2012, the Lihtium-Ion Engine project authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

part of lithium_graphics;

/// Handles creation of graphics resources, and context creation.
///
/// A [GraphicsDevice] is created from a surface contained in a [CanvasElement]
/// with which it can render to. All [GraphicsResource]s are created by
/// a [GraphicsDevice].
///
/// Additionally a [GraphicsContext] is created by the [GraphicsDevice]. The
/// context is then used to perform all rendering to the surface.
class GraphicsDevice {
  //---------------------------------------------------------------------
  // Member variables
  //---------------------------------------------------------------------

  /// The [CanvasElement] containing the surface to draw to.
  CanvasElement _surface;
  /// The [WebGL.RenderingContext] to use.
  WebGL.RenderingContext _gl;
  /// The [WebGL.OesVertexArrayObject] extension.
  ///
  /// Used to interact with vertex array objects.
  WebGL.OesVertexArrayObject _vao;
  /// The [GraphicsContext] associated with the device.
  ///
  /// This functions as an immediate context meaning all calls are sent directly
  /// to the GPU rather than creating a command list that is then processed.
  GraphicsContext _context;
  /// The [GraphicsDeviceCapabilities] describing what GPU features are
  /// available.
  GraphicsDeviceCapabilities _capabilities;

  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  /// Initializes an instance of the [GraphicsDevice] class.
  ///
  /// A [WebGL.RenderingContext] is created from the given [surface].
  /// Additionally an optional instance of [GraphicsDeviceConfig] can be passed
  /// in to control the creation of the underlying frame buffer.
  GraphicsDevice(CanvasElement surface, [GraphicsDeviceConfig config = null]) {
    assert(surface != null);

    _surface = surface;

    if (config == null) {
      config = new GraphicsDeviceConfig();
    }

    // Get the WebGL context
    _gl = surface.getContext3d(
        depth: config.depthBuffer,
        stencil: config.stencilBuffer
     );

    if (_gl == null) {
      throw new UnsupportedError('WebGL not available');
    }

    // Query the device capabilities
    _capabilities = new GraphicsDeviceCapabilities._fromContext(_gl);

    // Create the debug context if requested
    if (config.debug) {
      _gl = new DebugRenderingContext._internal(_gl);
    }

    // Create the VAO extension if present
    if (_capabilities.hasVertexArrayObjects) {
      _vao = GraphicsDeviceCapabilities._getExtension(_gl, 'OES_vertex_array_object');
    }

    // Create the associated GraphicsContext
    _context = new GraphicsContext._internal(this);
  }

  //---------------------------------------------------------------------
  // Properties
  //---------------------------------------------------------------------

  /// The [GraphicsContext] associated with the device.
  ///
  /// This functions as an immediate context meaning all calls are sent directly
  /// to the GPU rather than creating a command list that is then processed.
  GraphicsContext get context => _context;

  /// The [GraphicsDeviceCapabilities] describing what GPU features are
  /// available.
  GraphicsDeviceCapabilities get capabilities => _capabilities;

  /// The width of the drawing surface.
  int get surfaceWidth => _surface.width;

  /// The height of the drawing surface.
  int get surfaceHeight => _surface.height;

  /// The actual width of the drawing buffer.
  ///
  /// This may differ from the [surfaceWidth] if the implementation is unable
  /// to satisfy the requested width.
  int get frontBufferWidth => _gl.drawingBufferWidth;

  /// The actual height of the drawing buffer.
  ///
  /// This may differ from the [surfaceHeight] if the implementation is unable
  /// to satisfy the requested height.
  int get frontBufferHeight => _gl.drawingBufferHeight;

  //---------------------------------------------------------------------
  // Creation methods
  //---------------------------------------------------------------------

}