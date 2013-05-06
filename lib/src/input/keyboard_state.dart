// Copyright (c) 2013, the Lihtium-Ion Engine Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

part of lithium_input;

/// Represents a state of keystrokes recorded by a keyboard input device.
class KeyboardState implements Cloneable {
  //---------------------------------------------------------------------
  // Member variables
  //---------------------------------------------------------------------

  /// The list of keyboard key states.
  List<int> _keyStates = new List<int>.filled(Keys.MaxEnumerations, KeyState.Up);

  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  /// Creates an instance of the [KeyboardState] class.
  KeyboardState();

  //---------------------------------------------------------------------
  // Operators
  //---------------------------------------------------------------------

  /// Returns the state of the specified [key].
  int operator[] (int key) {
    return _keyStates[key];
  }

  //---------------------------------------------------------------------
  // Public methods
  //---------------------------------------------------------------------

  /// Returns whether the specified [key] is currently pressed.
  bool isKeyDown(int key) {
    return _keyStates[key] == KeyState.Down;
  }

  /// Returns whether the specified [key] is not currently pressed.
  bool isKeyUp(int key) {
    return _keyStates[key] == KeyState.Up;
  }

  /// Copies the values from the object into the [to] object.
  void copyInto(KeyboardState state) {
    for (int i = 0; i < Keys.MaxEnumerations; ++i) {
      state._keyStates[i] = _keyStates[i];
    }
  }

  //---------------------------------------------------------------------
  // Private methods
  //---------------------------------------------------------------------

  /// Sets the [state] of a [Key].
  ///
  /// Used internally by [Keyboard] to respond to changes in the keyboard state.
  void _setKeyState(int key, int state) {
    _keyStates[key] = state;
  }
}
