// Copyright (c) 2012, the Lihtium-Ion Engine project authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

part of lithium_graphics;

/// Defines the size of an element of an index buffer.
class IndexElementSize {
  //---------------------------------------------------------------------
  // Serialization names
  //---------------------------------------------------------------------

  /// String representation of [Short].
  static const String _shortName = 'Short';
  /// String representation of [Integer].
  static const String _integerName = 'Integer';

  //---------------------------------------------------------------------
  // Enumerations
  //---------------------------------------------------------------------

  /// Each index element is a 16-bit short value.
  static const int Short = WebGL.UNSIGNED_SHORT;
  /// Each index element is a 32-bit integer value.
  ///
  /// 32-bit indices are only supported through a [WebGL] extension. This can
  /// be verified through [GraphicsDeviceCapabilities.hasUnsignedIntIndices].
  static const int Integer = WebGL.UNSIGNED_INT;

  //---------------------------------------------------------------------
  // Class methods
  //---------------------------------------------------------------------

  /// Convert from a [String] name to the corresponding [IndexElementSize] enumeration.
  static int parse(String name) {
    if (name == _shortName) {
      return Short;
    } else if (name == _integerName) {
      return Integer;
    }

    assert(false);
    return Short;
  }

  /// Converts the [IndexElementSize] enumeration to a [String].
  static String stringify(int value) {
    if (value == Short) {
      return _shortName;
    } else if (value == Integer) {
      return _integerName;
    }

    assert(false);
    return _shortName;
  }

  /// Checks whether the value is a valid enumeration.
  ///
  /// Should be gotten rid of when enums are supported properly.
  static bool isValid(int value) {
    return ((value == Short) || (value == Integer));
  }

  /// The size of the [IndexElementSize] in bytes.
  static int _getSizeInBytes(int value) {
    return (value == Short) ? 2 : 4;
  }
}
