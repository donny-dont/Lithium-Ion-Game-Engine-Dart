// Copyright (c) 2013-2014, the Lithium-Ion Engine Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

part of lithium_graphics;

/// Determines how to convert vector data (shapes) into raster data (pixels).
class RasterizerState extends GraphicsResource {
  //---------------------------------------------------------------------
  // Member variables
  //---------------------------------------------------------------------

  /// Spcifies what triangles are culled based on its direction.
  ///
  /// The default value is [CullMode.Back].
  CullMode _cullMode = CullMode.Back;
  /// Specifies the winding of a front facing polygon.
  ///
  /// The default value is [FrontFace.CounterClockwise].
  FrontFace _frontFace = FrontFace.CounterClockwise;
  /// The depth bias for polygons.
  ///
  /// This is the amount of bias to apply to the depth of a primitive to
  /// alleviate depth testing problems for primitives of similar depth.
  double _depthBias = 0.0;
  /// A bias value that takes into account the slope of a polygon.
  ///
  /// This bias value is applied to coplanar primitives to reduce aliasing and
  /// other rendering artifacts caused by z-fighting.
  double _slopeScaleDepthBias = 0.0;
  /// Whether scissor testing is enabled.
  ///
  /// The default is false.
  bool _scissorTestEnabled = false;

  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  /// Creates a new instance of the [RasterizerState] class.
  RasterizerState(GraphicsDevice device)
    : super._internalWithoutBinding(device);

  /// Initializes an instance of the [RasterizerState] class with settings for culling primitives with clockwise winding order.
  ///
  /// The state object has the following settings.
  ///     cullMode = CullMode.Back;
  ///     frontFace = FrontFace.CounterClockwise;
  RasterizerState.cullClockwise(GraphicsDevice device)
    : super._internalWithoutBinding(device)
    , _cullMode = CullMode.Back
    , _frontFace = FrontFace.CounterClockwise;

  /// Initializes an instance of the [RasterizerState] class with settings for culling primitives with counter-clockwise winding order.
  ///
  /// The state object has the following settings.
  ///     cullMode = CullMode.Back;
  ///     frontFace = Clockwise;
  RasterizerState.cullCounterClockwise(GraphicsDevice device)
    : super._internalWithoutBinding(device)
    , _cullMode = CullMode.Back
    , _frontFace = FrontFace.Clockwise;

  /// Initializes an instance of the [RasterizerState] class with settings for not culling any primitives.
  ///
  /// The state object has the following settings.
  ///     cullMode = CullMode.None;
  ///     frontFace = FrontFace.CounterClockwise;
  RasterizerState.cullNone(GraphicsDevice device)
    : super._internalWithoutBinding(device)
    , _cullMode = CullMode.None
    , _frontFace = FrontFace.CounterClockwise;

  //---------------------------------------------------------------------
  // Properties
  //---------------------------------------------------------------------

  /// Spcifies what triangles are culled based on its direction.
  ///
  /// The default value is [CullMode.Back].
  CullMode get cullMode => _cullMode;
  set cullMode(CullMode value) { _cullMode = value; }

  /// Specifies the winding of a front facing polygon.
  ///
  /// The default value is [FrontFace.CounterClockwise].
  FrontFace get frontFace => _frontFace;
  set frontFace(FrontFace value) { _frontFace = value; }

  /// The depth bias for polygons.
  ///
  /// This is the amount of bias to apply to the depth of a primitive to
  /// alleviate depth testing problems for primitives of similar depth.
  ///
  /// The default value is 0.
  double get depthBias => _depthBias;
  set depthBias(double value) { _depthBias = value; }

  /// A bias value that takes into account the slope of a polygon.
  ///
  /// This bias value is applied to coplanar primitives to reduce aliasing and
  /// other rendering artifacts caused by z-fighting.
  ///
  /// The default is 0.
  double get slopeScaleDepthBias => _slopeScaleDepthBias;
  set slopeScaleDepthBias(double value) { _slopeScaleDepthBias = value; }

  /// Whether scissor testing is enabled.
  ///
  /// The default is false.
  bool get scissorTestEnabled => _scissorTestEnabled;
  set scissorTestEnabled(bool value) { _scissorTestEnabled = value; }
}
