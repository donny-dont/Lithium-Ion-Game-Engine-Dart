// Copyright (c) 2013-2014, the Lithium-Ion Engine Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

part of lithium_graphics;

/// Provides access to modify vertex data.
///
/// Uses the [VertexDeclaration] to provide access to vertex data through
/// [StridedList]s.
///
class VertexList {
  //---------------------------------------------------------------------
  // Member variables
  //---------------------------------------------------------------------

  /// The underlying vertex data.
  List<ByteBuffer> _buffers;
  /// The [VertexDeclaration] for the data.
  VertexDeclaration _vertexDeclaration;
  /// The number of vertices.
  final int vertexCount;
  /// The number of instances.
  final int instanceCount;

  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  VertexList(VertexDeclaration declaration, this.vertexCount, [this.instanceCount = 0])
      : _vertexDeclaration = declaration
  {
    var slotCount = declaration.slots;

    _buffers = new List<ByteBuffer>(slotCount);

    for (int i = 0; i < slotCount; ++i) {
      var stepRate = declaration.getInstanceStepRate(i);
      var count = (stepRate == 0) ? vertexCount : instanceCount * stepRate;
      var bytes = declaration.getStride(i) * count;

      assert(bytes != 0);

      _buffers[i] = new Uint8List(bytes).buffer;
    }
  }

  //---------------------------------------------------------------------
  // Properties
  //---------------------------------------------------------------------

  /// The position data if present.
  ///
  /// Corresponds to the [VertexElement] with a [VertexElement.usage] of
  /// [VertexElementUsage.Position] at the [VertexElement.usageIndex] of 0.
  Vector3List get positions => getElement(VertexElementUsage.Position, 0) as Vector3List;

  /// The normal data if present.
  ///
  /// Corresponds to the [VertexElement] with a [VertexElement.usage] of
  /// [VertexElementUsage.Normal] at the [VertexElement.usageIndex] of 0.
  Vector3List get normals => getElement(VertexElementUsage.Normal, 0) as Vector3List;

  /// The tangent data if present.
  ///
  /// Corresponds to the [VertexElement] with a [VertexElement.usage] of
  /// [VertexElementUsage.Tangent] at the [VertexElement.usageIndex] of 0.
  Vector3List get tangents => getElement(VertexElementUsage.Tangent, 0) as Vector3List;

  /// The binormal (bitangent) data if present.
  ///
  /// Corresponds to the [VertexElement] with a [VertexElement.usage] of
  /// [VertexElementUsage.Binormal] at the [VertexElement.usageIndex] of 0.
  Vector3List get binormals => getElement(VertexElementUsage.Binormal, 0) as Vector3List;

  /// The texture coordinate data if present.
  ///
  /// Corresponds to the [VertexElement] with a [VertexElement.usage] of
  /// [VertexElementUsage.TextureCoordinate] at the [VertexElement.usageIndex] of 0.
  Vector2List get textureCoordinates => getElement(VertexElementUsage.TextureCoordinate, 0) as Vector2List;

  /// The color data if present.
  ///
  /// Corresponds to the [VertexElement] with a [VertexElement.usage] of
  /// [VertexElementUsage.Color] at the [VertexElement.usageIndex] of 0.
  Vector4List get colors => getElement(VertexElementUsage.Color, 0) as Vector4List;

  /// The point size data if present.
  ///
  /// Corresponds to the [VertexElement] with a [VertexElement.usage] of
  /// [VertexElementUsage.PointSize] at the [VertexElement.usageIndex] of 0.
  ScalarList get pointSizes => getElement(VertexElementUsage.TextureCoordinate, 0) as ScalarList;

  //---------------------------------------------------------------------
  // Public methods
  //---------------------------------------------------------------------

  TypedData getBuffer(int index) {
    return new Float32List.view(_buffers[index]);
  }

  /// Gets a [StridedList] that holds the data of the [VertexElement] with the given [usage] and [usageIndex].
  StridedList getElement(VertexElementUsage usage, int usageIndex) {
    var element = _vertexDeclaration._findElement(usage, usageIndex);
    var list = null;

    if (element != null) {
      int offset = element.offset;
      int slot   = element.slot;
      int stride = _vertexDeclaration.getStride(slot);
      var buffer = _buffers[slot];

      switch (element.format) {
        case VertexElementFormat.Scalar:
          list = new ScalarList.view(buffer, offset, stride);
          break;
        case VertexElementFormat.Vector2:
          list = new Vector2List.view(buffer, offset, stride);
          break;
        case VertexElementFormat.Vector3:
          list = new Vector3List.view(buffer, offset, stride);
          break;
        case VertexElementFormat.Vector4:
          list = new Vector4List.view(buffer, offset, stride);
          break;
      }
    }

    return list;
  }
}
