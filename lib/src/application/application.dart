
class Application {
  //---------------------------------------------------------------------
  // Member variables
  //---------------------------------------------------------------------

  GraphicsDevice _graphicsDevice;

  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  Application._internal(CanvasElement surface) {
    assert(surface != null);

    _graphicsDevice = new GraphicsDevice(surface);
  }
}

/// Update loop
void update(num time) {

}

/// Hook to start up the application.
///
/// Attaches the [Application] to the [CanvasElement] at the given [canvasId].
/// From there it pushes the [Screen] and begins execution.
void startApplication(String canvasId, Screen screen) {
  var canvas = query(canvasId);


}
