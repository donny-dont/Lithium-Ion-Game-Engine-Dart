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
  // Clear variable
  //---------------------------------------------------------------------

  /// The current color that the color buffer is set to on clear.
  vec4 _clearColor = new vec4(0.0, 0.0, 0.0, 1.0);
  /// The current value to set the depth buffer to on clear.
  double _clearDepth = 0.0;
  /// The current value to set the stencil buffer to on clear.
  int _clearStencil = 0;

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


}
