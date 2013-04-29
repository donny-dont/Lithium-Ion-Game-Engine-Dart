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
  static const String _vendorName   = 'Lithium-Ion Engine';
  static const String _rendererName = 'Lithium-Ion Engine Mock WebGL';
  static const String _versionName  = 'Mock WebGL 1.0 (OpenGL ES 2.0)';

  MockRenderingContext([List extensions]) {
    // Extensions
    if (extensions == null) {
      extensions = GraphicsDeviceExtensions.all;
    }

    var extensionSet = new Set<String>();
    extensionSet.addAll(extensions);

    _initializeExtensions(extensionSet);

    // Device info
    _initializeDeviceInfo();

    when(callsTo('getContextAttributes')).alwaysReturn(new MockContextAttributes());

    when(callsTo('createBuffer')).alwaysReturn(new MockBuffer());
  }

  void _initializeDeviceInfo() {
    when(callsTo('getParameter', WebGL.DebugRendererInfo.UNMASKED_VENDOR_WEBGL)).alwaysReturn(_vendorName);
    when(callsTo('getParameter', WebGL.DebugRendererInfo.UNMASKED_RENDERER_WEBGL)).alwaysReturn(_rendererName);
    when(callsTo('getParameter', WebGL.VENDOR)).alwaysReturn(_vendorName);
    when(callsTo('getParameter', WebGL.RENDERER)).alwaysReturn(_rendererName);

    when(callsTo('getParameter', WebGL.VERSION)).alwaysReturn(_versionName);

    when(callsTo('getParameter', WebGL.MAX_TEXTURE_IMAGE_UNITS)).alwaysReturn(16);
    when(callsTo('getParameter', WebGL.MAX_VERTEX_TEXTURE_IMAGE_UNITS)).alwaysReturn(4);
    when(callsTo('getParameter', WebGL.MAX_TEXTURE_SIZE)).alwaysReturn(8192);
    when(callsTo('getParameter', WebGL.MAX_CUBE_MAP_TEXTURE_SIZE)).alwaysReturn(8192);
    when(callsTo('getParameter', WebGL.MAX_VERTEX_ATTRIBS)).alwaysReturn(16);
    when(callsTo('getParameter', WebGL.MAX_VARYING_VECTORS)).alwaysReturn(10);
    when(callsTo('getParameter', WebGL.MAX_VERTEX_UNIFORM_VECTORS)).alwaysReturn(254);
    when(callsTo('getParameter', WebGL.MAX_FRAGMENT_UNIFORM_VECTORS)).alwaysReturn(221);
    when(callsTo('getParameter', WebGL.ExtTextureFilterAnisotropic.MAX_TEXTURE_MAX_ANISOTROPY_EXT)).alwaysReturn(16);

    when(callsTo('getParameter', WebGL.DEPTH_BITS)).alwaysReturn(24);
    when(callsTo('getParameter', WebGL.STENCIL_BITS)).alwaysReturn(8);
  }

  void _initializeExtensions(Set extensions) {
    var allExtensions = GraphicsDeviceExtensions.all;
    int extensionCount = allExtensions.length;

    for (int i = 0; i < extensionCount; ++i) {
      var name = allExtensions[i];

      var returnValue = (name == GraphicsDeviceExtensions.vertexArrayObject)
          ? new MockOesVertexArrayObject()
          : new MockExtension();

      _initializeExtension(extensions, name, returnValue);
    }
  }

  void _initializeExtension(Set extensions, String name, dynamic returnValue) {
    if (!extensions.contains(name)) {
      returnValue = null;
    }

    var vendorPrefixes = GraphicsDeviceExtensions.vendorPrefixes;
    int vendorPrefixCount = vendorPrefixes.length;

    for (int i = 0; i < vendorPrefixCount; ++i) {
      when(callsTo('getExtension', '${vendorPrefixes[i]}${name}')).alwaysReturn(returnValue);
    }
  }
}
