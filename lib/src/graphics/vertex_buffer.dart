// Copyright (c) 2013-2014, the Lithium-Ion Engine project authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

part of lithium_graphics;

/// Represents a list of vertices.
class VertexBuffer extends GraphicsResource {
  //---------------------------------------------------------------------
  // Member variables
  //---------------------------------------------------------------------

  /// The binding to [WebGL].
  WebGL.Buffer _binding;
  /// The [BufferUsage] of the buffer.
  final BufferUsage bufferUsage;

  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  /// Creates a static instance of the [VertexBuffer] class.
  ///
  /// The [bufferUsage] is set to [BufferUsage.Static]. This means that the
  /// data contents of the [VertexBuffer] rarely changes. This allows the
  /// underlying implementation to optimize for this case.
  ///
  /// This does not mean that [setData], and [replaceData] cannot be called
  /// multiple times, but doing so could have a negative performance impact.
  /// If the data is changing every frame or so the [VertexBuffer] should be
  /// created using the [VertexBuffer.dynamic] constructor.
  VertexBuffer.static(GraphicsDevice device)
      : bufferUsage = BufferUsage.Static
      , super._internal(device)
  {
    _graphicsDevice._createVertexBuffer(this);
  }

  /// Creates a dynamic instance of the [VertexBuffer] class.
  ///
  /// The [bufferUsage] is set to [BufferUsage.Dynamic]. This means that the
  /// data contents of the [VertexBuffer] changes frequently, every frame or so.
  /// This allows the underlying implementation to optimize for this case.
  ///
  /// If [setData], or [replaceData] are not being called on a frequent basis,
  /// then the [VertexBuffer] should be created using the [VertexBuffer.static]
  /// constructor.
  VertexBuffer.dynamic(GraphicsDevice device)
      : bufferUsage = BufferUsage.Dynamic
      , super._internal(device)
  {
    _graphicsDevice._createVertexBuffer(this);
  }

  //---------------------------------------------------------------------
  // Public methods
  //---------------------------------------------------------------------

  /// Sets the entire contents of the buffer with the values contained in [data].
  void setData(TypedData data) {
    _graphicsDevice._graphicsContext._setVertexBufferData(this, data);
  }

  /// Replaces a portion of the buffer with the values contained in [data].
  ///
  /// The contents are replaced starting at the [offset] in bytes up to the size
  /// of the [data] array.
  void replaceData(TypedData data, int offset) {
    _graphicsDevice._graphicsContext._replaceVertexBufferData(this, data, offset);
  }

  /// Immediately releases the unmanaged resources used by this object.
  void dispose() {
    _graphicsDevice._destroyVertexBuffer(this);
  }
}
