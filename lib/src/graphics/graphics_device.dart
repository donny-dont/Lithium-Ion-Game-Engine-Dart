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
      _vao = GraphicsDeviceExtensions._getExtension(_gl, GraphicsDeviceExtensions.vertexArrayObject);
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
}
