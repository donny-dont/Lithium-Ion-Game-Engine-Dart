// Copyright (c) 2012, the Lihtium-Ion Engine project authors.
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
  GraphicsResource _resource;

  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  /// Creates an instance of the [ResourceDestroyedEvent] class.
  ///
  /// A [ResourceDestroyedEvent] can not be created directly.
  ResourceDestroyedEvent._internal(GraphicsResource resource)
      : _resource = resource;

  //---------------------------------------------------------------------
  // Properties
  //---------------------------------------------------------------------

  /// The [GraphicsResource] that was destroyed.
  GraphicsResource get resource => _resource;
}
