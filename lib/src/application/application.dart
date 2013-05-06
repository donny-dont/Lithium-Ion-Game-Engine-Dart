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
  /// Can be used with the
  Stream<ResourceCreatedEvent> _onActivated;


  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  Application(Html.CanvasElement surface) {
    assert(surface != null);

    // Create the ApplicationWindow
    _window = new ApplicationWindow(surface);

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
      Html.window.animationFrame.then(update);
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
}

/// Update loop
void update(num time) {
  var application = Application.instance;

  application.onUpdate();
  application.onDraw();

  Html.window.animationFrame.then(update);
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
