// Copyright (c) 2012, the Lihtium-Ion Engine project authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

part of lithium_graphics;

/// Defines the faces of a cube map in the [TextureCube] class type.
class CubeMapFace implements Enum {
  //---------------------------------------------------------------------
  // Member variables
  //---------------------------------------------------------------------

  /// The index of the enumeration within [values].
  final int index;

  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  /// Create an enumeration with the given index.
  const CubeMapFace._internal(this.index);

  //---------------------------------------------------------------------
  // Enumerations
  //---------------------------------------------------------------------

  /// Negative x-face of the cube map.
  static const CubeMapFace NegativeX = const CubeMapFace._internal(0);
  /// Negative y-face of the cube map.
  static const CubeMapFace NegativeY = const CubeMapFace._internal(1);
  /// Negative z-face of the cube map.
  static const CubeMapFace NegativeZ = const CubeMapFace._internal(2);
  /// Positive x-face of the cube map.
  static const CubeMapFace PositiveX = const CubeMapFace._internal(3);
  /// Positive y-face of the cube map.
  static const CubeMapFace PositiveY = const CubeMapFace._internal(4);
  /// Positive z-face of the cube map.
  static const CubeMapFace PositiveZ = const CubeMapFace._internal(5);

  //---------------------------------------------------------------------
  // Values
  //---------------------------------------------------------------------

  /// List of enumerations.
  static const List<TextureAddressMode> values = const [
      NegativeX,
      NegativeY,
      NegativeZ,
      PositiveX,
      PositiveY,
      PositiveZ
  ];
}

/// Mapping of [CubeMapFace] enumerations to WebGL.
const List<int> _cubeMapFaceMapping = const [
    WebGL.TEXTURE_CUBE_MAP_NEGATIVE_X, // NegativeX
    WebGL.TEXTURE_CUBE_MAP_NEGATIVE_Y, // NegativeY
    WebGL.TEXTURE_CUBE_MAP_NEGATIVE_Z, // NegativeZ
    WebGL.TEXTURE_CUBE_MAP_POSITIVE_X, // PositiveX
    WebGL.TEXTURE_CUBE_MAP_POSITIVE_Y, // PositiveY
    WebGL.TEXTURE_CUBE_MAP_POSITIVE_Z  // PositiveZ
];

/// Converts the [CubeMapFace] enumeration to its WebGL value.
int _cubeMapFaceToWebGL(CubeMapFace cubeMapFace) {
  return _cubeMapFaceMapping[cubeMapFace.index];
}
