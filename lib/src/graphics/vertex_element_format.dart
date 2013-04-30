// Copyright (c) 2013, the Lihtium-Ion Engine Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

part of lithium_graphics;

/// Defines vertex element formats.
class VertexElementFormat {
  //---------------------------------------------------------------------
  // Serialization names
  //---------------------------------------------------------------------

  /// String representation of [Scalar].
  static const String _scalarName = 'Scalar';
  /// String representation of [Vector2].
  static const String _vector2Name = 'Vector2';
  /// String representation of [Vector3].
  static const String _vector3Name = 'Vector3';
  /// String representation of [Vector4].
  static const String _vector4Name = 'Vector4';

  //---------------------------------------------------------------------
  // Enumerations
  //---------------------------------------------------------------------

  /// Single-component, 32-bit floating-point element.
  static const int Scalar = 1;
  /// Two-component, 32-bit floating-point element.
  static const int Vector2 = 2;
  /// Three-component, 32-bit floating-point element.
  static const int Vector3 = 3;
  /// Three-component, 32-bit floating-point element.
  static const int Vector4 = 4;

  //---------------------------------------------------------------------
  // Class methods
  //---------------------------------------------------------------------

  /// Convert from a [String] name to the corresponding [VertexElementFormat] enumeration.
  static int parse(String name) {
    switch (name) {
      case _scalarName : return Scalar;
      case _vector2Name: return Vector2;
      case _vector3Name: return Vector3;
      case _vector4Name: return Vector4;
    }

    assert(false);
    return Scalar;
  }

  /// Converts the [VertexElementFormat] enumeration to a [String].
  static String stringify(int value) {
    switch (value) {
      case Scalar : return _scalarName;
      case Vector2: return _vector2Name;
      case Vector3: return _vector3Name;
      case Vector4: return _vector4Name;
    }

    assert(false);
    return _scalarName;
  }

  /// Checks whether the value is a valid enumeration.
  ///
  /// Should be gotten rid of when enums are supported properly.
  static bool isValid(int value) {
    switch (value) {
      case Scalar :
      case Vector2:
      case Vector3:
      case Vector4: return true;
    }

    return false;
  }

  /// Gets the size in bytes of the [VertexElementFormat].
  static int sizeInBytes(int value) {
    switch (value) {
      case Scalar : return  4;
      case Vector2: return  8;
      case Vector3: return 12;
      case Vector4: return 16;
    }

    assert(false);
    return 0;
  }
}
