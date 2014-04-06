// Copyright (c) 2013-2014, the Lithium-Ion Engine project authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

part of lithium_graphics;

/// A debug implementation of the [WebGL.RenderingContext].
///
/// The [DebugRenderingContext] wraps a [WebGL.RenderingContext] context and
/// passes along all call to it. After the call to the context is checked for
/// errors. If an error is encountered it is written to the [onError] stream.
///
/// A [DebugRenderingContext] should only be used during development as it
/// creates an additional overhead to each call.
class DebugRenderingContext implements WebGL.RenderingContext {
  //---------------------------------------------------------------------
  // Member variables
  //---------------------------------------------------------------------

  /// The controller for the [onError] stream.
  StreamController<RenderingErrorEvent> _onErrorController;
  /// Event handler for when [RenderingErrorEvent]s occur.
  Stream<RenderingErrorEvent> _onError;
  /// The underlying [WebGL.RenderingContext].
  WebGL.RenderingContext _gl;

  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  /// Creates an instance of the [DebugRenderingContext].
  ///
  /// All calls are forwarded to the [gl] context.
  ///
  /// A [DebugRenderingContext] can not be created directly.
  DebugRenderingContext._internal(WebGL.RenderingContext gl)
      : _gl = gl
  {
    _onErrorController = new StreamController<RenderingErrorEvent>();
    _onError = _onErrorController.stream;
  }

  //---------------------------------------------------------------------
  // Properties
  //---------------------------------------------------------------------

  /// Event handler for when [RenderingErrorEvent]s occur.
  Stream<RenderingErrorEvent> get onError => _onError;

  //---------------------------------------------------------------------
  // Public methods
  //---------------------------------------------------------------------

  /// Overload of [noSuchMethod].
  ///
  /// Used to forward calls to the underlying [WebGL.RenderingContext].
  dynamic noSuchMethod(Invocation invocation) {
    // Invoke the method
    var mirror = reflect(_gl);

    var result = mirror.delegate(invocation);

    // See if there was an error
    int errorCode = _gl.getError();

    if (errorCode != WebGL.NO_ERROR) {
      if (!_onErrorController.isPaused) {
        // Query the symbol name
        var methodName = MirrorSystem.getName(invocation.memberName);

        // Put the error in the stream
        _onErrorController.add(new RenderingErrorEvent._internal(errorCode, methodName));
      }
    }

    return result;
  }
}
