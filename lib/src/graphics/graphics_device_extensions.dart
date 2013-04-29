// Copyright (c) 2012, the Lihtium-Ion Engine project authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

part of lithium_graphics;

/// Collects the extensions available within [WebGL].
///
/// [WebGL] allows additional functionality to be exposed using an extension
/// mechanism. If an extension is available it can be used by the library.
///
/// All approved extensions, and draft extensions are exposed in the
/// implementation. Before using a specific extension the availablility should
/// be determined. [WebGL Stats](http://webglstats.com/) is one site that can
/// collects data on what the level of support for a certain extension is, and
/// should be used to make a judgement call on what to use.
///
/// The values contained in [approved] and [draft] will change over time as
/// new extensions are approved or moved to draft status. Once an extension is
/// [approved] it is not likely to be removed. Any extensions in proposal stage
/// are not enumerated as they have not yet been implemented.
class GraphicsDeviceExtensions {
  //---------------------------------------------------------------------
  // Vendor prefixes
  //---------------------------------------------------------------------

  /// Vendor prefixes to use when searching for extensions.
  static const List<String> vendorPrefixes = const [ '', 'WEBKIT_', 'MOZ_' ];

  //---------------------------------------------------------------------
  // Community approved extensions
  //---------------------------------------------------------------------

  /// Allows the use of 32-bit floating point values within a [Texture].
  ///
  /// For more information view the [specification](http://www.khronos.org/registry/webgl/extensions/OES_texture_float/).
  static const String textureFloat = 'OES_texture_float';
  /// Allows the use of 16-bit floating point values within a [Texture].
  ///
  /// For more information view the [specification](http://www.khronos.org/registry/webgl/extensions/OES_texture_half_float/).
  static const String textureHalfFloat = 'OES_texture_half_float';
  /// Exposes functions which simulate losing and restoring the WebGL context.
  ///
  /// For more information view the [specification](http://www.khronos.org/registry/webgl/extensions/WEBGL_lose_context/).
  static const String loseContext = 'WEBGL_lose_context';
  /// Adds the standard derivative functions to the fragment shader.
  ///
  /// For more information view the [specification](http://www.khronos.org/registry/webgl/extensions/OES_standard_derivatives/).
  static const String standardDerivatives = 'OES_standard_derivatives';
  /// Allows the creation of [WebGL.VertexArrayObject]s.
  ///
  /// Vertex array objects allow the state of the bound buffers to be saved and
  /// restored. This cuts down on the number of calls to setup [VertexBuffer]s
  /// and their attribute locations.
  ///
  /// For more information view the [specification](http://www.khronos.org/registry/webgl/extensions/OES_vertex_array_object/).
  static const String vertexArrayObject = 'OES_vertex_array_object';
  /// Allows the querying of the underlying graphics card for debugging purposes.
  ///
  /// For more information view the [specification](http://www.khronos.org/registry/webgl/extensions/WEBGL_debug_renderer_info/).
  static const String debugRendererInfo = 'WEBGL_debug_renderer_info';
  /// Allows access to the source code of the shader after translation to the native platform.
  ///
  /// Dependent on the underlying WebGL implementation the shaders may be
  /// cross-compiled to a different shading language. This provides a way to
  /// debug that step.
  ///
  /// For more information view the [specification](http://www.khronos.org/registry/webgl/extensions/WEBGL_debug_shaders/).
  static const String debugShaders = 'WEBGL_debug_shaders';
  /// Exposes the compressed texture formats contained in [WebGL.CompressedTextureS3TC].
  ///
  /// For more information view the [specification](http://www.khronos.org/registry/webgl/extensions/OES_standard_derivatives/).
  static const String compressedTextureS3TC = 'WEBGL_compressed_texture_s3tc';
  /// Allows the creation of a depth or stencil target within a frame buffer.
  ///
  /// For more information view the [specification](http://www.khronos.org/registry/webgl/extensions/OES_standard_derivatives/).
  static const String depthTexture = 'WEBGL_depth_texture';
  /// Allows for 32-bit index data.
  ///
  /// For more information view the [specification](http://www.khronos.org/registry/webgl/extensions/OES_element_index_uint/).
  static const String uintElementIndex = 'OES_element_index_uint';
  /// Exposes anisotropic filtering for [Texture]s.
  ///
  /// For more information view the [specification](http://www.khronos.org/registry/webgl/extensions/EXT_texture_filter_anisotropic/).
  static const String textureFilterAnisotropic = 'EXT_texture_filter_anisotropic';

  //---------------------------------------------------------------------
  // Draft extensions
  //---------------------------------------------------------------------

  /// Exposes the compressed texture formats contained in [WebGL.CompressedTextureAtc].
  ///
  /// For more information view the [specification](http://www.khronos.org/registry/webgl/extensions/WEBGL_compressed_texture_atc/).
  static const String compressedTextureAtc = 'WEBGL_compressed_texture_atc';
  /// Exposes the compressed texture formats contained in [WebGL.CompressedTexturePvrtc.
  ///
  /// For more information view the [specification](http://www.khronos.org/registry/webgl/extensions/WEBGL_compressed_texture_pvrtc/).
  static const String compressedTexturePvrtc = 'WEBGL_compressed_texture_pvrtc';
  /// Allows 16-bit floating point values to be rendered into a framebuffer object.
  ///
  /// For more information view the [specification](http://www.khronos.org/registry/webgl/extensions/EXT_color_buffer_half_float/).
  static const String colorBufferHalfFloat = 'EXT_color_buffer_half_float';
  /// Allows 32-bit floating point values to be rendered into a framebuffer object.
  ///
  /// For more information view the [specification](http://www.khronos.org/registry/webgl/extensions/WEBGL_color_buffer_float/).
  static const String colorBufferFloat = 'WEBGL_color_buffer_float';
  /// Adds the ability to set the depth value of a fragment from within the fragment shader.
  ///
  /// For more information view the [specification](http://www.khronos.org/registry/webgl/extensions/EXT_frag_depth/).
  static const String fragDepth = 'EXT_frag_depth';
  /// Allows the usage of the sRGB color space for rendering.
  ///
  /// For more information view the [specification](http://www.khronos.org/registry/webgl/extensions/EXT_sRGB/).
  static const String sRGB = 'EXT_sRGB';
  /// Exposes multiple render target functionality.
  ///
  /// For more information view the [specification](http://www.khronos.org/registry/webgl/extensions/WEBGL_draw_buffers/).
  static const String drawBuffers = 'WEBGL_draw_buffers';
  /// Exposes a mechanism for native instancing.
  ///
  /// For more information view the [specification](http://www.khronos.org/registry/webgl/extensions/ANGLE_instanced_arrays/).
  static const String instancedArrays = 'ANGLE_instanced_arrays';
  /// Allows the linear filtering to be applied to a 32-bit floating point [Texture].
  ///
  /// For more information view the [specification](http://www.khronos.org/registry/webgl/extensions/OES_texture_float_linear/).
  static const String textureFloatLinear = 'OES_texture_float_linear';
  /// Allows the linear filtering to be applied to a 16-bit floating point [Texture].
  ///
  /// For more information view the [specification](http://www.khronos.org/registry/webgl/extensions/OES_texture_half_float_linear/).
  static const String textureHalfFloatLinear = 'OES_texture_half_float_linear';

  //---------------------------------------------------------------------
  // Class properties
  //---------------------------------------------------------------------

  /// Gets all the extensions in an approved state.
  ///
  /// Extensions in an approved state are more likely to be available for use.
  static List<String> get approved {
    return [
        textureFloat,
        textureHalfFloat,
        loseContext,
        standardDerivatives,
        vertexArrayObject,
        debugRendererInfo,
        debugShaders,
        compressedTextureS3TC,
        depthTexture,
        uintElementIndex,
        textureFilterAnisotropic
    ];
  }

  /// Gets all the extensions in a draft state.
  ///
  /// Extensions in a draft state are less likely to be available for use and
  /// may be subject to change.
  static List<String> get draft {
    return [
        compressedTextureAtc,
        compressedTexturePvrtc,
        colorBufferHalfFloat,
        colorBufferFloat,
        fragDepth,
        sRGB,
        drawBuffers,
        instancedArrays,
        textureFloatLinear,
        textureHalfFloatLinear
    ];
  }

  /// Gets all extensions.
  static List<String> get all {
    return approved..addAll(draft);
  }

  //---------------------------------------------------------------------
  // Extension querying
  //---------------------------------------------------------------------

  /// Queries the [WebGL.RenderingContext] for [all] extensions.
  ///
  /// Returns a [Map] containing the result of the extension query for each
  /// enumerated extensions.
  static Map<String, dynamic> _getAllExtensions(WebGL.RenderingContext gl) {
    return _getExtensions(gl, all);
  }

  /// Queries the [WebGL.RenderingContext] for a [List] of [extensions].
  ///
  /// Returns a [Map] containing the result of the extension query for each
  /// extension within the [List].
  static Map<String, dynamic> _getExtensions(WebGL.RenderingContext gl, List<String> extensions) {
    var query = new Map<String, dynamic>();

    int extensionCount = extensions.length;

    for (int i = 0; i < extensionCount; ++i) {
      String name = extensions[i];

      query[name] = _getExtension(gl, name);
    }

    return query;
  }

  /// Queries the [WebGL.RenderingContext] to retrieve the given extension.
  ///
  /// Returns [null] if the extension is not supported.
  static dynamic _getExtension(WebGL.RenderingContext gl, String name) {
    var extension;
    int numVendorPrefixes = vendorPrefixes.length;

    for (int i = 0; i < numVendorPrefixes; ++i) {
      extension = gl.getExtension('${vendorPrefixes[i]}${name}');

      if (extension != null) {
        return extension;
      }
    }

    // Extension not found
    return null;
  }
}
