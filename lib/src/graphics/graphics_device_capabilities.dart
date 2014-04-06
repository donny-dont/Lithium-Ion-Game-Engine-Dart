// Copyright (c) 2013-2014, the Lithium-Ion Engine project authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

part of lithium_graphics;

/// Allows the querying of the capabilities of the [GraphicsDevice].
///
/// Can be used to get maximum values for the underlying WebGL implementation as
/// well as access what WebGL extensions are available.
class GraphicsDeviceCapabilities {
  //---------------------------------------------------------------------
  // Device information
  //---------------------------------------------------------------------

  /// The graphics card vendor.
  ///
  /// This may be masked due to privacy concerns.
  String _vendor;
  /// The renderer.
  ///
  /// This may be masked due to privacy concerns.
  String _renderer;
  /// The [WebGL] version.
  String _version;
  /// The number of texture units available.
  int _textureUnits;
  /// The number of texture units available in the vertex shader
  int _vertexShaderTextureUnits;
  /// The largest texture size available.
  int _maxTextureSize;
  /// The largest cube map texture size available.
  int _maxCubeMapTextureSize;
  /// The largest anisotropy level available.
  int _maxAnisotropyLevel;
  /// Maximum number of vertex attributes available.
  int _maxVertexAttribs;
  /// Maximum number of varying vectors available in the shader program.
  int _maxVaryingVectors;
  /// Maximum number of uniforms available in the vertex shader.
  int _maxVertexShaderUniforms;
  /// Maximum number of uniforms available in the fragment shader.
  int _maxFragmentShaderUniforms;

  //---------------------------------------------------------------------
  // Buffer information
  //---------------------------------------------------------------------

  /// Whether a depth buffer is available.
  bool _depthBuffer;
  /// Whether a stencil buffer is available.
  bool _stencilBuffer;
  /// The size of the depth buffer in bits.
  int _depthBufferSize;
  /// The size of the stencil buffer in bits.
  int _stencilBufferSize;

  //---------------------------------------------------------------------
  // Extension information
  //---------------------------------------------------------------------

  /// Whether floating point textures are available.
  bool _floatTextures;
  /// Whether half-floating point textures are available.
  bool _halfFloatTextures;
  /// Whether standard derivatives (dFdx, dFdy, fwidth) are available in the fragment shader.
  bool _standardDerivatives;
  /// Whether vertex array objects are available.
  bool _vertexArrayObjects;
  /// Whether the renderer and vendor can be queried for debug purposes.
  bool _debugRendererInfo;
  /// Whether the translated shader source can be viewed.
  bool _debugShaders;
  /// Whether unsigned int can be used as an index.
  bool _unsignedIntIndices;
  /// Whether anisotropic filtering is available.
  bool _anisotropicFiltering;
  /// Whether context losing/restoring can be simulated.
  bool _loseContext;
  /// Whether S3TC compressed textures can be used.
  bool _compressedTextureS3TC;
  /// Whether depth textures can be used.
  bool _depthTextures;
  /// Whether ATC compressed textures can be used.
  bool _compressedTextureAtc;
  /// Whether PVRTC compressed textures can be used.
  bool _compressedTexturePvrtc;
  /// Whether multiple render targets can be used.
  bool _multipleRenderTargets;
  /// Whether instanced arrays can be used.
  bool _instancedArrays;

  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  /// Queries the device capabilities in the [WebGL.RenderingContext].
  GraphicsDeviceCapabilities._fromContext(WebGL.RenderingContext gl) {
    _queryDeviceContext(gl);
    _queryDeviceInfo(gl);
    _queryExtensionInfo(gl);

    if (_debugRendererInfo) {
      _vendor   = gl.getParameter(WebGL.DebugRendererInfo.UNMASKED_VENDOR_WEBGL);
      _renderer = gl.getParameter(WebGL.DebugRendererInfo.UNMASKED_RENDERER_WEBGL);
    } else {
      _vendor   = gl.getParameter(WebGL.VENDOR);
      _renderer = gl.getParameter(WebGL.RENDERER);
    }

    _version = gl.getParameter(WebGL.VERSION);
  }

  //---------------------------------------------------------------------
  // Properties
  //---------------------------------------------------------------------

  /// The graphics card vendor.
  ///
  /// This may be masked due to privacy concerns.
  String get vendor => _vendor;
  /// The renderer.
  ///
  /// This may be masked due to privacy concerns.
  String get renderer => _renderer;
  /// The [WebGL] version.
  String get version => _version;

  /// Whether a depth buffer is available.
  bool get depthBuffer => _depthBuffer;
  /// Whether a stencil buffer is available.
  bool get stencilBuffer => _stencilBuffer;
  /// The number of texture units available.
  int get textureUnits => _textureUnits;
  /// The number of texture units available in the vertex shader
  int get vertexShaderTextureUnits => _vertexShaderTextureUnits;
  /// The largest texture size available.
  int get maxTextureSize => _maxTextureSize;
  /// The largest cube map texture size available.
  int get maxCubeMapTextureSize => _maxCubeMapTextureSize;
  /// The largest anisotropy level available.
  int get maxAnisotropyLevel => _maxAnisotropyLevel;
  /// Maximum number of vertex attributes available.
  int get maxVertexAttribs => _maxVertexAttribs;
  /// Maximum number of varying vectors available in the shader program.
  int get maxVaryingVectors => _maxVaryingVectors;
  /// Maximum number of uniforms available in the vertex shader.
  int get maxVertexShaderUniforms => _maxVertexShaderUniforms;
  /// Maximum number of uniforms available in the fragment shader.
  int get maxFragmentShaderUniforms => _maxFragmentShaderUniforms;

  /// Whether floating point textures are available.
  bool get hasFloatTextures => _floatTextures;
  /// Whether half-floating point textures are available.
  bool get hasHalfFloatTextures => _halfFloatTextures;
  /// Whether standard derivatives (dFdx, dFdy, fwidth) are available in the fragment shader.
  bool get hasStandardDerivatives => _standardDerivatives;
  /// Whether vertex array objects are available.
  bool get hasVertexArrayObjects => _vertexArrayObjects;
  /// Whether the renderer and vendor can be queried for debug purposes.
  bool get hasDebugRendererInfo => _debugRendererInfo;
  /// Whether the translated shader source can be viewed.
  bool get hasDebugShaders => _debugShaders;
  /// Whether unsigned int can be used as an index.
  bool get hasUnsignedIntIndices => _unsignedIntIndices;
  /// Whether anisotropic filtering is available.
  bool get hasAnisotropicFiltering => _anisotropicFiltering;
  /// Whether context losing/restoring can be simulated.
  bool get canLoseContext => _loseContext;
  /// Whether S3TC compressed textures can be used.
  bool get hasCompressedTextureS3TC => _compressedTextureS3TC;
  /// Whether depth textures can be used.
  bool get hasDepthTextures => _depthTextures;
  /// Whether ATC compressed textures can be used.
  bool get hasCompressedTextureAtc => _compressedTextureAtc;
  /// Whether PVRTC compressed textures can be used.
  bool get hasCompressedTexturePvrtc => _compressedTexturePvrtc;
  /// Whether multiple render targets can be used.
  bool get hasMultipleRenderTargets => _multipleRenderTargets;
  /// Whether instanced arrays can be used.
  bool get hasInstancedArrays => _instancedArrays;

  //---------------------------------------------------------------------
  // Public methods
  //---------------------------------------------------------------------

  /// Returns a string representation of this object.
  String toString() {
    return
        '''
Vendor  : $_vendor
Renderer: $_renderer
Version : $_version

Buffer Size
Depth  : $_depthBufferSize
Stencil: $_stencilBufferSize

Device stats
Texture Units: $_textureUnits
Vertex Texture Units: $_vertexShaderTextureUnits
Max Texture Size: ${_maxTextureSize}x${_maxTextureSize}
Max Cube Map Size: ${_maxCubeMapTextureSize}x${_maxCubeMapTextureSize}
Max Anisotropy Level: $_maxAnisotropyLevel
Max Vertex Attributes: $_maxVertexAttribs
Max Varying Vectors: $_maxVaryingVectors
Max Vertex Shader Uniforms: $_maxVertexShaderUniforms
Max Fragment Shader Uniforms: $_maxFragmentShaderUniforms

Extensions
ANGLE_instanced_arrays: $_instancedArrays
EXT_draw_buffers: $_multipleRenderTargets
EXT_texture_filter_anisotropic: $_anisotropicFiltering
OES_element_index_uint: $_unsignedIntIndices
OES_texture_float: $_floatTextures
OES_texture_half_float: $_halfFloatTextures
OES_standard_derivatives: $_standardDerivatives
OES_vertex_array_object: $_vertexArrayObjects
WEBGL_compressed_texture_s3tc: $_compressedTextureS3TC
WEBGL_compressed_texture_atc: $_compressedTextureAtc
WEBGL_compressed_texture_pvrtc: $_compressedTexturePvrtc
WEBGL_debug_renderer_info: $_debugRendererInfo
WEBGL_debug_shaders: $_debugShaders
WEBGL_depth_texture: $_depthTextures
WEBGL_lose_context: $_loseContext
        ''';
  }

  /// Queries context info using the [WebGL.RenderingContext].
  void _queryDeviceContext(WebGL.RenderingContext gl) {
    var attributes = gl.getContextAttributes();

    _depthBuffer = attributes.depth;
    _stencilBuffer = attributes.stencil;
  }

  /// Queries device info using the [WebGL.RenderingContext].
  void _queryDeviceInfo(WebGL.RenderingContext gl) {
    _textureUnits              = gl.getParameter(WebGL.MAX_TEXTURE_IMAGE_UNITS);
    _vertexShaderTextureUnits  = gl.getParameter(WebGL.MAX_VERTEX_TEXTURE_IMAGE_UNITS);
    _maxTextureSize            = gl.getParameter(WebGL.MAX_TEXTURE_SIZE);
    _maxCubeMapTextureSize     = gl.getParameter(WebGL.MAX_CUBE_MAP_TEXTURE_SIZE);
    _maxVertexAttribs          = gl.getParameter(WebGL.MAX_VERTEX_ATTRIBS);
    _maxVaryingVectors         = gl.getParameter(WebGL.MAX_VARYING_VECTORS);
    _maxVertexShaderUniforms   = gl.getParameter(WebGL.MAX_VERTEX_UNIFORM_VECTORS);
    _maxFragmentShaderUniforms = gl.getParameter(WebGL.MAX_FRAGMENT_UNIFORM_VECTORS);

    _depthBufferSize   = gl.getParameter(WebGL.DEPTH_BITS);
    _stencilBufferSize = gl.getParameter(WebGL.STENCIL_BITS);
  }

  /// Queries extensions using the [WebGL.RenderingContext].
  void _queryExtensionInfo(WebGL.RenderingContext gl) {
    var extensions = GraphicsDeviceExtensions._getAllExtensions(gl);

    // Approved
    _floatTextures         = _hasExtension(extensions, GraphicsDeviceExtensions.textureFloat);
    _halfFloatTextures     = _hasExtension(extensions, GraphicsDeviceExtensions.textureHalfFloat);
    _loseContext           = _hasExtension(extensions, GraphicsDeviceExtensions.loseContext);
    _standardDerivatives   = _hasExtension(extensions, GraphicsDeviceExtensions.standardDerivatives);
    _vertexArrayObjects    = _hasExtension(extensions, GraphicsDeviceExtensions.vertexArrayObject);
    _debugRendererInfo     = _hasExtension(extensions, GraphicsDeviceExtensions.debugRendererInfo);
    _debugShaders          = _hasExtension(extensions, GraphicsDeviceExtensions.debugShaders);
    _compressedTextureS3TC = _hasExtension(extensions, GraphicsDeviceExtensions.compressedTextureS3TC);
    _depthTextures         = _hasExtension(extensions, GraphicsDeviceExtensions.depthTexture);
    _unsignedIntIndices    = _hasExtension(extensions, GraphicsDeviceExtensions.uintElementIndex);

    // Query the anisotropic extension and get the maximum anisotropy level
    if (_hasExtension(extensions, GraphicsDeviceExtensions.textureFilterAnisotropic)) {
      _anisotropicFiltering = true;
      _maxAnisotropyLevel = gl.getParameter(WebGL.ExtTextureFilterAnisotropic.MAX_TEXTURE_MAX_ANISOTROPY_EXT);
    } else {
      _anisotropicFiltering = false;
      _maxAnisotropyLevel = 1;
    }

    // Draft
    _compressedTextureAtc   = _hasExtension(extensions, GraphicsDeviceExtensions.compressedTextureAtc);
    _compressedTexturePvrtc = _hasExtension(extensions, GraphicsDeviceExtensions.compressedTexturePvrtc);
    _hasExtension(extensions, GraphicsDeviceExtensions.colorBufferHalfFloat);
    _hasExtension(extensions, GraphicsDeviceExtensions.colorBufferFloat);
    _hasExtension(extensions, GraphicsDeviceExtensions.fragDepth);
    _hasExtension(extensions, GraphicsDeviceExtensions.sRGB);
    _multipleRenderTargets  = _hasExtension(extensions, GraphicsDeviceExtensions.drawBuffers);
    _instancedArrays        = _hasExtension(extensions, GraphicsDeviceExtensions.instancedArrays);
    _hasExtension(extensions, GraphicsDeviceExtensions.textureFloatLinear);
    _hasExtension(extensions, GraphicsDeviceExtensions.textureHalfFloatLinear);
  }

  //---------------------------------------------------------------------
  // Class methods
  //---------------------------------------------------------------------

  /// Queries whether the [name]d extension is present.
  static bool _hasExtension(Map<String, dynamic> extensions, String name) {
    return extensions[name] != null;
  }
}
