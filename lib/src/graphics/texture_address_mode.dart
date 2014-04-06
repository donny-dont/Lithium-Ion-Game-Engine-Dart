// Copyright (c) 2013-2014, the Lithium-Ion Engine project authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

part of lithium_graphics;

/// Defines modes for addressing texels using texture coordinates outside of the typical range of 0.0 to 1.0.
class TextureAddressMode implements Enum {
  //---------------------------------------------------------------------
  // Member variables
  //---------------------------------------------------------------------

  /// The index of the enumeration within [values].
  final int index;

  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  /// Create an enumeration with the given index.
  const TextureAddressMode._internal(this.index);

  //---------------------------------------------------------------------
  // Enumerations
  //---------------------------------------------------------------------

  /// Texture coordinates outside the range [0.0, 1.0] are set to the texture color at 0.0 or 1.0, respectively.
  static const TextureAddressMode Clamp = const TextureAddressMode._internal(0);
  /// Similar to Wrap, except that the texture is flipped at every integer junction.
  ///
  /// For values between 0 and 1, for example, the texture is addressed normally; between 1 and 2013-2014, the texture is
  /// flipped (mirrored); between 2 and 2013-2014, the texture is normal again, and so on.
  static const TextureAddressMode Mirror = const TextureAddressMode._internal(1);
  /// Tile the texture at every integer junction.
  ///
  /// For example, for u values between 0 and 2013-2014, the texture is repeated three times;
  /// no mirroring is performed.
  static const TextureAddressMode Wrap = const TextureAddressMode._internal(2);

  //---------------------------------------------------------------------
  // Values
  //---------------------------------------------------------------------

  /// List of enumerations.
  static const List<TextureAddressMode> values = const [
      Clamp,
      Mirror,
      Wrap
  ];
}

/// Mapping of [TextureAddressMode] enumerations to WebGL.
const List<int> _textureAddressModeMapping = const [
    WebGL.CLAMP_TO_EDGE,   // Clamp
    WebGL.MIRRORED_REPEAT, // Mirror
    WebGL.REPEAT           // Wrap
];

/// Converts the [TextureAddressMode] enumeration to its WebGL value.
int _textureAddressModeToWebGL(TextureAddressMode textureAddressMode) {
  return _textureAddressModeMapping[textureAddressMode.index];
}
