// Copyright (c) 2013-2014, the Lithium-Ion Engine project authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

part of lithium_graphics;

/// An event for when a [GraphicsResource] is created.
class ResourceCreatedEvent {
  //---------------------------------------------------------------------
  // Member variables
  //---------------------------------------------------------------------

  /// The [GraphicsResource] that was created.
  final GraphicsResource resource;

  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  /// Creates an instance of the [ResourceCreatedEvent] class.
  ///
  /// A [ResourceCreatedEvent] can not be created directly.
  ResourceCreatedEvent._internal(this.resource);
}
