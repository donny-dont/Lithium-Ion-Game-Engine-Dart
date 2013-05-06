// Copyright (c) 2012, the Lihtium-Ion Engine project authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

part of lithium_application;

/// An event for when an [Application] loses focus.
///
/// Uses the Page Visibility API to notify when the application is hidden.
class DeactivationEvent {
  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  /// Creates an instance of the [DeactivationEvent] class.
  ///
  /// A [DeactivationEvent] can not be created directly.
  DeactivationEvent._internal();
}
