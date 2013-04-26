// Copyright (c) 2012, the Lihtium-Ion Engine project authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

part of lithium_graphics;

/// An error that occurs during rendering.
class RenderingError {
  //---------------------------------------------------------------------
  // Member variables
  //---------------------------------------------------------------------

  /// The [WebGL] error code.
  int _error;
  /// The name of the method whose call resulted in the [error].
  String _methodName;

  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  /// Creates an instance of the [RenderingError] class.
  ///
  /// A [RenderingError] can not be created directly.
  RenderingError._internal(int error, String methodName)
      : _error = error
      , _methodName = methodName;

  //---------------------------------------------------------------------
  // Properties
  //---------------------------------------------------------------------

  /// The [WebGL] error code.
  int get error => _error;

  /// The name of the method whose call resulted in the [error].
  String get methodName => _methodName;

  /// Retrieves a human readable error message.
  String get message {
    var errorMessage;

    switch (_error) {
      case WebGL.INVALID_ENUM:
        errorMessage = 'An unacceptable value is specified for an enumerated argument. The offending command is ignored and has no other side effect than to set the error flag.';
        break;
      case WebGL.INVALID_VALUE:
        errorMessage = 'A numeric argument is out of range. The offending command is ignored and has no other side effect than to set the error flag.';
        break;
      case WebGL.INVALID_OPERATION:
        errorMessage = 'The specified operation is not allowed in the current state. The offending command is ignored and has no other side effect than to set the error flag.';
        break;
      case WebGL.INVALID_FRAMEBUFFER_OPERATION:
        errorMessage = 'The framebuffer object is not complete. The offending command is ignored and has no other side effect than to set the error flag.';
        break;
      case WebGL.OUT_OF_MEMORY
        errorMessage = 'There is not enough memory left to execute the command. The state of the GL is undefined, except for the state of the error flags, after this error is recorded.';
        break;
      case WebGL.STACK_UNDERFLOW
        errorMessage = 'An attempt has been made to perform an operation that would cause an internal stack to underflow.';
        break;
      case WebGL.STACK_OVERFLOW
        errorMessage = 'An attempt has been made to perform an operation that would cause an internal stack to overflow.';
      default:
        errorMessage = 'An unknown error occurred';
        break;
    }

    return '${_methodName}: ${errorMessage}';
  }
}

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
  StreamController<RenderingError> _controller;
  /// The event handling for [RenderingError]s.
  Stream<RenderingError> _onError;
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
    _controller = new StreamController<RenderingError>();

    _onError = _controller.stream;
  }

  //---------------------------------------------------------------------
  // Properties
  //---------------------------------------------------------------------

  /// The event handling for [RenderingError]s.
  Stream<RenderingError> get onError => _onError;

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
      if (!_controller.isPaused) {
        // Query the symbol name
        var methodName = MirrorSystem.getName(invocation.memberName);

        // Put the error in the stream
        _controller.add(new RenderingError._internal(errorCode, methodName));
      }
    }

    return result;
  }
}
