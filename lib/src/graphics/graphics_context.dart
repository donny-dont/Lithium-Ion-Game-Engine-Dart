// Copyright (c) 2012, the Lihtium-Ion Engine project authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

part of lithium_graphics;

/// The [GraphicsContext] configures the GPU pipeline and executes draw commands.
class GraphicsContext {

  //---------------------------------------------------------------------
  // WebGL variables
  //---------------------------------------------------------------------

  /// The [WebGL.RenderingContext] to use.
  WebGL.RenderingContext _gl;
  /// The [WebGL.OesVertexArrayObject] extension.
  ///
  /// Used to interact with vertex array objects.
  WebGL.OesVertexArrayObject _vao;

  //---------------------------------------------------------------------
  // Member variable
  //---------------------------------------------------------------------

  /// The [GraphicsDevice] that created the context.
  GraphicsDevice _device;

  //---------------------------------------------------------------------
  // Clear variables
  //---------------------------------------------------------------------

  /// The current color that the color buffer is set to on clear.
  vec4 _clearColor = new vec4(0.0, 0.0, 0.0, 1.0);
  /// The current value to set the depth buffer to on clear.
  double _clearDepth = 0.0;
  /// The current value to set the stencil buffer to on clear.
  int _clearStencil = 0;

  //---------------------------------------------------------------------
  // State variables
  //---------------------------------------------------------------------

  /// The current [Viewport] of the pipeline.
  Viewport _viewport;

  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  /// Creates an instance of the [GraphicsContext] class.
  ///
  /// A [GraphicsContext] can not be created directly. A [GraphicsDevice] must
  /// be involved in the creation of the context.
  GraphicsContext._internal(GraphicsDevice device)
      : _device = device
      , _gl = device._gl
      , _vao = device._vao;

  //---------------------------------------------------------------------
  // State properties
  //---------------------------------------------------------------------

  /// Sets a [Viewport] identifying the portion of the render target to receive draw calls.
  set viewport(Viewport value) {
    if (value == null) {
      return;
    }

    if ((_viewport.x      != value.x)     ||
        (_viewport.y      != value.y)     ||
        (_viewport.width  != value.width) ||
        (_viewport.height != value.height))
    {
      _gl.viewport(value.x, value.y, value.width, value.height);

      _viewport.x      = value.x;
      _viewport.y      = value.y;
      _viewport.width  = value.width;
      _viewport.height = value.height;
    }

    if ((_viewport.minDepth != value.minDepth) ||
        (_viewport.maxDepth != value.maxDepth))
    {
      _gl.depthRange(value.minDepth, value.maxDepth);

      _viewport.minDepth = value.minDepth;
      _viewport.maxDepth = value.maxDepth;
    }
  }
}
