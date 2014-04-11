// Copyright (c) 2013-2014, the Lithium-Ion Engine Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

part of lithium_graphics;

/// Defines usage for the vertex elements.
class VertexElementUsage {
  //---------------------------------------------------------------------
  // Member variables
  //---------------------------------------------------------------------

  /// The index of the enumeration within [values].
  final int index;

  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  /// Create an enumeration with the given index.
  const VertexElementUsage._internal(this.index);

  //---------------------------------------------------------------------
  // Enumerations
  //---------------------------------------------------------------------

  /// Vertex position data.
  static const VertexElementUsage Position = const VertexElementUsage._internal(0);
  /// Vertex normal data.
  static const VertexElementUsage Normal = const VertexElementUsage._internal(1);
  /// Vertex tangent data.
  static const VertexElementUsage Tangent = const VertexElementUsage._internal(2);
  /// Vertex binormal (bitangent) data.
  static const VertexElementUsage Binormal = const VertexElementUsage._internal(3);
  /// Vertex texture coordinate data.
  static const VertexElementUsage TextureCoordinate = const VertexElementUsage._internal(4);
  /// Vertex color data.
  static const VertexElementUsage Color = const VertexElementUsage._internal(5);
  /// Point size data.
  static const VertexElementUsage PointSize = const VertexElementUsage._internal(6);

  //---------------------------------------------------------------------
  // Values
  //---------------------------------------------------------------------

  /// List of enumerations.
  static const List<VertexElementUsage> values = const [
      Position,
      Normal,
      Tangent,
      Binormal,
      TextureCoordinate,
      Color,
      PointSize
  ];
}
