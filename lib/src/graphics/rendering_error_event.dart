// Copyright (c) 2012, the Lihtium-Ion Engine project authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

part of lithium_graphics;

/// An event for when an error occurs during rendering.
///
/// Used to communicate [WebGL] errors back to the application.
class RenderingErrorEvent {
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

  /// Creates an instance of the [RenderingErrorEvent] class.
  ///
  /// The [error] corresponds to a [WebGL] enumeration, while the [methodName]
  /// is the call to [WebGL.RenderingContext] where the error occurred.
  ///
  /// A [RenderingErrorEvent] can not be created directly.
  RenderingErrorEvent._internal(int error, String methodName)
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
      case WebGL.OUT_OF_MEMORY:
        errorMessage = 'There is not enough memory left to execute the command. The state of the GL is undefined, except for the state of the error flags, after this error is recorded.';
        break;
      default:
        errorMessage = 'An unknown error occurred';
        break;
    }

    return '${_methodName}: ${errorMessage}';
  }
}
