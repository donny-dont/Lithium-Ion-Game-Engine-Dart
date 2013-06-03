// Copyright (c) 2012, the Lihtium-Ion Engine project authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

part of lithium_application;

/// The window associated with the [Application].
///
/// In this case the [ApplicationWindow] is actually a [Html.CanvasElement].
class ApplicationWindow {
  //---------------------------------------------------------------------
  // Member variables
  //---------------------------------------------------------------------

  /// The window surface.
  Html.CanvasElement _surface;
  /// The previous width of the window.
  ///
  /// Used to restore the width when returning from fullscreen.
  int _previousWidth;
  /// The previous height of the window.
  ///
  /// Used to restore the height when returning from fullscreen.
  int _previousHeight;
  /// The controller for the [onWindowResized] stream.
  StreamController<WindowResizedEvent> _onWindowResizedController;
  /// Event handler for when the [ApplicationWindow] is resized.
  Stream<WindowResizedEvent> _onWindowResized;

  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  /// Creates an instance of the [ApplicationWindow] class.
  ApplicationWindow(Html.CanvasElement surface)
      : _surface = surface
  {
    // Create the window resized stream
    _onWindowResizedController = new StreamController<WindowResizedEvent>();
    _onWindowResized = _onWindowResizedController.stream;

    // Use the resize method to properly size the window
    // This ensures that the proper size is used in case the size of the canvas
    // is specified in CSS rather than being explicitly set. It also accounts
    // for high DPI displays
    _onResize();

    // Hook into the resize events
    Html.window.onResize.listen((_) { _onResize(); });
    _surface.onFullscreenChange.listen((_) { _onFullscreen(); });
  }

  //---------------------------------------------------------------------
  // Properties
  //---------------------------------------------------------------------

  /// The width of the window.
  ///
  /// The width takes into account the pixel density of the screen.
  int get width => _surface.width;

  /// The height of the window.
  ///
  /// The height takes into account the pixel density of the screen.
  int get height => _surface.height;

  /// Whether the window is fullscreen.
  bool get fullscreen => Html.document.fullscreenElement == _surface;
  set fullscreen(bool value) {
    // Get the current state
    bool isFullscreen = fullscreen;

    if (isFullscreen != value) {
      if (value) {
        _surface.requestFullscreen();
      } else {
        Html.document.exitFullscreen();
      }
    }
  }

  /// Event handler for when the [ApplicationWindow] is resized.
  Stream<WindowResizedEvent> get onWindowResized => _onWindowResized;

  //---------------------------------------------------------------------
  // Private methods
  //---------------------------------------------------------------------

  /// Resizes the window with the given [width] and [height].
  ///
  /// Uses the [pixelRatio] to accomidate high dots per inch (dpi) displays. The
  /// actual dimensions of the surface are modified using the value.
  void _resize(int width, int height, double pixelRatio) {
    int newWidth  = (width.toDouble()  * pixelRatio).toInt();
    int newHeight = (height.toDouble() * pixelRatio).toInt();

    if ((_surface.width != newWidth) || (_surface.height != newHeight)) {
      _surface.width  = newWidth;
      _surface.height = newHeight;

      // Notify the change of dimensions
      if (!_onWindowResizedController.isPaused) {
        _onWindowResizedController.add(new WindowResizedEvent._internal(newWidth, newHeight));
      }
    }
  }

  /// Callback for when the window is resized.
  ///
  /// Currently just hooks into the [Html.Window.onResize] event to determine
  /// if the surface was resized.
  void _onResize() {
    _resize(
        _surface.clientWidth,
        _surface.clientHeight,
        Html.window.devicePixelRatio.toDouble()
    );
  }

  /// Callback for when a fullscreen event occurs.
  void _onFullscreen() {
    if (fullscreen) {
      // Note the previous dimensions.
      // This is because exiting fullscreen does not trigger a resize event on
      // the window.
      _previousWidth  = _surface.width;
      _previousHeight = _surface.height;

      // Resize using the dimensions of the screen
      var screen = Html.window.screen;

      _resize(
          screen.width,
          screen.height,
          Html.window.devicePixelRatio.toDouble()
      );
    } else {
      // Restore the previous width
      // The device pixel ratio has already been taken into account
      _resize(_previousWidth, _previousHeight, 1.0);
    }
  }
}
