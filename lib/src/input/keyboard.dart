// Copyright (c) 2013-2014, the Lithium-Ion Engine Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

part of lithium_input;

/// Allows retrieval of keystrokes from a keyboard input device.
class Keyboard {
  //---------------------------------------------------------------------
  // Class variables
  //---------------------------------------------------------------------

  /// The shared instance of the [Keyboard].
  static final Keyboard _instance = new Keyboard._internal();

  //---------------------------------------------------------------------
  // Member variables
  //---------------------------------------------------------------------

  /// The state of the keyboard
  KeyboardState _keyboardState = new KeyboardState();

  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  /// Creates an instance of the [Keyboard] class.
  ///
  /// Only one instance of the [Keyboard] class is available.
  factory Keyboard() {
    return _instance;
  }

  /// Creates an instance of the [Keyboard] class.
  Keyboard._internal([Html.CanvasElement element]) {
    if (element != null) {
      // Need to set a tab index so keyboard events are received
      element.tabIndex = -1;

      element.onKeyUp.listen(_onKeyUp);
      element.onKeyDown.listen(_onKeyDown);
    } else {
      // Attach to window
      Html.window.onKeyUp.listen(_onKeyUp);
      Html.window.onKeyDown.listen(_onKeyDown);
    }
  }

  //---------------------------------------------------------------------
  // Public methods
  //---------------------------------------------------------------------

  /// Gets the current [KeyboardState].
  ///
  /// Copies the values in the underlying [KeyboardState] to [copy].
  void getKeyboardState(KeyboardState copy) {
    _keyboardState.copyInto(copy);
  }

  //---------------------------------------------------------------------
  // Private methods
  //---------------------------------------------------------------------

  /// Callback for when a key is pressed.
  void _onKeyUp(Html.KeyboardEvent event) {
    _instance._keyboardState._setKeyState(event.keyCode, KeyState.Up);
  }

  /// Callback for when a key is released.
  void _onKeyDown(Html.KeyboardEvent event) {
    _instance._keyboardState._setKeyState(event.keyCode, KeyState.Down);
  }
}
