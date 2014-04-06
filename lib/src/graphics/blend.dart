// Copyright (c) 2013-2014, the Lithium-Ion Engine Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

part of lithium_graphics;

/// Defines color blending factors.
class Blend implements Enum {
  //---------------------------------------------------------------------
  // Member variables
  //---------------------------------------------------------------------

  /// The index of the enumeration within [values].
  final int index;

  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  /// Create an enumeration with the given index.
  const Blend._internal(this.index);

  //---------------------------------------------------------------------
  // Enumerations
  //---------------------------------------------------------------------

  /// Each component of the color is multiplied by (0, 0, 0, 0).
  static const Blend Zero = const Blend._internal(0);
  /// Each component of the color is multiplied by (1, 1, 1, 1).
  static const Blend One = const Blend._internal(1);
  /// Each component of the color is multiplied by the source color.
  ///
  /// This can be represented as (Rs, Gs, Bs, As), where R, G, B, and A
  /// respectively stand for the red, green, blue, and alpha source values.
  static const Blend SourceColor = const Blend._internal(2);
  /// Each component of the color is multiplied by the inverse of the source color.
  ///
  /// This can be represented as (1 − Rs, 1 − Gs, 1 − Bs, 1 − As) where R, G, B, and A
  /// respectively stand for the red, green, blue, and alpha destination values.
  static const Blend InverseSourceColor = const Blend._internal(3);
  /// Each component of the color is multiplied by the alpha value of the source.
  ///
  /// This can be represented as (As, As, As, As), where As is the alpha source value.
  static const Blend SourceAlpha = const Blend._internal(4);
  /// Each component of the color is multiplied by the inverse of the alpha value of the source.
  ///
  /// This can be represented as (1 − As, 1 − As, 1 − As, 1 − As), where As is the alpha destination value.
  static const Blend InverseSourceAlpha = const Blend._internal(5);
  /// Each component of the color is multiplied by the alpha value of the destination.
  ///
  /// This can be represented as (Ad, Ad, Ad, Ad), where Ad is the destination alpha value.
  static const Blend DestinationAlpha = const Blend._internal(6);
  /// Each component of the color is multiplied by the inverse of the alpha value of the destination.
  ///
  /// This can be represented as (1 − Ad, 1 − Ad, 1 − Ad, 1 − Ad), where Ad is the alpha destination value.
  static const Blend InverseDestinationAlpha = const Blend._internal(7);
  /// Each component color is multiplied by the destination color.
  ///
  /// This can be represented as (Rd, Gd, Bd, Ad), where R, G, B, and A respectively stand for
  /// red, green, blue, and alpha destination values.
  static const Blend DestinationColor = const Blend._internal(8);
  /// Each component of the color is multiplied by the inverse of the destination color.
  ///
  /// This can be represented as (1 − Rd, 1 − Gd, 1 − Bd, 1 − Ad), where Rd, Gd, Bd, and Ad respectively
  /// stand for the red, green, blue, and alpha destination values.
  static const Blend InverseDestinationColor = const Blend._internal(9);
  /// Each component of the color is multiplied by either the alpha of the source color, or the inverse of the alpha of the source color, whichever is greater.
  ///
  /// This can be represented as (f, f, f, 1), where f = min(A, 1 − Ad).
  static const Blend SourceAlphaSaturation = const Blend._internal(10);
  /// Each component of the color is multiplied by a constant set in BlendFactor.
  static const Blend BlendFactor = const Blend._internal(11);
  /// Each component of the color is multiplied by the inverse of a constant set in BlendFactor.
  static const Blend InverseBlendFactor = const Blend._internal(12);

  //---------------------------------------------------------------------
  // Values
  //---------------------------------------------------------------------

  /// List of enumerations.
  static const List<Blend> values = const [
      Zero,
      One,
      SourceColor,
      InverseSourceColor,
      SourceAlpha,
      InverseSourceAlpha,
      DestinationAlpha,
      InverseDestinationAlpha,
      DestinationColor,
      InverseDestinationColor,
      SourceAlphaSaturation,
      BlendFactor,
      InverseBlendFactor
  ];
}

/// Mapping of [Blend] enumerations to WebGL.
const List<int> _blendMapping = const [
    WebGL.ZERO,                    // Zero
    WebGL.ONE,                     // One
    WebGL.SRC_COLOR,               // SourceColor
    WebGL.ONE_MINUS_SRC_COLOR,     // InverseSourceColor
    WebGL.SRC_ALPHA,               // SourceAlpha
    WebGL.ONE_MINUS_SRC_ALPHA,     // InverseSourceAlpha
    WebGL.DST_ALPHA,               // DestinationAlpha
    WebGL.ONE_MINUS_DST_ALPHA,     // InverseDestinationAlpha
    WebGL.DST_COLOR,               // DestinationColor
    WebGL.ONE_MINUS_DST_COLOR,     // InverseDestinationColor
    WebGL.SRC_ALPHA_SATURATE,      // SourceAlphaSaturation
    WebGL.CONSTANT_COLOR,          // BlendFactor
    WebGL.ONE_MINUS_CONSTANT_COLOR // InverseBlendFactor
];

/// Converts the [Blend] enumeration to its WebGL value.
int _blendToWebGL(Blend blend) {
  return _blendMapping[blend.index];
}
