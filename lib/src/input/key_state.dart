// Copyright (c) 2013-2014, the Lithium-Ion Engine Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

part of lithium_input;

/// Identifies the state of a keyboard key.
class KeyState {
  //---------------------------------------------------------------------
  // Serialization names
  //---------------------------------------------------------------------

  /// String representation of [Up].
  static const String _upName = 'Up';
  /// String representation of [Down].
  static const String _downName = 'Down';

  //---------------------------------------------------------------------
  // Enumerations
  //---------------------------------------------------------------------

  /// Key is released.
  static const int Up = 0;
  /// Key is pressed.
  static const int Down = 1;

  //---------------------------------------------------------------------
  // Class methods
  //---------------------------------------------------------------------

  /// Convert from a [String] name to the corresponding [KeyState] enumeration.
  static int parse(String name) {
    if (name == _upName) {
      return Up;
    } else if (name == _downName) {
      return Down;
    }

    assert(false);
    return Up;
  }

  /// Converts the [KeyState] enumeration to a [String].
  static String stringify(int value) {
    if (value == Up) {
      return _upName;
    } else if (value == Down) {
      return _downName;
    }

    assert(false);
    return _upName;
  }

  /// Checks whether the value is a valid enumeration.
  ///
  /// Should be gotten rid of when enums are supported properly.
  static bool isValid(int value) {
    return ((value == Up) || (value == Down));
  }
}
