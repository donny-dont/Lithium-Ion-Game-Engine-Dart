// Copyright (c) 2013, the Lihtium-Ion Engine Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

part of graphics_mocks;

//---------------------------------------------------------------------
// WebGL classes
//---------------------------------------------------------------------

class MockBuffer implements WebGL.Buffer { }
class MockFramebuffer implements WebGL.Framebuffer { }
class MockProgram implements WebGL.Program { }
class MockRenderbuffer implements WebGL.Renderbuffer { }
class MockShader implements WebGL.Shader { }

//---------------------------------------------------------------------
// WebGL extensions
//---------------------------------------------------------------------

class MockExtension { }

class MockOesVertexArrayObject extends Mock implements WebGL.OesVertexArrayObject {
  MokcOesVertexArrayObject() {

  }
}

//---------------------------------------------------------------------
// WebGL.ContextAttributes
//---------------------------------------------------------------------

class MockContextAttributes implements WebGL.ContextAttributes {
  bool alpha = true;
  bool depth = true;
  bool stencil = false;
  bool antialias = true;
  bool premultipliedAlpha = true;
  bool preserveDrawingBuffer = false;
}

//---------------------------------------------------------------------
// WebGL.RenderingContext
//---------------------------------------------------------------------

class MockRenderingContext extends Mock implements WebGL.RenderingContext {
  static final List<String> _vendorExtensions = [ '', 'WEBKIT_', 'MOZ_' ];

  static final List<String> _allExtensions = [
      'OES_texture_float',
      'OES_texture_half_float',
      'WEBGL_lose_context',
      'OES_standard_derivatives',
      'OES_vertex_array_object',
      //'WEBGL_debug_renderer_info',
      'WEBGL_debug_shaders',
      'WEBGL_compressed_texture_s3tc',
      'WEBGL_depth_texture',
      'OES_element_index_uint',
      'EXT_texture_filter_anisotropic',
      'WEBGL_compressed_texture_atc',
      'ANGLE_instanced_arrays',
      'WEBGL_compressed_texture_pvrtc',
      'EXT_draw_buffers'
  ];

  MockRenderingContext([List extensions]) {
    if (extensions == null) {
      extensions = _allExtensions;
    }

    var extensionSet = new Set<String>();
    extensionSet.addAll(extensions);

    _initializeExtensions(extensionSet);

    when(callsTo('getParameter')).alwaysReturn(4);
    when(callsTo('getContextAttributes')).alwaysReturn(new MockContextAttributes());

    when(callsTo('createBuffer')).alwaysReturn(new MockBuffer());
  }

  void _initializeExtensions(Set extensions) {
    _initializeExtension(extensions, 'OES_texture_float');
    _initializeExtension(extensions, 'OES_texture_half_float');
    _initializeExtension(extensions, 'WEBGL_lose_context');
    _initializeExtension(extensions, 'OES_standard_derivatives');
    _initializeExtension(extensions, 'WEBGL_debug_renderer_info');
    _initializeExtension(extensions, 'WEBGL_debug_shaders');
    _initializeExtension(extensions, 'WEBGL_compressed_texture_s3tc');
    _initializeExtension(extensions, 'WEBGL_depth_texture');
    _initializeExtension(extensions, 'OES_element_index_uint');
    _initializeExtension(extensions, 'EXT_texture_filter_anisotropic');

    _initializeExtension(extensions, 'WEBGL_compressed_texture_atc');
    _initializeExtension(extensions, 'ANGLE_instanced_arrays');
    _initializeExtension(extensions, 'WEBGL_compressed_texture_pvrtc');
    _initializeExtension(extensions, 'EXT_draw_buffers');

    _initializeExtension(extensions, 'OES_vertex_array_object', new MockOesVertexArrayObject());
  }

  void _initializeExtension(Set extensions, String name, [dynamic returnValue]) {
    if (extensions.contains(name)) {
      if (returnValue == null) {
        returnValue = new MockExtension();
      }
    } else {
      returnValue = null;
    }

    int numVendorExtensions = _vendorExtensions.length;

    for (int i = 0; i < numVendorExtensions; ++i) {
      when(callsTo('getExtension', '${_vendorExtensions[i]}${name}')).alwaysReturn(returnValue);
    }
  }
}
