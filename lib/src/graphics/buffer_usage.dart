// Copyright (c) 2012, the Lihtium-Ion Engine project authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

part of lithium_graphics;

/// Defines the usage of a buffer.
///
/// The usage is a hint to the underlying [WebGL] implementation on how the
/// buffer's data will be accessed. This enables the implementation to make
/// intelligent decisions that effect the performance of the buffer object.
class BufferUsage {
  //---------------------------------------------------------------------
  // Serialization names
  //---------------------------------------------------------------------

  /// String representation of [Static].
  static const String _staticName = 'Static';
  /// String representation of [Dynamic].
  static const String _dynamicName = 'Dynamic';

  //---------------------------------------------------------------------
  // Enumerations
  //---------------------------------------------------------------------

  /// Implies that the buffer will be modified once and used many times.
  ///
  /// This should be used if the data will rarely be changed.
  static const int Static = WebGL.STATIC_DRAW;
  /// Implies that the buffer will be modified consistently and used many times.
  ///
  /// This should be used if the data will be changed frequently.
  static const int Dynamic = WebGL.DYNAMIC_DRAW;

  //---------------------------------------------------------------------
  // Class methods
  //---------------------------------------------------------------------

  /// Convert from a [String] name to the corresponding [BufferUsage] enumeration.
  static int parse(String name) {
    if (name == _staticName) {
      return Static;
    } else if (name == _dynamicName) {
      return Dynamic;
    }

    assert(false);
    return Static;
  }

  /// Converts the [BufferUsage] enumeration to a [String].
  static String stringify(int value) {
    if (value == Static) {
      return _staticName;
    } else if (value == Dynamic) {
      return _dynamicName;
    }

    assert(false);
    return _staticName;
  }

  /// Checks whether the value is a valid enumeration.
  ///
  /// Should be gotten rid of when enums are supported properly.
  static bool isValid(int value) {
    return ((value == Static) || (value == Dynamic));
  }
}
