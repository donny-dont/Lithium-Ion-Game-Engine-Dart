// Copyright (c) 2013-2014, the Lithium-Ion Engine project authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

part of lithium_graphics;

/// Defines the size of an element of an index buffer.
class IndexElementSize implements Enum {
  //---------------------------------------------------------------------
  // Member variables
  //---------------------------------------------------------------------

  /// The index of the enumeration within [values].
  final int index;

  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  /// Create an enumeration with the given index.
  const IndexElementSize._internal(this.index);

  //---------------------------------------------------------------------
  // Enumerations
  //---------------------------------------------------------------------

  /// Each index element is a 16-bit short value.
  static const IndexElementSize Short = const IndexElementSize._internal(0);
  /// Each index element is a 32-bit integer value.
  ///
  /// 32-bit indices are only supported through a [WebGL] extension. This can
  /// be verified through [GraphicsDeviceCapabilities.hasUnsignedIntIndices].
  static const IndexElementSize Integer = const IndexElementSize._internal(1);

  //---------------------------------------------------------------------
  // Values
  //---------------------------------------------------------------------

  /// List of enumerations.
  static const List<IndexElementSize> values = const [
      Short,
      Integer
  ];
}

/// Mapping of [IndexElementSize] enumerations to WebGL.
const List<int> _indexElementSizeMapping = const [
    WebGL.UNSIGNED_SHORT, // Static
    WebGL.UNSIGNED_INT    // Dynamic
];

/// Converts the [IndexElementSize] enumeration to its WebGL value.
int _indexElementSizeToWebGL(IndexElementSize indexElementSize) {
  return _indexElementSizeMapping[indexElementSize.index];
}

/// Gets the size in bytes of the [IndexElementSize].
int _indexElementSizeInBytes(IndexElementSize indexElementSize) {
  return (IndexElementSize.Short == indexElementSize) ? 2 : 4;
}
