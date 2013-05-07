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
  GraphicsContext _graphicsContext;
  /// The [GraphicsDeviceCapabilities] describing what GPU features are
  /// available.
  GraphicsDeviceCapabilities _capabilities;
  /// The controller for the [onResourceCreated] stream.
  StreamController<ResourceCreatedEvent> _onResourceCreatedController;
  /// Event handler for when [GraphicsResource]s are created.
  Stream<ResourceCreatedEvent> _onResourceCreated;
  /// The controller for the [onResourceDestroyed] stream.
  StreamController<ResourceDestroyedEvent> _onResourceDestroyedController;
  /// Event handler for when [GraphicsResource]s are destroyed.
  Stream<ResourceDestroyedEvent> _onResourceDestroyed;

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
      //_vao = GraphicsDeviceExtensions._getExtension(_gl, GraphicsDeviceExtensions.vertexArrayObject);
    }

    // Create the resource created stream
    _onResourceCreatedController = new StreamController<ResourceCreatedEvent>();
    _onResourceCreated = _onResourceCreatedController.stream;

    // Create the resource destroyed stream
    _onResourceDestroyedController = new StreamController<ResourceDestroyedEvent>();
    _onResourceDestroyed = _onResourceDestroyedController.stream;

    // Create the associated GraphicsContext
    _graphicsContext = new GraphicsContext._internal(this);
  }

  //---------------------------------------------------------------------
  // Properties
  //---------------------------------------------------------------------

  /// The [WebGL.RenderingContext] to use.
  WebGL.RenderingContext get gl => _gl;

  /// The [GraphicsContext] associated with the device.
  ///
  /// This functions as an immediate context meaning all calls are sent directly
  /// to the GPU rather than creating a command list that is then processed.
  GraphicsContext get graphicsContext => _graphicsContext;

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

  /// Event handler for when [GraphicsResource]s are created.
  ///
  /// By subscribing to the [onResourceCreated] and [onResourceDestroyed] events
  /// it can be verified that all resources are properly disposed of.
  Stream<ResourceCreatedEvent> get onResourceCreated => _onResourceCreated;

  /// Event handler for when [GraphicsResource]s are destroyed.
  ///
  /// By subscribing to the [onResourceCreated] and [onResourceDestroyed] events
  /// it can be verified that all resources are properly disposed of.
  Stream<ResourceDestroyedEvent> get onResourceDestroyed => _onResourceDestroyed;

  //---------------------------------------------------------------------
  // Event callbacks
  //---------------------------------------------------------------------

  /// Notify that a [GraphicsResource] has been created.
  void _notifyResourceCreated(GraphicsResource resource) {
    if (!_onResourceCreatedController.isPaused) {
      _onResourceCreatedController.add(new ResourceCreatedEvent._internal(resource));
    }
  }

  /// Notify that a [GraphicsResource] has been destroyed.
  void _notifyResourceDestroyed(GraphicsResource resource) {
    if (!_onResourceDestroyedController.isPaused) {
      _onResourceDestroyedController.add(new ResourceDestroyedEvent._internal(resource));
    }
  }

  //---------------------------------------------------------------------
  // Binding methods
  //---------------------------------------------------------------------

  /// Binds a [GraphicsResource] to the [GraphicsDevice].
  ///
  /// Used for [GraphicsResource]s that do not require a binding to the
  /// underlying [WebGL] implementation.
  void _createWithoutBinding(GraphicsResource resource) {
    _notifyResourceCreated(resource);
  }

  /// Releases a [GraphicsResource] from the [GraphicsDevice].
  ///
  /// Used for [GraphicsResource]s that do not require a binding to the
  /// underlying [WebGL] implementation.
  void _destroyWithoutBinding(GraphicsResource resource) {
    _notifyResourceDestroyed(resource);
  }

  /// Binds an [IndexBuffer] to the [GraphicsDevice].
  void _createIndexBuffer(IndexBuffer resource) {
    // Check that the unsigned int extension is available if the resource uses it
    assert(resource.indexElementSize == IndexElementSize.Short || _capabilities.hasUnsignedIntIndices);

    resource._binding = _gl.createBuffer();

    _notifyResourceCreated(resource);
  }

  /// Releases a [IndexBuffer] from the [GraphicsDevice].
  void _destroyIndexBuffer(IndexBuffer resource) {
    _gl.deleteBuffer(resource._binding);
    resource._binding = null;

    _notifyResourceDestroyed(resource);
  }

  /// Binds a [VertexBuffer] to the [GraphicsDevice].
  void _createVertexBuffer(VertexBuffer resource) {
    resource._binding = _gl.createBuffer();

    _notifyResourceCreated(resource);
  }

  /// Releases a [VertexBuffer] from the [GraphicsDevice].
  void _destroyVertexBuffer(VertexBuffer resource) {
    _gl.deleteBuffer(resource._binding);
    resource._binding = null;

    _notifyResourceDestroyed(resource);
  }

  /// Binds a [Mesh] to the [GraphicsDevice].
  void _createMesh(Mesh resource) {
    if (_vao != null) {
      resource._binding = _vao.createVertexArray();
    }

    _notifyResourceCreated(resource);
  }

  /// Releases a [Mesh] from the [GraphicsDevice].
  void _destroyMesh(Mesh resource) {
    if (_vao != null) {
      _vao.deleteVertexArray(resource._binding);

      resource._binding = null;
    }

    _notifyResourceDestroyed(resource);
  }

  /// Binds an [EffectPass] to the [GraphicsDevice].
  void _createEffectPass(EffectPass resource, String vertexSource, String fragmentSource) {
    // Create the binding
    var program = _gl.createProgram();

    // Create the vertex shader
    var vertexShader = _gl.createShader(WebGL.VERTEX_SHADER);

    _gl.shaderSource(vertexShader, vertexSource);
    _gl.compileShader(vertexShader);

    bool vertexCompiled = _gl.getShaderParameter(vertexShader, WebGL.COMPILE_STATUS);

    var vertexShaderLog = (!vertexCompiled) ? _gl.getShaderInfoLog(vertexShader) : '';

    // Create the fragment shader
    var fragmentShader = _gl.createShader(WebGL.FRAGMENT_SHADER);

    _gl.shaderSource(fragmentShader, fragmentSource);
    _gl.compileShader(fragmentShader);

    bool fragmentCompiled = _gl.getShaderParameter(fragmentShader, WebGL.COMPILE_STATUS);

    var fragmentShaderLog = (!fragmentCompiled) ? _gl.getShaderInfoLog(fragmentShader) : '';

    // Check the compilation
    if ((vertexCompiled) && (fragmentCompiled)) {
      // Attach the shaders
      _gl.attachShader(program, vertexShader);
      _gl.attachShader(program, fragmentShader);

      _gl.linkProgram(program);

      bool programLinked = _gl.getProgramParameter(program, WebGL.LINK_STATUS);

      if (programLinked) {
        int attributeCount = _gl.getProgramParameter(program, WebGL.ACTIVE_ATTRIBUTES);

        for (int i = 0; i < attributeCount; ++i) {
          var info = _gl.getActiveAttrib(program, i);

          print(info.name);
          print(info.size);
          print(info.type);
        }

        var uniformCount = _gl.getProgramParameter(program, WebGL.ACTIVE_UNIFORMS);

        for (int i = 0; i < uniformCount; ++i) {
          var info = _gl.getActiveUniform(program, i);

          print(info.name);
          print(info.size);
          print(info.type);
        }
      }
      //var programLog = (!programLinked) ? _gl.getProgramInfoLog(program) : '';


    } else {

    }

    // Delete the shader objects
    // After they are attached to the program they are no longer needed
    _gl.deleteShader(vertexShader);
    _gl.deleteShader(fragmentShader);

    // Associate the binding
    resource._binding = program;
  }

  /// Releases an [EffectPass] from the [GraphicsDevice].
  void _destroyEffectPass(EffectPass resource) {
    _gl.deleteProgram(resource._binding);
    resource._binding = null;

    _notifyResourceDestroyed(resource);
  }
}
