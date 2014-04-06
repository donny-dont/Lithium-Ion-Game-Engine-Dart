// Copyright (c) 2013-2014, the Lithium-Ion Engine Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

part of lithium_input;

/// Identifies a particular key on a keyboard.
///
/// The values of the enumeration correspond to the virtual key codes returned
/// by [Html.KeyboardEvent.keyCode].
class Keys {
  //---------------------------------------------------------------------
  // Enumerations
  //---------------------------------------------------------------------

  /// The enter key.
  static const int Enter = 13;

  /// The left arrow key.
  static const int Left = 37;
  /// The up arrow key.
  static const int Up = 38;
  /// The right arrow key.
  static const int Right = 39;
  /// The down arrow key.
  static const int Down = 40;

  /// The maximum number of enumerations.
  static const int MaxEnumerations = 223;
}
