// Copyright (c) 2012, the Lihtium-Ion Engine project authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

part of lithium_application;

/// The current time of the application.
class Time {
  //---------------------------------------------------------------------
  // Class variables
  //---------------------------------------------------------------------

  /// The shared instance of the [Time].
  static final Time _instance = new Time._internal();

  //---------------------------------------------------------------------
  // Member variables
  //---------------------------------------------------------------------

  double _currentTime = 0.0;
  double _deltaTime = 0.0;

  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  /// Creates an instance of the [Time] class.
  ///
  /// Only one instance of the [Time] class is available.
  factory Time() {
    return _instance;
  }

  /// Creates an instance of the [Time] class.
  Time._internal() {
  }

  //---------------------------------------------------------------------
  // Properties
  //---------------------------------------------------------------------

  double get currentTime => _currentTime;

  double get deltaTime => _deltaTime;

  //---------------------------------------------------------------------
  // Internal methods
  //---------------------------------------------------------------------

  void _update() {
    var time = Html.window.performance.now();

    _deltaTime = time - _currentTime;
    _currentTime = time;
  }
}
