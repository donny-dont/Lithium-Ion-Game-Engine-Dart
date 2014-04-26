// Copyright (c) 2013-2014, the Lithium-Ion Engine Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

part of lithium_input;

/// The state of a mouse input device, including mouse cursor position and buttons pressed.
class MouseState implements Cloneable {
  //---------------------------------------------------------------------
  // Member variables
  //---------------------------------------------------------------------

  /// The state of the left mouse button.
  ButtonState _leftButton = ButtonState.Released;
  /// The state of the middle mouse button.
  ButtonState _middleButton = ButtonState.Released;
  /// The state of the right mouse button.
  ButtonState _rightButton = ButtonState.Released;
  /// The horizontal position of the mouse cursor.
  int _x = 0;
  /// The vertical position of the mouse cursor.
  int _y = 0;

  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  /// Creates an instance of the [MouseState] class.
  MouseState();

  //---------------------------------------------------------------------
  // Properties
  //---------------------------------------------------------------------

  /// The state of the left mouse button.
  ButtonState get leftButton => _leftButton;
  /// The state of the middle mouse button.
  ButtonState get middleButton => _middleButton;
  /// The state of the right mouse button.
  ButtonState get rightButton => _rightButton;
  /// The horizontal position of the mouse cursor.
  int get x => _x;
  /// The vertical position of the mouse cursor.
  int get y => _y;

  //---------------------------------------------------------------------
  // Cloneable methods
  //---------------------------------------------------------------------

  /// Copies the values from the object into the [state] object.
  void copyInto(MouseState state) {
    state._leftButton   = _leftButton;
    state._middleButton = _middleButton;
    state._rightButton  = _rightButton;

    state._x = _x;
    state._y = _y;
  }
}
