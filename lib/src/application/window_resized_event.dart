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
  final int width;
  /// The updated height of the [ApplicationWindow].
  final int height;

  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  /// Creates an instance of the [WindowResizedEvent] class.
  ///
  /// A [WindowResizedEvent] can not be created directly.
  WindowResizedEvent._internal(this.width, this.height);
}
