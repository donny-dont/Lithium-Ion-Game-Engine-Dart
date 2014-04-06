// Copyright (c) 2013-2014, the Lithium-Ion Engine project authors.
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
  Html.CanvasElement _surface;
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
  GraphicsDevice(Html.CanvasElement surface, [GraphicsDeviceConfig config = null]) {
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
  void _notifyResourceCreated(GraphicsResource graphicsResource) {
    if (!_onResourceCreatedController.isPaused) {
      _onResourceCreatedController.add(new ResourceCreatedEvent._internal(graphicsResource));
    }
  }

  /// Notify that a [GraphicsResource] has been destroyed.
  void _notifyResourceDestroyed(GraphicsResource graphicsResource) {
    if (!_onResourceDestroyedController.isPaused) {
      _onResourceDestroyedController.add(new ResourceDestroyedEvent._internal(graphicsResource));
    }
  }

  //---------------------------------------------------------------------
  // Binding methods
  //---------------------------------------------------------------------

  /// Binds a [GraphicsResource] to the [GraphicsDevice].
  ///
  /// Used for [GraphicsResource]s that do not require a binding to the
  /// underlying [WebGL] implementation.
  void _createWithoutBinding(GraphicsResource graphicsResource) {
    _notifyResourceCreated(graphicsResource);
  }

  /// Releases a [GraphicsResource] from the [GraphicsDevice].
  ///
  /// Used for [GraphicsResource]s that do not require a binding to the
  /// underlying [WebGL] implementation.
  void _destroyWithoutBinding(GraphicsResource graphicsResource) {
    _notifyResourceDestroyed(graphicsResource);
  }

  /// Binds an [IndexBuffer] to the [GraphicsDevice].
  void _createIndexBuffer(IndexBuffer graphicsResource) {
    // Check that the unsigned int extension is available if the resource uses it
    assert(graphicsResource.indexElementSize == IndexElementSize.Short || _capabilities.hasUnsignedIntIndices);

    graphicsResource._binding = _gl.createBuffer();

    _notifyResourceCreated(graphicsResource);
  }

  /// Releases a [IndexBuffer] from the [GraphicsDevice].
  void _destroyIndexBuffer(IndexBuffer graphicsResource) {
    _gl.deleteBuffer(graphicsResource._binding);
    graphicsResource._binding = null;

    _notifyResourceDestroyed(graphicsResource);
  }

  /// Binds a [VertexBuffer] to the [GraphicsDevice].
  void _createVertexBuffer(VertexBuffer graphicsResource) {
    graphicsResource._binding = _gl.createBuffer();

    _notifyResourceCreated(graphicsResource);
  }

  /// Releases a [VertexBuffer] from the [GraphicsDevice].
  void _destroyVertexBuffer(VertexBuffer graphicsResource) {
    _gl.deleteBuffer(graphicsResource._binding);
    graphicsResource._binding = null;

    _notifyResourceDestroyed(graphicsResource);
  }

  /// Binds a [Mesh] to the [GraphicsDevice].
  void _createMesh(Mesh graphicsResource) {
    if (_vao != null) {
      graphicsResource._binding = _vao.createVertexArray();
    }

    _notifyResourceCreated(graphicsResource);
  }

  /// Releases a [Mesh] from the [GraphicsDevice].
  void _destroyMesh(Mesh graphicsResource) {
    if (_vao != null) {
      _vao.deleteVertexArray(graphicsResource._binding);

      graphicsResource._binding = null;
    }

    _notifyResourceDestroyed(graphicsResource);
  }

  /// Binds a [Texture] to the [GraphicsDevice].
  void _createTexture(Texture graphicsResource) {
    graphicsResource._binding = _gl.createTexture();

    _notifyResourceCreated(graphicsResource);
  }

  /// Releases a [Texture] from the [GraphicsDevice].
  void _destroyTexture(Texture graphicsResource) {
    _gl.deleteTexture(graphicsResource._binding);
    graphicsResource._binding = null;

    _notifyResourceDestroyed(graphicsResource);
  }

  //---------------------------------------------------------------------
  // EffectPass methods
  //---------------------------------------------------------------------

  /// Creates a [WebGL.Shader] and compiles it with the specified [source].
  WebGL.Shader _createShader(int type, String source) {
    var shader = _gl.createShader(type);

    _gl.shaderSource(shader, source);
    _gl.compileShader(shader);

    var compiled = _gl.getShaderParameter(shader, WebGL.COMPILE_STATUS);

    if (!compiled) {
      debug('Could not compile shader ${_gl.getShaderInfoLog(shader)}, pname)', 'lithium_graphics.GraphicsDevice');

      _gl.deleteShader(shader);

      return null;
    } else {
      return shader;
    }
  }

  /// Deletes a [WebGL.Shader].
  ///
  /// The shader is not needed after linking the program and can be deleted
  /// at that point.
  void _deleteShader(WebGL.Shader shader) {
    _gl.deleteShader(shader);
  }

  WebGL.Program _createProgram(WebGL.Shader vertexShader, WebGL.Shader pixelShader) {
    var program = _gl.createProgram();

    // Attach the shaders
    _gl.attachShader(program, vertexShader);
    _gl.attachShader(program, pixelShader);

    // Link them together
    _gl.linkProgram(program);

    var linked = _gl.getProgramParameter(program, WebGL.LINK_STATUS);

    if (!linked) {
      debug('Could not link effect pass ${_gl.getProgramInfoLog(program)}, pname)', 'lithium_graphics.GraphicsDevice');

      _gl.deleteProgram(program);

      return null;
    } else {
      return program;
    }
  }

  /// Applys a [SemanticMap] to the [program].
  ///
  /// The [SemanticMap] specifies the vertex attribute locations.
  void _applySemanticMap(WebGL.Program program) {
    // Bind the attributes to the defaults
    var attributes = _getVertexAttribNames(program);
    var defaultAttributes = SemanticMap.defaultAttributes;
    var defaultMapping = SemanticMap.defaultMapping;

    int attributeCount = attributes.length;

    for (int i = 0; i < attributeCount; ++i) {
      var attributeName = attributes[i];

      if (defaultAttributes.containsKey(attributeName)) {
        int index = defaultMapping._indexOfSemantic(defaultAttributes[attributeName]);

        if (index != SemanticMap.notFound) {
          debug('Binding $attributeName to $index', 'lithium_graphics.GraphicsDevice');
          _gl.bindAttribLocation(program, index, attributeName);
        }
      }
    }

    // Attributes have potentially changed
    // Need to relink the program before the changes are reflected
    _gl.linkProgram(program);
  }

  /// Gets all the associated vertex attributes for the [WebGL.Program].
  List<String> _getVertexAttribNames(WebGL.Program program) {
    int attributeCount = _gl.getProgramParameter(program, WebGL.ACTIVE_ATTRIBUTES);

    var attributes = new List<String>(attributeCount);

    // During setup all the attributes are arranged
    for (int i = 0; i < attributeCount; ++i) {
      var info = _gl.getActiveAttrib(program, i);

      attributes[i] = info.name;
    }

    return attributes;
  }

  /// Gets a list of uniform values for the given program.
  List<WebGL.ActiveInfo> _getUniforms(WebGL.Program program) {
    var uniformCount = _gl.getProgramParameter(program, WebGL.ACTIVE_UNIFORMS);
    var uniforms = new List<WebGL.ActiveInfo>(uniformCount);

    for (int i = 0; i < uniformCount; ++i) {
      var info = _gl.getActiveUniform(program, i);

      uniforms[i] = info;
    }

    return uniforms;
  }

  ///
  void _setSemantic(EffectPass graphicsResource,
                    String name,
                    int usage,
                    int usageIndex,
                    SemanticMap semanticMap)
  {
    int index = semanticMap.indexOf(usage, usageIndex);

    assert(index != SemanticMap.notFound);

    _gl.bindAttribLocation(graphicsResource._binding, index, name);
  }

  void _linkProgram(EffectPass graphicsResource) {
    _gl.linkProgram(graphicsResource._binding);
  }

  void _createEffect(Effect graphicsResource) {
    var parameters = new EffectParameterBlock();
    var techniques = graphicsResource.techniques;

    // Iterate over all techniques to get the parameters
    techniques.forEach((_, technique) {
      var passes = technique.passes;
      var passCount = passes.length;

      for (var i = 0; i < passCount; ++i) {
        _createEffectParameters(parameters, passes[i]);
      }
    });

    // Get the samplers
    var samplers = new List<String>();

    _getSamplers(parameters, samplers, '');

    // Iterate over all techniques to
    techniques.forEach((_, technique) {
      var passes = technique.passes;
      var passCount = passes.length;

      for (var i = 0; i < passCount; ++i) {
        _initializeEffectPass(graphicsResource, passes[i], samplers);
      }
    });

    graphicsResource._parameters = parameters;
  }

  void _createEffectParameters(EffectParameterBlock root, EffectPass pass) {
    var uniforms = _getUniforms(pass._binding);
    var uniformCount = uniforms.length;

    // Iterate over each uniform
    for (var j = 0; j < uniformCount; ++j) {
      var uniform = uniforms[j];
      var name = uniform.name;
      var block = root;
      var blockNames = name.split('.');
      var blockCountMinusOne = blockNames.length - 1;

      for (var i = 0; i < blockCountMinusOne; ++i) {
        var blockName = blockNames[i];

        // See if a structure of arrays is being used
        var leftBracketIndex = blockName.indexOf('[');

        if (leftBracketIndex != -1) {
          var arrayName = blockName.substring(0, leftBracketIndex);
          var rightBracketIndex = blockName.indexOf(']');
          var arrayIndex = int.parse(blockName.substring(leftBracketIndex + 1, rightBracketIndex));

          block._addEffectParameterBlockList(arrayName);

          var blockList = block[arrayName] as EffectParameterBlockList;

          blockList._addEffectParameterBlock(arrayIndex);

          block = blockList[arrayIndex];

          debug('Array found ${arrayName} [${arrayIndex}]', 'lithium_graphics.GraphicsDevice');
        } else {
          block._addEffectParameterBlock(blockName);
          block = block[blockName];

          debug('Structure found ${blockName}', 'lithium_graphics.GraphicsDevice');
        }
      }

      // Create the parameter
      var parameterName = blockNames[blockCountMinusOne];
      var parameterType = _webGLToEffectParameterType(uniform);

      block._addEffectParameter(name, parameterType, uniform.size);
    }
  }

  void _getSamplers(EffectParameterBlock root, List<String> samplers, String structName) {
    var parameters = root._parameters;

    parameters.forEach((name, value) {
      var type = value.type;

      if ((type == EffectParameterType.Texture2D) || (type == EffectParameterType.TextureCube)) {
        var samplerName = '${structName}${name}';

        debug('Sampler found ${samplerName}', 'lithium_graphics.GraphicsDevice');

        samplers.add(name);
      } else if (type == EffectParameterType.BlockList) {


      } else if (type == EffectParameterType.Block) {
        _getSamplers(value.value, samplers, '${structName}${name}.');
      }
    });
  }

  void _initializeEffectPass(Effect effect, EffectPass effectPass, List<String> samplers) {
    var program = effectPass._binding;
    var uniforms = _getUniforms(program);
    var uniformCount = uniforms.length;

    // Associate the Effect with the EffectPass.
    //
    // This is used to access the EffectParameterBlock used by the Effect.
    effectPass._effect = effect;

    // Bind the effect pass to the pipeline
    _graphicsContext._bindEffectPass(effectPass);

    for (var i = 0; i < uniformCount; ++i) {
      var uniform = uniforms[i];
      var name = uniform.name;
      var type = _webGLToEffectParameterType(uniform);
      var location = _gl.getUniformLocation(program, name);

      if ((type == EffectParameterType.Texture2D) || (type == EffectParameterType.TextureCube)) {
        // Determine what texture unit should be used.
        //
        // The texture unit to use corresponds to the location within the
        // samplers array that has the same name as the uniform.
        var textureUnit = samplers.indexOf(name);

        assert(textureUnit != -1);

        // Add the effect parameter sampler
        effectPass._samplers.add(new _EffectParameterSampler._internal(name, textureUnit));

        // Set the texture unit the sampler will be found at.
        //
        // This value only needs to be set once.
        _gl.uniform1i(location, textureUnit);
      } else {
        var parameter;

        switch (type) {
          case EffectParameterType.Scalar:
            parameter = new _EffectParameterScalar._internal(name, location);
            break;
          case EffectParameterType.Matrix4:
            parameter = new _EffectParameterMatrix4._internal(name, location);
            break;
        }

        assert(parameter != null);

        // Add the effect parameter
        effectPass._uniforms.add(parameter);
      }
    }
  }
}
