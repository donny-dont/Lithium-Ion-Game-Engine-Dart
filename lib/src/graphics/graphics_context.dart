// Copyright (c) 2013-2014, the Lithium-Ion Engine project authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

part of lithium_graphics;

/// The [GraphicsContext] configures the GPU pipeline and executes draw commands.
class GraphicsContext {
  //---------------------------------------------------------------------
  // Vertex attribute state variables
  //---------------------------------------------------------------------

  /// The vertex attribute has been disabled.
  static const int _attributeDisabled = 0;
  /// The vertex attribute is enabled.
  static const int _attributeEnabled = 1;
  /// The vertex attribute was just used.
  static const int _attributeUsed = 2;

  /// Non instance data within the buffer.
  static const int _perVertexData = 0;

  //---------------------------------------------------------------------
  // WebGL variables
  //---------------------------------------------------------------------

  /// The [WebGL.RenderingContext] to use.
  WebGL.RenderingContext _gl;
  /// The [WebGL.OesVertexArrayObject] extension.
  ///
  /// Used to interact with vertex array objects.
  WebGL.OesVertexArrayObject _vao;
  /// The [WebGL.AngleInstancedArrays] extension.
  ///
  /// Used to provide instanced rendering.
  WebGL.AngleInstancedArrays _instancedArrays;

  //---------------------------------------------------------------------
  // Member variable
  //---------------------------------------------------------------------

  /// The [GraphicsDevice] that created the context.
  GraphicsDevice _graphicsDevice;

  //---------------------------------------------------------------------
  // Clear variables
  //---------------------------------------------------------------------

  /// The current color that the color buffer is set to on clear.
  Vector4 _clearColor = new Vector4(0.0, 0.0, 0.0, 0.0);
  /// The current value to set the depth buffer to on clear.
  double _clearDepth = 0.0;
  /// The current value to set the stencil buffer to on clear.
  int _clearStencil = 0;

  //---------------------------------------------------------------------
  // Default variables
  //---------------------------------------------------------------------

  /// The default [BlendState] to use.
  ///
  /// Constructed with the values in [BlendState.opaque].
  BlendState _blendStateDefault;
  /// The default [DepthStencilState] to use.
  ///
  /// Constructed with the values in [DepthStencilState.default].
  DepthStencilState _depthStencilStateDefault;
  /// The default [RasterizerState] to use.
  ///
  /// Constructed with the values in [RasterizerState.cullClockwise].
  RasterizerState _rasterizerStateDefault;

  //---------------------------------------------------------------------
  // State variables
  //---------------------------------------------------------------------

  /// The current [RasterizerState] of the pipeline.
  RasterizerState _rasterizerState;
  /// The current [Viewport] of the pipeline.
  Viewport _viewport;

  //---------------------------------------------------------------------
  // VertexDeclaration variables
  //---------------------------------------------------------------------

  /// The currently bound [VertexDeclaration].
  VertexDeclaration _boundVertexDeclaration;
  /// The [VertexDeclaration] to bind.
  VertexDeclaration _vertexDeclaration;
  /// The state of the vertex attributes.
  List<int> _vertexAttributeState;
  /// The instance step rate.
  List<int> _vertexAttributeInstanceStepRate;

  //---------------------------------------------------------------------
  // VertexBuffer variables
  //---------------------------------------------------------------------

  /// The currently bound [VertexBuffer].
  VertexBuffer _boundVertexBuffer;
  /// The list of bound [VertexBuffer]s.
  ///
  /// Used to determine if the buffers should be rebound.
  List<VertexBuffer> _boundVertexBuffers;
  /// The list of [VertexBuffer]s to bind.
  ///
  /// The buffers are not bound until a draw call is encountered. Until then
  /// they are kept in this list.
  List<VertexBuffer> _vertexBuffers;
  /// The number of [VertexBuffer]s requested for binding.
  ///
  /// Keeps track of the number of buffers being bound. This is because the list
  /// of vertex buffers are copied into the list of buffers to bind.
  int _vertexBufferCount;

  //---------------------------------------------------------------------
  // IndexBuffer variables
  //---------------------------------------------------------------------

  /// The currently bound [IndexBuffer].
  IndexBuffer _boundIndexBuffer;
  /// The [IndexBuffer] to bind.
  IndexBuffer _indexBuffer;

  //---------------------------------------------------------------------
  // Mesh variables
  //---------------------------------------------------------------------

  /// The currently bound [Mesh].
  ///
  /// This value is only set if a [WebGL.VertexArrayObject] is available as
  /// there is no optimization opportunity otherwise.
  Mesh _boundMesh;
  /// The [Mesh] to bind.
  ///
  /// This value is only set if a [WebGL.VertexArrayObject] is available as
  /// there is no optimization opportunity otherwise.
  Mesh _mesh;

  //---------------------------------------------------------------------
  // EffectPass variables
  //---------------------------------------------------------------------

  /// The currently bound [EffectPass].
  EffectPass _boundEffectPass;
  /// The [EffectPass] to bind.
  EffectPass _effectPass;

  //---------------------------------------------------------------------
  // Texture variables
  //---------------------------------------------------------------------

  /// The currently bound [Texture]s.
  List<Texture> _boundTextures;
  /// The active texture unit.
  int _activeTextureUnit;

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
      , _instancedArrays = device._instancedArrays
  {
    var capabilities = _graphicsDevice.capabilities;

    // Create the vertex buffer slots
    // Use the max number of vertex attributes as you could potentially
    // have all the slots in separate buffers.
    int vertexBufferSlots = capabilities.maxVertexAttribs;
    _boundVertexBuffers = new List<VertexBuffer>(vertexBufferSlots);
    _vertexBuffers      = new List<VertexBuffer>(vertexBufferSlots);

    // Create the current attribute state
    // Initially all vertex attributes are disabled
    _vertexAttributeState = new List<int>.filled(vertexBufferSlots, _attributeDisabled);
    _vertexAttributeInstanceStepRate = new List<int>.filled(vertexBufferSlots, _perVertexData);

    // Create the texture units
    _boundTextures = new List<Texture>(capabilities.textureUnits);
    _activeTextureUnit = 0;

    _initializeState();
  }

  /// Initialize the WebGL pipeline state.
  /// Creates all the default state values and applies them to the pipeline.
  void _initializeState() {
    // Viewport setup
    _viewport = new Viewport(_graphicsDevice);

    _gl.viewport(_viewport.x, _viewport.y, _viewport.width, _viewport.height);
    _gl.depthRange(_viewport.minDepth, _viewport.maxDepth);

    _gl.enable(WebGL.DEPTH_TEST);
    _gl.frontFace(WebGL.CCW);
    _gl.cullFace(WebGL.BACK);
  }

  //---------------------------------------------------------------------
  // State properties
  //---------------------------------------------------------------------

  /// Sets the color to clear the color buffer with.
  set clearColor(Vector4 value) {
    if (!isVector4Equal(_clearColor, value)) {
      value.copyInto(_clearColor);

      _gl.clearColor(value.r, value.g, value.b, value.a);
    }
  }

  /// Sets the current [BlendState] to use on the pipeline.
  ///
  /// If the [value] is null all values of the pipeline associated with
  /// blending will be reset to their defaults.
  set blendState(BlendState value) {
    if (value == null) {
      blendState = _blendStateDefault;
      return;
    }
  }

  /// Sets the current [DepthStencilState] to use on the pipeline.
  ///
  /// If the [value] is null all values of the pipeline associated with the
  /// depth and stencil buffer will be reset to their defaults.
  set depthStencilState(DepthStencilState value) {
    if (value == null) {
      depthStencilState = _depthStencilStateDefault;
      return;
    }
  }

  /// Sets the current [RasterizerState] to use on the pipeline.
  ///
  /// If the [value] is null all values of the pipeline associated with
  /// rasterization will be reset to their defaults.
  set rasterizerState(RasterizerState value) {
    if (value == null) {
      rasterizerState = _rasterizerStateDefault;
      return;
    }

    // Disable/Enable culling if necessary
    var cullMode = value.cullMode,
        currentCullMode = _rasterizerState.cullMode,
        cullModeChanged = cullMode != currentCullMode;

    if (cullModeChanged) {
      if (cullMode == CullMode.None) {
        _gl.disable(WebGL.CULL_FACE);
      } else if (currentCullMode == CullMode.None) {
        _gl.enable(WebGL.CULL_FACE);
      }

      _rasterizerState.cullMode = cullMode;
    }

    // If culling is enabled enable culling mode and winding order
    if (cullMode != CullMode.None) {
      // Modify the cull mode if necessary
      if (cullModeChanged) {
        _gl.cullFace(_cullModeToWebGL(cullMode));

        _rasterizerState.cullMode = cullMode;
      }

      // Modify the front face if necessary
      var frontFace = value.frontFace,
          currentFrontFace = _rasterizerState.frontFace;

      if (frontFace != currentFrontFace) {
        _gl.frontFace(_frontFaceToWebGL(frontFace));

        _rasterizerState.frontFace = frontFace;
      }
    }

    // Check for a polygon offset
    var depthBias = value.depthBias,
        slopeScaleDepthBias = value.slopeScaleDepthBias,
        offsetEnabled = ((depthBias != 0.0) || (slopeScaleDepthBias != 0.0)),
        currentDepthBias = _rasterizerState.depthBias,
        currentSlopeScaleDepthBias = _rasterizerState.slopeScaleDepthBias,
        currentOffsetEnabled = ((currentDepthBias != 0.0) || (currentSlopeScaleDepthBias != 0.0));

    if (offsetEnabled) {
      // Enable polygon offset
      if (!currentOffsetEnabled) {
        _gl.enable(WebGL.POLYGON_OFFSET_FILL);
      }

      // Modify the polygon offset if necessary
      if ((depthBias           != currentDepthBias) ||
          (slopeScaleDepthBias != currentSlopeScaleDepthBias))
      {
        _gl.polygonOffset(depthBias, slopeScaleDepthBias);

        _rasterizerState.depthBias           = depthBias;
        _rasterizerState.slopeScaleDepthBias = slopeScaleDepthBias;
      }
    } else {
      // Disable polygon offset
      if (!currentOffsetEnabled) {
        _gl.disable(WebGL.POLYGON_OFFSET_FILL);

        _rasterizerState.depthBias           = depthBias;
        _rasterizerState.slopeScaleDepthBias = slopeScaleDepthBias;
      }
    }

    // Disable/Enable scissor test if necessary
    var scissorTestEnabled = value.scissorTestEnabled;

    if (scissorTestEnabled != _rasterizerState.scissorTestEnabled) {
      if (scissorTestEnabled) {
        _gl.enable(WebGL.SCISSOR_TEST);
      } else {
        _gl.disable(WebGL.SCISSOR_TEST);
      }

      _rasterizerState.scissorTestEnabled = scissorTestEnabled;
    }
  }

  /// Sets a [Viewport] identifying the portion of the render target to receive draw calls.
  set viewport(Viewport value) {
    if (value == null) {
      return;
    }

    // Set the viewport values
    var x = value.x,
    y = value.y,
    width = value.width,
    height = value.height;

    if ((x      != _viewport.x)     ||
    (y      != _viewport.y)     ||
    (width  != _viewport.width) ||
    (height != _viewport.height))
    {
      _gl.viewport(x, y, width, height);

      _viewport.x      = x;
      _viewport.y      = y;
      _viewport.width  = width;
      _viewport.height = height;
    }

    // Set the depth values
    var minDepth = value.minDepth,
    maxDepth = value.maxDepth;

    if ((minDepth != _viewport.minDepth) ||
    (maxDepth != _viewport.maxDepth))
    {
      _gl.depthRange(minDepth, maxDepth);

      _viewport.minDepth = minDepth;
      _viewport.maxDepth = maxDepth;
    }
  }

  /// Sets an [EffectPass] that controls rendering.
  set effectPass(EffectPass value) {
    _effectPass = value;
  }

  //---------------------------------------------------------------------
  // Clear methods
  //---------------------------------------------------------------------

  void clearBuffers() {
    _gl.clear(WebGL.COLOR_BUFFER_BIT | WebGL.DEPTH_BUFFER_BIT | WebGL.STENCIL_BUFFER_BIT);
  }

  //---------------------------------------------------------------------
  // Vertex/Index methods
  //---------------------------------------------------------------------

  /// Sets the [VertexDeclaration] to use.
  void setVertexDeclaration(VertexDeclaration declaration) {
    _vertexDeclaration = declaration;
  }

  /// Sets the [VertexBuffer]s to use.
  void setVertexBuffers(List<VertexBuffer> buffers) {
    assert(buffers.length < _vertexBuffers.length);

    // Keep track of the number of buffers requested
    _vertexBufferCount = buffers.length;

    // Copy the vertex buffers into the list
    for (int i = 0; i < _vertexBufferCount; ++i) {
      _vertexBuffers[i] = buffers[i];
    }

    // Null out the rest of the values
    int vertexBufferSlots = _vertexBuffers.length;

    for (int i = _vertexBufferCount; i < vertexBufferSlots; ++i) {
      _vertexBuffers[i] = null;
    }
  }

  /// Sets an individual [VertexBuffer] to the given [slot].
  void setVertexBuffer(VertexBuffer buffer, int slot) {
    assert(slot < _vertexBuffers.length);

    // Keep track of the number of buffers requested
    _vertexBufferCount = Math.max(_vertexBufferCount, slot);

    // Assign the buffer to the slot
    _vertexBuffers[slot] = buffer;
  }

  /// Sets the [IndexBuffer] to use.
  void setIndexBuffer(IndexBuffer buffer) {
    _indexBuffer = buffer;
  }

  /// Sets the [Mesh] to use.
  void setMesh(Mesh mesh) {
    if (mesh._binding != null) {
      // VertexArrayObject is available
      _mesh = mesh;
    } else {
      // Set the individual components
      setVertexDeclaration(mesh._vertexDeclaration);
      setVertexBuffers(mesh._vertexBuffers);
      setIndexBuffer(mesh._indexBuffer);
    }
  }

  //---------------------------------------------------------------------
  // Drawing methods
  //---------------------------------------------------------------------

  void drawVertexPrimitiveRange(int primitiveType, int offset, int count) {
    assert(PrimitiveType.isValid(primitiveType));

    if (_shouldBindVertexData()) {
      _setupVertexData();
    }

    _bindEffectPass(_effectPass);
    _setEffectParameters();

    _gl.drawArrays(primitiveType, offset, count);
  }

  void drawIndexedPrimitives(int primitiveType) {
    assert(PrimitiveType.isValid(primitiveType));
    assert((_indexBuffer != null) || ((_mesh != null) && (_mesh._indexBuffer != null)));

    if (_shouldBindVertexData()) {
      _setupVertexData();
    }

    _bindEffectPass(_effectPass);
    _setEffectParameters();

    var indexBuffer = (_boundMesh != null)
        ? _mesh._indexBuffer
        : _indexBuffer;

    _gl.drawElements(
        primitiveType,
        indexBuffer.indexCount,
        _indexElementSizeToWebGL(indexBuffer.indexElementSize),
        0
    );
  }

  void drawIndexedPrimitiveRange(int primitiveType, int offset, int count) {
    assert(PrimitiveType.isValid(primitiveType));
    assert((_indexBuffer != null) || ((_mesh != null) && (_mesh._indexBuffer != null)));

    if (_shouldBindVertexData()) {
      _setupVertexData();
    }

    _bindEffectPass(_effectPass);
    _setEffectParameters();

    var indexBuffer = (_boundMesh != null)
        ? _mesh._indexBuffer
        : _indexBuffer;

    _gl.drawElements(
        primitiveType,
        count,
        _indexElementSizeToWebGL(indexBuffer.indexElementSize),
        offset
    );
  }

  void drawInstancedPrimitives(int primitiveType, int offset, int count) {
    assert(_instancedArrays != null);
    assert(PrimitiveType.isValid(primitiveType));
    assert((_indexBuffer != null) || ((_mesh != null) && (_mesh._indexBuffer != null)));

    if (_shouldBindVertexData()) {
      _setupVertexData();

      this._printVertexAttribState();
    }

    _bindEffectPass(_effectPass);
    _setEffectParameters();

    var indexBuffer = (_boundMesh != null)
        ? _mesh._indexBuffer
        : _indexBuffer;

    _instancedArrays.drawElementsInstancedAngle(
        primitiveType,
        indexBuffer.indexCount,
        _indexElementSizeToWebGL(indexBuffer.indexElementSize),
        offset,
        count
    );
  }

  //---------------------------------------------------------------------
  // Drawing internal methods
  //---------------------------------------------------------------------

  /// Determines if the vertex data should be bound.
  bool _shouldBindVertexData() {
    // Check for VertexArrayObject
    if (_mesh != null) {
      return _boundMesh != _mesh;
    }

    // Check the vertex declaration
    if (_boundVertexDeclaration == _vertexDeclaration) {
      // See if the vertex buffers have changed
      for (int i = 0; i < _vertexBufferCount; ++i) {
        if (_boundVertexBuffers[i] != _vertexBuffers[i]) {
          return true;
        }
      }

      return false;
    } else {
      return true;
    }
  }

  /// Sets up all vertex data for rendering.
  void _setupVertexData() {
    if (_mesh != null) {
      _bindMeshData();
    } else {
      _bindVertexData();
    }
  }

  /// Binds vertex data to the pipeline.
  void _bindVertexData() {
    // Setup the VertexDeclaration
    var elements = _vertexDeclaration._elements;
    int elementCount = elements.length;

    for (int i = 0; i < elementCount; ++i) {
      var element = elements[i];

      // Bind the VertexBuffer
      int slot = element.slot;

      var buffer = _vertexBuffers[slot];
      assert(buffer != null);

      _bindVertexBuffer(buffer);
      _boundVertexBuffers[slot] = buffer;

      // Bind the attribute index if necessary
      int attributeIndex = element._vertexAttribIndex;

      if (_vertexAttributeState[attributeIndex] == _attributeDisabled) {
        _gl.enableVertexAttribArray(attributeIndex);
      }

      _vertexAttributeState[attributeIndex] = _attributeUsed;

      // Setup the attribute pointer
      _gl.vertexAttribPointer(
          attributeIndex,
          element.format.index + 1,
          WebGL.FLOAT,
          false,
          _vertexDeclaration.getStride(slot),
          element.offset
      );

      int instanceDataStepRate = element.instanceDataStepRate;

      // Setup instancing if necessary
      if (_vertexAttributeInstanceStepRate[attributeIndex] != instanceDataStepRate) {
        assert(_instancedArrays != null);

        _instancedArrays.vertexAttribDivisorAngle(attributeIndex, instanceDataStepRate);
        _vertexAttributeInstanceStepRate[attributeIndex] = instanceDataStepRate;
      }
    }

    // Disable any attributes that were not used on this pass
    int attributeCount = _vertexAttributeState.length;

    for (int i = 0; i < attributeCount; ++i) {
      int state = _vertexAttributeState[i];

      if (state == _attributeUsed) {
        _vertexAttributeState[i] = _attributeEnabled;
      } else if (state == _attributeEnabled) {
        _gl.disableVertexAttribArray(i);

        _vertexAttributeState[i] = _attributeDisabled;
      }
    }

    this._printVertexAttribState();

    // The VertexDeclaration is bound to the pipeline
    _boundVertexDeclaration = _vertexDeclaration;

    // Bind the index data
    _bindIndexBuffer(_indexBuffer);
  }

  void _bindMeshData() {
    if (_boundMesh != _mesh) {
      var binding = (_mesh != null) ? _mesh._binding : null;
      _vao.bindVertexArray(binding);

      _boundMesh = _mesh;
    }
  }

  /// Binds the [Mesh] to the pipeline
  void _bindMesh(Mesh mesh) {
    if (_boundMesh != mesh) {
      var binding = (mesh != null) ? mesh._binding : null;
      _vao.bindVertexArray(binding);

      _boundMesh = mesh;
    }
  }

  //---------------------------------------------------------------------
  // IndexBuffer internal methods
  //---------------------------------------------------------------------

  /// Binds the [IndexBuffer] to the pipeline.
  void _bindIndexBuffer(IndexBuffer buffer) {
    if (_boundIndexBuffer != buffer) {
      var binding = (buffer != null) ? buffer._binding : null;
      _gl.bindBuffer(WebGL.ELEMENT_ARRAY_BUFFER, binding);

      _boundIndexBuffer = buffer;
    }
  }

  /// Sets _boundIndexBufferontents of the [buffer] with the values contained in [data].
  void _setIndexBufferData(IndexBuffer buffer, TypedData data) {
    _bindIndexBuffer(buffer);

    _gl.bufferDataTyped(
        WebGL.ELEMENT_ARRAY_BUFFER,
        data,
        _bufferUsageToWebGL(buffer.bufferUsage)
    );
  }

  /// Replaces a portion of the buffer with the values contained in [data].
  ///
  /// The contents are replaced starting at the [offset] in bytes up to the size
  /// of the [data] array.
  void _replaceIndexBufferData(IndexBuffer buffer, TypedData data, int offset) {
    _bindIndexBuffer(buffer);

    _gl.bufferSubDataTyped(WebGL.ELEMENT_ARRAY_BUFFER, offset, data);
  }

  //---------------------------------------------------------------------
  // VertexBuffer internal methods
  //---------------------------------------------------------------------

  /// Binds the [VertexBuffer] to the pipeline.
  void _bindVertexBuffer(VertexBuffer buffer) {
    if (_boundVertexBuffer != buffer) {
      assert(buffer._binding != null);
      _gl.bindBuffer(WebGL.ARRAY_BUFFER, buffer._binding);

      _boundVertexBuffer = buffer;
    }
  }

  /// Sets the entire contents of the [buffer] with the values contained in [data].
  void _setVertexBufferData(VertexBuffer buffer, TypedData data) {
    _bindVertexBuffer(buffer);

    _gl.bufferDataTyped(
        WebGL.ARRAY_BUFFER,
        data,
        _bufferUsageToWebGL(buffer.bufferUsage)
    );
  }

  /// Replaces a portion of the buffer with the values contained in [data].
  ///
  /// The contents are replaced starting at the [offset] in bytes up to the size
  /// of the [data] array.
  void _replaceVertexBufferData(VertexBuffer buffer, TypedData data, int offset) {
    _bindVertexBuffer(buffer);

    _gl.bufferSubDataTyped(WebGL.ARRAY_BUFFER, offset, data);
  }

  //---------------------------------------------------------------------
  // Mesh internal methods
  //---------------------------------------------------------------------

  void _setMeshData(Mesh mesh) {
    assert(_vao != null);

    _bindMesh(mesh);

    var vertexDeclaration = mesh._vertexDeclaration;

    // Setup the VertexDeclaration
    var elements = vertexDeclaration._elements;
    int elementCount = elements.length;

    for (int i = 0; i < elementCount; ++i) {
      var element = elements[i];

      // Bind the VertexBuffer
      int slot = element.slot;

      var buffer = mesh._vertexBuffers[slot];
      assert(buffer != null);

      _gl.bindBuffer(WebGL.ARRAY_BUFFER, buffer._binding);

      // Bind the attribute index if necessary
      int attributeIndex = element._vertexAttribIndex;
      _gl.enableVertexAttribArray(attributeIndex);

      // Setup the attribute pointer
      _gl.vertexAttribPointer(
          attributeIndex,
          element.format.index + 1,
          WebGL.FLOAT,
          false,
          vertexDeclaration.getStride(slot),
          element.offset
      );

      int instanceDataStepRate = element.instanceDataStepRate;

      // Setup instancing if necessary
      if (_vertexAttributeInstanceStepRate[attributeIndex] != instanceDataStepRate) {
        assert(_instancedArrays != null);

        _instancedArrays.vertexAttribDivisorAngle(attributeIndex, instanceDataStepRate);
      }
    }

    // Bind the index data
    var indexBuffer = mesh._indexBuffer;

    if (indexBuffer != null) {
      _gl.bindBuffer(WebGL.ELEMENT_ARRAY_BUFFER, indexBuffer._binding);
    }

    _printVertexAttribState();
  }

  //---------------------------------------------------------------------
  // EffectPass internal methods
  //---------------------------------------------------------------------

  void _bindEffectPass(EffectPass effectPass) {
    if (_boundEffectPass != effectPass) {
      _gl.useProgram(effectPass._binding);

      _boundEffectPass = effectPass;
    }
  }

  void _setEffectParameters() {
    // Get the parameters
    var parameters = _boundEffectPass._effect.parameters;

    // Setup the uniforms
    var uniforms = _boundEffectPass._uniforms;
    var uniformCount = uniforms.length;

    for (var i = 0; i < uniformCount; ++i) {
      var uniform = uniforms[i];
      var value = parameters._getParameterValue(uniform.name);

      uniform.setValue(_gl, value);
    }

    // Setup the samplers
    var samplers = _boundEffectPass._samplers;
    var samplerCount = samplers.length;

    for (var i = 0; i < samplerCount; ++i) {
      var sampler = samplers[i];
      var value = parameters._getParameterValue(sampler.name);

      _bindTextureAt(sampler.textureUnit, value);
    }
  }

  //---------------------------------------------------------------------
  // Texture internal methods
  //---------------------------------------------------------------------

  void _setActiveTextureUnit(int textureUnit) {
    if (_activeTextureUnit != textureUnit) {
      _gl.activeTexture(WebGL.TEXTURE0 + textureUnit);

      _activeTextureUnit = textureUnit;
    }
  }

  /// Binds the [texture] to the given [textureUnit].
  void _bindTextureAt(int textureUnit, Texture texture) {
    if (_boundTextures[textureUnit] != texture) {
      _setActiveTextureUnit(textureUnit);

      _gl.bindTexture(texture._target, texture._binding);

      _boundTextures[textureUnit] = texture;
    }
  }

  void _bindTexture(Texture texture) {
    var textureUnit = _findTexture(texture);

    if (textureUnit == -1) {
      _bindTextureAt(_activeTextureUnit, texture);
    } else {
      _setActiveTextureUnit(textureUnit);
    }
  }

  /// Searches the bound textures for the index of the given [texture].
  int _findTexture(Texture texture) {
    var textureUnits = _boundTextures.length;

    for (var i = 0; i < textureUnits; ++i) {
      if (_boundTextures[i] == texture) {
        return i;
      }
    }

    return -1;
  }

  void _initializeTexture(Texture texture) {
    var target = texture._target;
    var samplerState = texture._samplerState;

    _bindTexture(texture);

    // Set the parameters otherwise the texture object cannot be rendered
    _gl.texParameteri(
        target,
        WebGL.TEXTURE_WRAP_S,
        _textureAddressModeToWebGL(samplerState.addressU)
    );

    _gl.texParameteri(
        target,
        WebGL.TEXTURE_WRAP_T,
        _textureAddressModeToWebGL(samplerState.addressV)
    );

    var filter = samplerState.filter;

    _gl.texParameteri(
        target,
        WebGL.TEXTURE_MIN_FILTER,
        _textureFilterMinToWebGL(filter)
    );

    _gl.texParameteri(
        target,
        WebGL.TEXTURE_MAG_FILTER,
        _textureFilterMagToWebGL(filter)
    );
  }

  void _bindSamplerState(Texture texture, SamplerState samplerState) {
    var boundSamplerState = texture._samplerState;
    var target = texture._target;

    _bindTexture(texture);
  }

  void _setElementTexture2D(Texture2D texture, Html.HtmlElement element) {
    _bindTexture(texture);

    _gl.texImage2D(
        texture._target,
        0,
        WebGL.RGBA,
        WebGL.RGBA,
        WebGL.UNSIGNED_BYTE,
        element
    );
  }

  void _setElementTexureCube(TextureCube texture, CubeMapFace face, Html.HtmlElement element) {
    _bindTexture(texture);

    _gl.texImage2D(
        _cubeMapFaceToWebGL(face),
        0,
        WebGL.RGBA,
        WebGL.RGBA,
        WebGL.UNSIGNED_BYTE,
        element
    );
  }

  //---------------------------------------------------------------------
  // Debugging methods
  //---------------------------------------------------------------------

  void _printVertexAttribState() {
    int vertexBufferSlots = _vertexAttributeState.length;

    for (var i = 0; i < vertexBufferSlots; ++i) {
      var enabled = _gl.getVertexAttrib(i, WebGL.VERTEX_ATTRIB_ARRAY_ENABLED);
      var divisor = _gl.getVertexAttrib(i, WebGL.AngleInstancedArrays.VERTEX_ATTRIB_ARRAY_DIVISOR_ANGLE);

      print('$i:\tenabled? $enabled\tDivisor:\t$divisor');
    }
  }
}
