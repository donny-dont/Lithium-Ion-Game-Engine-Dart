// Copyright (c) 2013-2014, the Lithium-Ion Engine project authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

part of lithium_graphics;

/// An event for when a [GraphicsResource] is destroyed.
class ResourceDestroyedEvent {
  //---------------------------------------------------------------------
  // Member variables
  //---------------------------------------------------------------------

  /// The [GraphicsResource] that was destroyed.
  final GraphicsResource resource;

  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  /// Creates an instance of the [ResourceDestroyedEvent] class.
  ///
  /// A [ResourceDestroyedEvent] can not be created directly.
  ResourceDestroyedEvent._internal(this.resource);
}
