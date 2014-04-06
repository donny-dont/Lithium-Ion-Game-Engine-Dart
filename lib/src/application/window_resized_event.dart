// Copyright (c) 2013-2014, the Lithium-Ion Engine project authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

part of lithium_application;

/// An event for when an [ApplicationWindow] is resized.
class WindowResizedEvent {
  //---------------------------------------------------------------------
  // Member variables
  //---------------------------------------------------------------------

  /// The updated width of the [ApplicationWindow].
  int _width;
  /// The updated height of the [ApplicationWindow].
  int _height;

  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  /// Creates an instance of the [WindowResizedEvent] class.
  ///
  /// A [WindowResizedEvent] can not be created directly.
  WindowResizedEvent._internal(int width, int height)
      : _width  = width
      , _height = height;

  //---------------------------------------------------------------------
  // Properties
  //---------------------------------------------------------------------

  /// The updated width of the [ApplicationWindow].
  int get width => _width;
  /// The updated height of the [ApplicationWindow].
  int get height => _height;
}
