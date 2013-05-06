// Copyright (c) 2012, the Lihtium-Ion Engine project authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

part of lithium_application;

class Application {
  //---------------------------------------------------------------------
  // Member variables
  //---------------------------------------------------------------------

  /// The [ApplicationWindow] attached to the [Application].
  ApplicationWindow _window;
  /// The [Services] associated with the [Application].
  ///
  /// Holds all the service providers attached to the [Application].
  Services _services = new Services();
  /// The current [Screen].
  /// \TODO REMOVE when manager is complete
  Screen _currentScreen;
  /// The controller for the [onActivated] stream.
  StreamController<ActivationEvent> _onActivatedController;
  /// Event handler for when the application gains focus.
  ///
  /// Can be used with the [onDeactivated] event to unpause the application
  /// when focus is returned.
  ///
  /// The Page Visibility API is used to determine when the application gains
  /// or loses focus. The [onActivated] event will fire when the page gains
  /// visibilty, such as when the tab hosting the application is selected.
  Stream<ActivationEvent> _onActivated;
  /// The controller for the [onDeactivated] stream.
  StreamController<DeactivationEvent> _onDeactivatedController;
  /// Event handler for when the application loses focus.
  ///
  /// Can be used with the [onActivated] event to pause the application
  /// when focus is lost.
  ///
  /// The Page Visibility API is used to determine when the application gains
  /// or loses focus. The [onDeactivated] event will fire when the page loses
  /// visibilty, such as when another tab is chosen within the browser.
  Stream<DeactivationEvent> _onDeactivated;
  /// The controller for the [onExit] stream.
  StreamController<ExitEvent> _onExitController;
  /// Event handler for when the application is exiting.
  ///
  /// Hooks into [Html.Window.onBeforeUnload] to notify when the application is
  /// exiting.
  Stream<ExitEvent> _onExit;

  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  Application(Html.CanvasElement surface) {
    assert(surface != null);

    // Create the ApplicationWindow
    _window = new ApplicationWindow(surface);

    // Create the activated stream
    _onActivatedController = new StreamController<ActivationEvent>();
    _onActivated = _onActivatedController.stream;

    // \TODO Hook into visibility API

    // Create the deactivated stream
    _onDeactivatedController = new StreamController<DeactivationEvent>();
    _onDeactivated = _onDeactivatedController.stream;

    // \TODO Hook into visibility API

    // Create the exit stream
    _onExitController = new StreamController<ExitEvent>();
    _onExit = _onExitController.stream;

    Html.window.onBeforeUnload.listen((_) {
      if (!_onExitController.isClosed) {
        _onExitController.add(new ExitEvent._internal());
      }
    });

    // Create GraphicsDeviceService
    var graphicsDeviceService = new GraphicsDeviceManager();
    graphicsDeviceService.createDevice(surface);

    _services.addService(graphicsDeviceService);

    _instance = this;
  }

  void onUpdate() {
    _currentScreen.onUpdate();
  }

  void onDraw() {
    _currentScreen.onDraw();
  }

  void addScreen(Screen screen) {
    // \TODO Add state-machine like logic
    _currentScreen = screen;

    // Associate the application to this screen
    _currentScreen._application = this;

    // Start loading the screen
    screen.onLoad().then((loaded) {
      // Start the update loop
      var updateLoop = new UpdateLoop();
      updateLoop.onFrame.listen(_onFrame);
      updateLoop.start();
    });
  }

  //---------------------------------------------------------------------
  // Properties
  //---------------------------------------------------------------------

  /// The [ApplicationWindow] attached to the [Application].
  ApplicationWindow get window => _window;

  /// The [Services] associated with the [Application].
  ///
  /// Holds all the service providers attached to the [Application].
  Services get services => _services;

  //---------------------------------------------------------------------
  // Class properties
  //---------------------------------------------------------------------

  static Application _instance;

  static Application get instance => _instance;

  //---------------------------------------------------------------------
  // Private methods
  //---------------------------------------------------------------------

  /// Callback for when a [FrameEvent] is received.
  static void _onFrame(FrameEvent event) {
    _instance.onUpdate();
    _instance.onDraw();
  }
}

/// Hook to start up the application.
///
/// Attaches the [Application] to the [CanvasElement] at the given [canvasId].
/// From there it pushes the [Screen] and begins execution.
void startApplication(String canvasId, Screen screen) {
  var surface = Html.query(canvasId);

  var application = new Application(surface);
  application.addScreen(screen);
}
