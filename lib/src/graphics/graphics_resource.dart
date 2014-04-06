// Copyright (c) 2013-2014, the Lithium-Ion Engine project authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

part of lithium_graphics;

/// Base class for resources allocated from the [GraphicsDevice].
abstract class GraphicsResource implements Disposable {
  //---------------------------------------------------------------------
  // Member variables
  //---------------------------------------------------------------------

  /// The [GraphicsDevice] the resource is bound to.
  GraphicsDevice _graphicsDevice;
  /// The name of the resource.
  String _name = '';

  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  /// Creates an instance of the [GraphicsResource] class.
  ///
  /// The [device] is used to bind any resources to the underlying [WebGL]
  /// implementation.
  GraphicsResource._internal(GraphicsDevice device)
      : _graphicsDevice = device
  {
    assert(device != null);
  }

  /// Creates an instance of the [GraphicsResource] class.
  ///
  /// The [device] is used to bind any resources to the underlying [WebGL]
  /// implementation.
  ///
  /// This constructor should be used for resources that do not have an
  /// internal binding to WebGL.
  GraphicsResource._internalWithoutBinding(GraphicsDevice device)
      : _graphicsDevice = device
  {
    assert(device != null);
    device._createWithoutBinding(this);
  }

  //---------------------------------------------------------------------
  // Properties
  //---------------------------------------------------------------------

  /// The [GraphicsDevice] the resource is bound to.
  GraphicsDevice get graphicsDevice => _graphicsDevice;

  /// The name of the resource
  String get name => _name;
  set name(String value) { _name = value; }

  /// Whether the object has been disposed
  bool get isDisposed => _graphicsDevice == null;

  //---------------------------------------------------------------------
  // Public methods
  //---------------------------------------------------------------------

  /// Immediately releases the unmanaged resources used by this object.
  void dispose() {
    _graphicsDevice._destroyWithoutBinding(this);
  }
}
