// Copyright (c) 2013-2014, the Lithium-Ion Engine Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

part of lithium_graphics;

class Mesh extends GraphicsResource {
  //---------------------------------------------------------------------
  // Member variables
  //---------------------------------------------------------------------

  /// The binding to [WebGL].
  WebGL.VertexArrayObject _binding;
  /// The [VertexDeclaration] for the [Mesh].
  VertexDeclaration _vertexDeclaration;
  /// The [VertexBuffer]s for the [Mesh].
  List<VertexBuffer> _vertexBuffers;
  /// The [IndexBuffer] for the [Mesh].
  IndexBuffer _indexBuffer;

  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  Mesh(GraphicsDevice device, VertexDeclaration vertexDeclaration, List<VertexBuffer> vertexBuffers, [IndexBuffer indexBuffer])
      : _vertexDeclaration = vertexDeclaration
      , _vertexBuffers = vertexBuffers
      , _indexBuffer = indexBuffer
      ,  super._internal(device)
  {
    assert(vertexDeclaration != null);
    assert(vertexBuffers != null);
    assert(vertexBuffers.length > 0);

    _graphicsDevice._createMesh(this);
  }

  //---------------------------------------------------------------------
  // Properties
  //---------------------------------------------------------------------

  /// Whether the object has been disposed
  bool get isDisposed => _vertexBuffers[0].isDisposed;

  //---------------------------------------------------------------------
  // Public methods
  //---------------------------------------------------------------------

  /// Immediately releases the unmanaged resources used by this object.
  void dispose() {
    _graphicsDevice._destroyMesh(this);
  }
}
