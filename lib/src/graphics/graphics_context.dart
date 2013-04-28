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
  GraphicsDevice _graphicsDevice;

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
  // Buffer variables
  //---------------------------------------------------------------------

  /// The currently bound [VertexBuffer].
  VertexBuffer _vertexBuffer;

  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  /// Creates an instance of the [GraphicsContext] class.
  ///
  /// A [GraphicsContext] can not be created directly. A [GraphicsDevice] must
  /// be involved in the creation of the context.
  GraphicsContext._internal(GraphicsDevice device)
      : _graphicsDevice = device
      , _gl = device._gl
      , _vao = device._vao
  {
    _initializeState();
  }

  /// Initialize the WebGL pipeline state.
  /// Creates all the default state values and applies them to the pipeline.
  void _initializeState() {
    // Viewport setup
    _viewport = new Viewport(_graphicsDevice);

    _gl.viewport(_viewport.x, _viewport.y, _viewport.width, _viewport.height);
    _gl.depthRange(_viewport.minDepth, _viewport.maxDepth);
  }

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

  //---------------------------------------------------------------------
  // Buffer methods
  //---------------------------------------------------------------------

  /// Binds the [VertexBuffer] to the pipeline.
  void _bindVertexBuffer(VertexBuffer buffer) {
    if (_vertexBuffer != buffer) {
      assert(buffer._binding != null);
      _gl.bindBuffer(WebGL.ARRAY_BUFFER, buffer._binding);

      _vertexBuffer = buffer;
    }
  }

  /// Sets the entire contents of the [buffer] with the values contained in [data].
  void _setVertexBufferData(VertexBuffer buffer, TypedData data) {
    _bindVertexBuffer(buffer);

    _gl.bufferData(WebGL.ARRAY_BUFFER, data, buffer._bufferUsage);
  }

  /// Replaces a portion of the buffer with the values contained in [data].
  ///
  /// The contents are replaced starting at the [offset] in bytes up to the size
  /// of the [data] array.
  void _replaceVertexBufferData(VertexBuffer buffer, TypedData data, int offset) {
    _bindVertexBuffer(buffer);

    _gl.bufferSubData(WebGL.ARRAY_BUFFER, offset, data);
  }
}
