// Copyright (c) 2012, the Lihtium-Ion Engine project authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

part of lithium_graphics;

/// Defines various types of surface formats.
class SurfaceFormat implements Enum {
  //---------------------------------------------------------------------
  // Member variables
  //---------------------------------------------------------------------

  /// The index of the enumeration within [values].
  final int index;

  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  /// Create an enumeration with the given index.
  const SurfaceFormat._internal(this.index);

  //---------------------------------------------------------------------
  // Enumerations
  //---------------------------------------------------------------------

  /// 32-bit RGBA pixel format with alpha, using 8 bits per channel.
  ///
  /// Underlying format is an unsigned byte.
  static const SurfaceFormat Rgba = const SurfaceFormat._internal(0);
  /// 24-bit RGB pixel format, using 8 bits per channel.
  ///
  /// Underlying format is an unsigned byte.
  static const SurfaceFormat Rgb = const SurfaceFormat._internal(1);

  static const SurfaceFormat Rgb565 = const SurfaceFormat._internal(2);
  static const SurfaceFormat Rgba5551 = const SurfaceFormat._internal(3);
  static const SurfaceFormat Rgba4444 = const SurfaceFormat._internal(4);
  /// DXT1 compression format.
  ///
  /// Only available if the compressed texture s3tc extension is supported. Assumes
  /// the texture has no alpha component. DXT1 can support alpha but only 1-bit.
  static const SurfaceFormat Dxt1 = const SurfaceFormat._internal(5);
  /// DXT3 compression format.
  ///
  /// Only available if the compressed texture s3tc extension is supported.
  static const SurfaceFormat Dxt3 = const SurfaceFormat._internal(6);
  /// DXT5 compression format.
  ///
  /// Only available if the compressed texture s3tc extension is supported.
  static const SurfaceFormat Dxt5 = const SurfaceFormat._internal(7);
  static const SurfaceFormat RgbaFloat = const SurfaceFormat._internal(8);
  static const SurfaceFormat RgbFloat = const SurfaceFormat._internal(9);
  static const SurfaceFormat RgbaHalfFloat = const SurfaceFormat._internal(10);
  static const SurfaceFormat RgbHalfFloat = const SurfaceFormat._internal(11);

  //---------------------------------------------------------------------
  // Values
  //---------------------------------------------------------------------

  /// List of enumerations.
  static const List<TextureAddressMode> values = const [
      Rgba,
      Rgb,
      Rgb565,
      Rgba5551,
      Rgba4444,
      Dxt1,
      Dxt3,
      Dxt5,
      RgbaFloat,
      RgbFloat,
      RgbaHalfFloat,
      RgbHalfFloat
  ];
}

/// Mapping of [SurfaceFormat] enumerations to WebGL.
const List<int> _surfaceFormatMapping = const [
    WebGL.RGBA, // Rgba
    WebGL.RGB,  // Rgb
    WebGL.RGB,  // Rgb565
    WebGL.RGBA, // Rgba5551
    WebGL.RGBA, // Rgba4444
    0,          // Dxt1 (Not specified using a WebGL enumeration)
    0,          // Dxt3 (Not specified using a WebGL enumeration)
    0,          // Dxt5 (Not specified using a WebGL enumeration)
    WebGL.RGBA, // RgbaFloat
    WebGL.RGB,  // RgbFloat
    WebGL.RGBA, // RgbaHalfFloat
    WebGL.RGB,  // RgbHalfFloat
];

/// Mapping of [SurfaceFormat] enumerations to WebGL internal formats.
const List<int> _surfaceFormatInternalMapping = const [
    WebGL.UNSIGNED_BYTE,                                       // Rgba
    WebGL.UNSIGNED_BYTE,                                       // Rgb
    WebGL.UNSIGNED_SHORT_5_6_5,                                // Rgb565
    WebGL.UNSIGNED_SHORT_5_5_5_1,                              // Rgba5551
    WebGL.UNSIGNED_SHORT_4_4_4_4,                              // Rgba4444
    WebGL.CompressedTextureS3TC.COMPRESSED_RGBA_S3TC_DXT1_EXT, // Dxt1
    WebGL.CompressedTextureS3TC.COMPRESSED_RGBA_S3TC_DXT3_EXT, // Dxt3
    WebGL.CompressedTextureS3TC.COMPRESSED_RGBA_S3TC_DXT5_EXT, // Dxt5
    WebGL.FLOAT,                                               // RgbaFloat
    WebGL.FLOAT,                                               // RgbFloat
    WebGL.OesTextureHalfFloat.HALF_FLOAT_OES,                  // RgbaHalfFloat
    WebGL.OesTextureHalfFloat.HALF_FLOAT_OES                   // RgbHalfFloat
];


/// Checks whether the value is a compressed format.
bool _isCompressedFormat(SurfaceFormat surfaceFormat) {
  return ((surfaceFormat == SurfaceFormat.Dxt1) ||
          (surfaceFormat == SurfaceFormat.Dxt3) ||
          (surfaceFormat == SurfaceFormat.Dxt5));
}

/// Converts the [SurfaceFormat] enumeration to its WebGL value.
int _surfaceFormatToWebGL(SurfaceFormat surfaceFormat) {
  return _surfaceFormatMapping[surfaceFormat.index];
}

/// Converts the [TextureFilter] enumeration to its WebGL internal format value.
int _surfaceFormatInternalToWebGL(SurfaceFormat surfaceFormat) {
  return _surfaceFormatInternalMapping[surfaceFormat.index];
}
