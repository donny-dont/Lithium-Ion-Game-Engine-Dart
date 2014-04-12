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

  /// Specifies what triangles are culled based on its direction.
  ///
  /// The default value is [CullMode.Back].
  CullMode cullMode = CullMode.Back;
  /// Specifies the winding of a front facing polygon.
  ///
  /// The default value is [FrontFace.CounterClockwise].
  FrontFace frontFace = FrontFace.CounterClockwise;
  /// The depth bias for polygons.
  ///
  /// This is the amount of bias to apply to the depth of a primitive to
  /// alleviate depth testing problems for primitives of similar depth.
  double depthBias = 0.0;
  /// A bias value that takes into account the slope of a polygon.
  ///
  /// This bias value is applied to coplanar primitives to reduce aliasing and
  /// other rendering artifacts caused by z-fighting.
  double slopeScaleDepthBias = 0.0;
  /// Whether scissor testing is enabled.
  ///
  /// The default is false.
  bool scissorTestEnabled = false;

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
    , cullMode = CullMode.Back
    , frontFace = FrontFace.CounterClockwise;

  /// Initializes an instance of the [RasterizerState] class with settings for culling primitives with counter-clockwise winding order.
  ///
  /// The state object has the following settings.
  ///     cullMode = CullMode.Back;
  ///     frontFace = Clockwise;
  RasterizerState.cullCounterClockwise(GraphicsDevice device)
    : super._internalWithoutBinding(device)
    , cullMode = CullMode.Back
    , frontFace = FrontFace.Clockwise;

  /// Initializes an instance of the [RasterizerState] class with settings for not culling any primitives.
  ///
  /// The state object has the following settings.
  ///     cullMode = CullMode.None;
  ///     frontFace = FrontFace.CounterClockwise;
  RasterizerState.cullNone(GraphicsDevice device)
    : super._internalWithoutBinding(device)
    , cullMode = CullMode.None
    , frontFace = FrontFace.CounterClockwise;
}
