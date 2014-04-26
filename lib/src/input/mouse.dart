// Copyright (c) 2013-2014, the Lithium-Ion Engine Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

part of lithium_input;

/// Allows retrieval of keystrokes from a keyboard input device.
class Mouse {
  //---------------------------------------------------------------------
  // Class variables
  //---------------------------------------------------------------------

  /// The shared instance of the [Keyboard].
  static final Mouse _instance = new Mouse._internal();

  //---------------------------------------------------------------------
  // Member variables
  //---------------------------------------------------------------------

  /// The state of the keyboard
  final MouseState _mouseState = new MouseState();

  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  /// Creates an instance of the [Mouse] class.
  ///
  /// Only one instance of the [Mouse] class is available.
  factory Mouse() {
    return _instance;
  }

  /// Creates an instance of the [Mouse] class.
  Mouse._internal([Html.CanvasElement element]) {
    if (element != null) {

    }
  }

  //---------------------------------------------------------------------
  // Public methods
  //---------------------------------------------------------------------

  /// Gets the current [MouseState].
  ///
  /// Copies the values in the underlying [MousedState] to [copy].
  void getMouseState(MouseState copy) {
    _mouseState.copyInto(copy);
  }
}
