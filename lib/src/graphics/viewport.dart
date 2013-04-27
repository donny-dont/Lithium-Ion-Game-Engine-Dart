// Copyright (c) 2012, the Lihtium-Ion Engine project authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

part of lithium_graphics;

/// The window dimensions of a render-target surface onto which a 3D volume projects.
class Viewport extends GraphicsResource {
  //---------------------------------------------------------------------
  // Member variables
  //---------------------------------------------------------------------

  /// The x-coordinate of the upper left corner of the viewport on the render-target surface.
  int _x = 0;
  /// The y-coordinate of the upper left corner of the viewport on the render-target surface.
  int _y = 0;
  /// The width of the viewport on the render-target surface, in pixels.
  int _width = 640;
  /// The height of the viewport on the render-target surface, in pixels.
  int _height = 480;
  /// The minimum depth of the viewport.
  double _minDepth = 0.0;
  /// The maximum depth of the viewport.
  double _maxDepth = 1.0;

  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  /// Creates an instance of the [Viewport] class.
  Viewport(GraphicsDevice device)
    : super._internal(device)
  {
    _graphicsDevice._createWithoutBinding(this);
  }

  /// Creates an instance of the [Viewport] class.
  ///
  /// The rectangular bounding box is specified.
  Viewport.bounds(GraphicsDevice device, int x, int y, int width, int height)
    : _x = x
    , _y = y
    , _width = width
    , _height = height
    , super._internal(device)
  {
    _graphicsDevice._createWithoutBinding(this);
  }

  //---------------------------------------------------------------------
  // Properties
  //---------------------------------------------------------------------

  /// The x-coordinate of the upper left corner of the viewport on the render-target surface.
  int get x => _x;
  set x(int value) { _x = value; }

  /// The y-coordinate of the upper left corner of the viewport on the render-target surface.
  int get y => _y ;
  set y(int value) { _y = value; }

  /// The width of the viewport on the render-target surface, in pixels.
  ///
  /// Asserts that the value is a positive number.
  int get width => _width;
  set width(int value) {
    assert(value >= 0);

    _width = value;
  }

  /// The height of the viewport on the render-target surface, in pixels.
  ///
  /// Asserts that the value is a positive number.
  int get height => _height;
  set height(int value) {
    assert(value >= 0);

    _height = value;
  }

  /// The minimum depth of the viewport.
  ///
  /// Asserts that the value given is in the range \[0, 1\].
  double get minDepth => _minDepth;
  set minDepth(double value) {
    assert((value >= 0.0) && (value <= 1.0));

    _minDepth = value;
  }

  /// The aspect ratio used by the viewport.
  double get aspectRatio => width / height;

  /// The maximum depth of the viewport.
  ///
  /// Asserts that the value given is in the range \[0, 1\].
  double get maxDepth => _maxDepth;
  set maxDepth(double value) {
    assert((value >= 0.0) && (value <= 1.0));

    _maxDepth = value;
  }

  //---------------------------------------------------------------------
  // Public methods
  //---------------------------------------------------------------------

  /// Immediately releases the unmanaged resources used by this object.
  void dispose() {
    _graphicsDevice._destroyWithoutBinding(this);
  }
}
