// Copyright (c) 2013-2014, the Lithium-Ion Engine project authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

part of lithium_graphics;

/// Defines filtering types during texture sampling.
class TextureFilter implements Enum {
  //---------------------------------------------------------------------
  // Member variables
  //---------------------------------------------------------------------

  /// The index of the enumeration within [values].
  final int index;

  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  /// Create an enumeration with the given index.
  const TextureFilter._internal(this.index);

  //---------------------------------------------------------------------
  // Enumerations
  //---------------------------------------------------------------------

  /// Use linear filtering.
  static const TextureFilter Linear = const TextureFilter._internal(0);
  /// Use point filtering.
  static const TextureFilter Point = const TextureFilter._internal(1);
  /// Use anisotropic filtering.
  ///
  /// Anisotropic filtering is only supported through a [WebGL] extension. This
  /// can be through [GraphicsDeviceCapabilities.maxAnisotropyLevel]. If the
  /// value is greater than 1 the extension is available.
  static const TextureFilter Anisotropic = const TextureFilter._internal(2);
  /// Use linear filtering to shrink or expand, and point filtering between mipmap levels (mip).
  static const TextureFilter LinearMipPoint = const TextureFilter._internal(3);
  /// Use point filtering to shrink (minify) or expand (magnify), and linear filtering between mipmap levels.
  static const TextureFilter PointMipLinear = const TextureFilter._internal(4);
  /// Use linear filtering to shrink, point filtering to expand, and linear filtering between mipmap levels.
  static const TextureFilter MinLinearMagPointMipLinear = const TextureFilter._internal(5);
  /// Use linear filtering to shrink, point filtering to expand, and point filtering between mipmap levels.
  static const TextureFilter MinLinearMagPointMipPoint = const TextureFilter._internal(6);
  /// Use point filtering to shrink, linear filtering to expand, and linear filtering between mipmap levels.
  static const TextureFilter MinPointMagLinearMipLinear = const TextureFilter._internal(7);
  /// Use point filtering to shrink, linear filtering to expand, and point filtering between mipmap levels.
  static const TextureFilter MinPointMagLinearMipPoint = const TextureFilter._internal(8);

  //---------------------------------------------------------------------
  // Values
  //---------------------------------------------------------------------

  /// List of enumerations.
  static const List<FrontFace> values = const [
    Linear,
    Point,
    Anisotropic,
    LinearMipPoint,
    PointMipLinear,
    MinLinearMagPointMipLinear,
    MinLinearMagPointMipPoint,
    MinPointMagLinearMipLinear,
    MinPointMagLinearMipPoint
  ];
}

/// Mapping of [TextureFilter] enumerations to WebGL minification filters.
const List<int> _textureFilterMinMapping = const [
    WebGL.LINEAR,  // Linear
    WebGL.NEAREST, // Point
    0,             // Anisotropic (Not specified using a WebGL enumeration)
    WebGL.LINEAR,  // LinearMipPoint
    WebGL.NEAREST, // PointMipLinear
    WebGL.LINEAR,  // MinLinearMagPointMipLinear
    WebGL.LINEAR,  // MinLinearMagPointMipPoint
    WebGL.NEAREST, // MinPointMagLinearMipLinear
    WebGL.NEAREST  // MinPointMagLinearMipPoint
];

/// Mapping of [TextureFilter] enumerations to WebGL magnification filters.
const List<int> _textureFilterMagMapping = const [
    WebGL.LINEAR,                 // Linear
    WebGL.NEAREST,                // Point
    0,                            // Anisotropic (Not specified using a WebGL enumeration)
    WebGL.LINEAR_MIPMAP_NEAREST,  // LinearMipPoint
    WebGL.NEAREST_MIPMAP_LINEAR,  // PointMipLinear
    WebGL.NEAREST_MIPMAP_LINEAR,  // MinLinearMagPointMipLinear
    WebGL.NEAREST_MIPMAP_NEAREST, // MinLinearMagPointMipPoint
    WebGL.LINEAR_MIPMAP_LINEAR,   // MinPointMagLinearMipLinear
    WebGL.LINEAR_MIPMAP_NEAREST   // MinPointMagLinearMipPoint
];

/// Converts the [TextureFilter] enumeration to its WebGL minification filter value.
int _textureFilterMinToWebGL(TextureFilter textureFilter) {
  return _textureFilterMinMapping[textureFilter.index];
}

/// Converts the [TextureFilter] enumeration to its WebGL magnification filter value.
int _textureFilterMagToWebGL(TextureFilter textureFilter) {
  return _textureFilterMagMapping[textureFilter.index];
}
