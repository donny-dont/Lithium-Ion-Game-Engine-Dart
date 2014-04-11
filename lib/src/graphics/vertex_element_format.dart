// Copyright (c) 2013-2014, the Lithium-Ion Engine Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

part of lithium_graphics;

/// Defines vertex element formats.
class VertexElementFormat {
  //---------------------------------------------------------------------
  // Member variables
  //---------------------------------------------------------------------

  /// The index of the enumeration within [values].
  final int index;

  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  /// Create an enumeration with the given index.
  const VertexElementFormat._internal(this.index);

  //---------------------------------------------------------------------
  // Enumerations
  //---------------------------------------------------------------------

  /// Single-component, 32-bit floating-point element.
  static const VertexElementFormat Scalar = const VertexElementFormat._internal(0);
  /// Two-component, 32-bit floating-point element.
  static const VertexElementFormat Vector2 = const VertexElementFormat._internal(1);
  /// Three-component, 32-bit floating-point element.
  static const VertexElementFormat Vector3 = const VertexElementFormat._internal(2);
  /// Three-component, 32-bit floating-point element.
  static const VertexElementFormat Vector4 = const VertexElementFormat._internal(3);

  //---------------------------------------------------------------------
  // Values
  //---------------------------------------------------------------------

  /// List of enumerations.
  static const List<VertexElementFormat> values = const [
      Scalar,
      Vector2,
      Vector3,
      Vector4
  ];
}

/// Mapping of [VertexElementFormat] enumerations to their sizes.
const List<int> _vertexElementFormatBytesMapping = const [
    4,  // Scalar
    8,  // Vector2
    12, // Vector3
    16  // Vector4
];

/// Gets the number of bytes required for the [VertexElementFormat].
int _vertexElementFormatInBytes(VertexElementFormat format) {
  return _vertexElementFormatBytesMapping[format.index];
}
