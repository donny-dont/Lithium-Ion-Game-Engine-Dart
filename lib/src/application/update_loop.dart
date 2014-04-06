// Copyright (c) 2013-2014, the Lithium-Ion Engine project authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

part of lithium_application;

/// Handles the update loop for an application.
class UpdateLoop {
  //---------------------------------------------------------------------
  // Class variables
  //---------------------------------------------------------------------

  /// The shared instance of the [UpdateLoop].
  static final UpdateLoop _instance = new UpdateLoop._internal();

  //---------------------------------------------------------------------
  // Member variables
  //---------------------------------------------------------------------

  /// Whether the update loop is currently running.
  bool _running = false;
  /// The current animation frame.
  int _animationFrame;
  /// The controller for the [onFrame] stream.
  StreamController<FrameEvent> _onFrameController;
  /// Event handler for when an animation frame is received.
  Stream<FrameEvent> _onFrame;

  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  /// Creates an instance of the [UpdateLoop] class.
  ///
  /// Only one instance of the [UpdateLoop] class is available.
  factory UpdateLoop() {
    return _instance;
  }

  /// Creates an instance of the [UpdateLoop] class.
  UpdateLoop._internal() {
    _onFrameController = new StreamController<FrameEvent>();
    _onFrame = _onFrameController.stream;
  }

  //---------------------------------------------------------------------
  // Properties
  //---------------------------------------------------------------------

  /// Whether the update loop is currently running.
  bool get running => _running;

  /// Event handler for when an animation frame is received.
  Stream<FrameEvent> get onFrame => _onFrame;

  //---------------------------------------------------------------------
  // Public methods
  //---------------------------------------------------------------------

  /// Starts up the update loop.
  void start() {
    if (!_running) {
      _animationFrame = Html.window.requestAnimationFrame(_onUpdate);

      _running = true;
    }
  }

  /// Stops the update loop.
  void stop() {
    if (running) {
      Html.window.cancelAnimationFrame(_animationFrame);

      _running = false;
    }
  }

  //---------------------------------------------------------------------
  // Private methods
  //---------------------------------------------------------------------

  /// Internal update loop.
  ///
  /// Makes calls to [Html.Window.requestAnimationFrame] to drive the update
  /// loop. Handles updating the current [GameTime]. Additionally has to handle
  /// the updating of [GamePad]s because the API is not event based.
  static void _onUpdate(num time) {
    // Update the game time
    var time = new Time();
    time._update();

    // Update the GamePads

    // Send out the stream events
    var onFrameController = _instance._onFrameController;

    if (!onFrameController.isPaused) {
      onFrameController.add(new FrameEvent._internal());
    }

    _instance._animationFrame = Html.window.requestAnimationFrame(_onUpdate);
  }
}
