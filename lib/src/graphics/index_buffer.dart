// Copyright (c) 2013-2014, the Lithium-Ion Engine project authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

part of lithium_graphics;

/// Describes the rendering order of the vertices in a vertex buffer.
class IndexBuffer extends GraphicsResource {
  //---------------------------------------------------------------------
  // Member variables
  //---------------------------------------------------------------------

  /// The binding to [WebGL].
  WebGL.Buffer _binding;
  /// The [BufferUsage] of the buffer.
  final BufferUsage bufferUsage;
  /// The [IndexElementSize] of the buffer.
  final IndexElementSize indexElementSize;
  /// The number of indices.
  int _indexCount = 0;

  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  /// Creates a static instance of the [IndexBuffer] class.
  ///
  /// The [bufferUsage] is set to [BufferUsage.Static]. This means that the
  /// data contents of the [IndexBuffer] rarely changes. This allows the
  /// underlying implementation to optimize for this case.
  ///
  /// This does not mean that [setData], and [replaceData] cannot be called
  /// multiple times, but doing so could have a negative performance impact.
  /// If the data is changing every frame or so the [IndexBuffer] should be
  /// created using the [IndexBuffer.dynamic] constructor.
  IndexBuffer.static(GraphicsDevice device, [this.indexElementSize = IndexElementSize.Short])
      : bufferUsage = BufferUsage.Static
      , super._internal(device)
  {
    _graphicsDevice._createIndexBuffer(this);
  }

  /// Creates a dynamic instance of the [IndexBuffer] class.
  ///
  /// The [bufferUsage] is set to [BufferUsage.Dynamic]. This means that the
  /// data contents of the [IndexBuffer] changes frequently, every frame or so.
  /// This allows the underlying implementation to optimize for this case.
  ///
  /// If [setData], or [replaceData] are not being called on a frequent basis,
  /// then the [IndexBuffer] should be created using the [IndexBuffer.static]
  /// constructor.
  IndexBuffer.dynamic(GraphicsDevice device, [this.indexElementSize = IndexElementSize.Short])
      : bufferUsage = BufferUsage.Dynamic
      , super._internal(device)
  {
    _graphicsDevice._createIndexBuffer(this);
  }

  //---------------------------------------------------------------------
  // Properties
  //---------------------------------------------------------------------

  /// The number of indices.
  int get indexCount => _indexCount;

  //---------------------------------------------------------------------
  // Public methods
  //---------------------------------------------------------------------

  /// Sets the entire contents of the buffer with the values contained in [data].
  void setData(TypedData data) {
    assert(((indexElementSize == IndexElementSize.Short)   && (data is Uint16List)) ||
           ((indexElementSize == IndexElementSize.Integer) && (data is Uint32List)));

    _graphicsDevice._graphicsContext._setIndexBufferData(this, data);

    _indexCount = data.lengthInBytes ~/ _indexElementSizeInBytes(indexElementSize);
  }

  /// Replaces a portion of the buffer with the values contained in [data].
  ///
  /// The contents are replaced starting at the [offset] in bytes up to the size
  /// of the [data] array.
  void replaceData(TypedData data, int offset) {
    assert(((indexElementSize == IndexElementSize.Short)   && (data is Uint16List)) ||
           ((indexElementSize == IndexElementSize.Integer) && (data is Uint32List)));
    assert(offset >= 0);

    _graphicsDevice._graphicsContext._replaceIndexBufferData(this, data, offset);
  }

  /// Immediately releases the unmanaged resources used by this object.
  void dispose() {
    _graphicsDevice._destroyIndexBuffer(this);
  }
}
