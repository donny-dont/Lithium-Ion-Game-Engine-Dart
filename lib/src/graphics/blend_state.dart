// Copyright (c) 2013-2014, the Lithium-Ion Engine project authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

part of lithium_graphics;

/// Contains blend state for the pipeline.
class BlendState extends GraphicsResource {
  //---------------------------------------------------------------------
  // Member variables
  //---------------------------------------------------------------------

  /// Whether blending operations are enabled. Enabled by default.
  bool enabled = true;

  /// The red component of the blend factor for alpha blending.
  double _blendFactorRed = 1.0;
  /// The green component of the blend factor for alpha blending.
  double _blendFactorGreen = 1.0;
  /// The blue component of the blend factor for alpha blending.
  double _blendFactorBlue = 1.0;
  /// The alpha component of the blend factor for alpha blending.
  double _blendFactorAlpha = 1.0;

  /// The arithmetic operation when blending alpha values.
  ///
  /// The default is [BlendOperation.Add].
  BlendOperation alphaBlendOperation = BlendOperation.Add;
  /// The blend factor for the destination alpha; the percentage of the destination alpha included in the result.
  ///
  /// The default is [Blend.One].
  Blend alphaDestinationBlend = Blend.One;
  /// The alpha blend factor.
  ///
  /// The default is [Blend.One].
  Blend alphaSourceBlend = Blend.One;
  /// The arithmetic operation when blending color values.
  ///
  /// The default is [BlendOperation.Add].
  BlendOperation colorBlendOperation = BlendOperation.Add;
  /// The blend factor for the destination color.
  ///
  /// The default is [Blend.One].
  Blend colorDestinationBlend = Blend.One;
  /// The blend factor for the source color.
  ///
  /// The default is Blend.One.
  Blend colorSourceBlend = Blend.One;

  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  /// Creates an instance of the BlendState class with default values.
  BlendState(GraphicsDevice device)
  : super._internalWithoutBinding(device);

  /// Initializes an instance of the BlendState class with settings for additive blend.
  ///
  /// This adds the destination data to the source data without using alpha.
  BlendState.additive(String name, GraphicsDevice device)
    : super._internalWithoutBinding(device)
    , alphaDestinationBlend = Blend.One
    , alphaSourceBlend = Blend.SourceAlpha
    , colorDestinationBlend = Blend.One
    , colorSourceBlend = Blend.SourceAlpha;

  /// Initializes an instance of the BlendState class with settings for alpha blend.
  ///
  /// This blends the source and destination data using alpha.
  BlendState.alphaBlend(GraphicsDevice device)
    : super._internalWithoutBinding(device)
    , alphaDestinationBlend = Blend.InverseSourceAlpha
    , alphaSourceBlend = Blend.One
    , colorDestinationBlend = Blend.InverseSourceAlpha
    , colorSourceBlend = Blend.One;

  /// Initializes an instance of the BlendState class with settings for blending with non-premultipled alpha.
  ///
  /// This blends source and destination data by using alpha while assuming the
  /// color data contains no alpha information.
  BlendState.nonPremultiplied(GraphicsDevice device)
    : super._internalWithoutBinding(device)
    , alphaDestinationBlend = Blend.InverseSourceAlpha
    , alphaSourceBlend = Blend.SourceAlpha
    , colorDestinationBlend = Blend.InverseSourceAlpha
    , colorSourceBlend = Blend.SourceAlpha;

  /// Initializes an instance of the BlendState class with settings for opaque blend.
  ///
  /// This overwrites the source with the destination data.
  BlendState.opaque(GraphicsDevice device)
    : super._internalWithoutBinding(device)
    , enabled = false
    , alphaDestinationBlend = Blend.Zero
    , alphaSourceBlend = Blend.One
    , colorDestinationBlend = Blend.Zero
    , colorSourceBlend = Blend.One;

  //---------------------------------------------------------------------
  // Properties
  //---------------------------------------------------------------------

  /// The red component of the blend factor for alpha blending.
  double get blendFactorRed => _blendFactorRed;
  set blendFactorRed(double value) {
    assert((value >= 0.0) && (value <= 1.0));

    _blendFactorRed = value;
  }

  /// The green component of the blend factor for alpha blending.
  double get blendFactorGreen => _blendFactorGreen;
  set blendFactorGreen(double value) {
    assert((value >= 0.0) && (value <= 1.0));

    _blendFactorGreen = value;
  }

  /// The blue component of the blend factor for alpha blending.
  double get blendFactorBlue => _blendFactorBlue;
  set blendFactorBlue(double value) {
    assert((value >= 0.0) && (value <= 1.0));

    _blendFactorBlue = value;
  }
}
