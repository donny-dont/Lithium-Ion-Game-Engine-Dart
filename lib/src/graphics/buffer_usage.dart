// Copyright (c) 2013-2014, the Lithium-Ion Engine project authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

part of lithium_graphics;

/// Defines the usage of a buffer.
///
/// The usage is a hint to the underlying [WebGL] implementation on how the
/// buffer's data will be accessed. This enables the implementation to make
/// intelligent decisions that effect the performance of the buffer object.
class BufferUsage implements Enum {
  //---------------------------------------------------------------------
  // Member variables
  //---------------------------------------------------------------------

  /// The index of the enumeration within [values].
  final int index;

  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  /// Create an enumeration with the given index.
  const BufferUsage._internal(this.index);

  //---------------------------------------------------------------------
  // Enumerations
  //---------------------------------------------------------------------

  /// Implies that the buffer will be modified once and used many times.
  ///
  /// This should be used if the data will rarely be changed.
  static const BufferUsage Static = const BufferUsage._internal(0);
  /// Implies that the buffer will be modified consistently and used many times.
  ///
  /// This should be used if the data will be changed frequently.
  static const BufferUsage Dynamic = const BufferUsage._internal(1);

  //---------------------------------------------------------------------
  // Values
  //---------------------------------------------------------------------

  /// List of enumerations.
  static const List<BufferUsage> values = const [
      Static,
      Dynamic
  ];
}

/// Mapping of [BufferUsage] enumerations to WebGL.
const List<int> _bufferUsageMapping = const [
    WebGL.STATIC_DRAW, // Static
    WebGL.DYNAMIC_DRAW // Dynamic
];

/// Converts the [BufferUsage] enumeration to its WebGL value.
int _bufferUsageToWebGL(BufferUsage bufferUsage) {
  return _bufferUsageMapping[bufferUsage.index];
}
