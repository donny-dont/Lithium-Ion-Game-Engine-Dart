// Copyright (c) 2012, the Lihtium-Ion Engine project authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

part of lithium_application;

/// A single layer that has both update and draw logic.
///
/// Used to separate different portions of the application. As an example the
/// actual game would be hosted in a screen. Another screen could be used to
/// provide a menu.
abstract class Screen {
  //---------------------------------------------------------------------
  // Member variables
  //---------------------------------------------------------------------

  /// The [Application] the [Screen] is associated with.
  Application _application;

  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  /// Creates an instance of the [Screen] class.
  Screen();

  //---------------------------------------------------------------------
  // Properties
  //---------------------------------------------------------------------

  /// The [Application] associated with the [Screen].
  Application get application => _application;

  //---------------------------------------------------------------------
  // Public methods
  //---------------------------------------------------------------------

  /// Loads all resources for the [Screen].
  ///
  /// All resources required by the [Screen] should be loaded by the time
  /// the [Future] completes.
  Future<bool> onLoad();

  /// Unloads all resources for the [Screen].
  ///
  /// All resources loaded during [onLoad] should be disposed of by the time
  /// the method completes.
  void onUnload();

  /// Updates the state of the [Screen].
  void onUpdate();

  /// Renders the [Screen].
  void onDraw();
}
