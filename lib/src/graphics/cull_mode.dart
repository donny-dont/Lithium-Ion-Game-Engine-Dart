// Copyright (c) 2013-2014, the Lithium-Ion Engine project authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

part of lithium_graphics;

/// Indicates whether triangles facing a particular direction are drawn.
class CullMode implements Enum {
  //---------------------------------------------------------------------
  // Member variables
  //---------------------------------------------------------------------

  /// The index of the enumeration within [values].
  final int index;

  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  /// Create an enumeration with the given index.
  const CullMode._internal(this.index);

  //---------------------------------------------------------------------
  // Enumerations
  //---------------------------------------------------------------------

  /// Always draw all triangles.
  static const CullMode None = const CullMode._internal(0);
  /// Do not draw triangles that are front-facing.
  static const CullMode Front = const CullMode._internal(1);
  /// Do not draw triangles that are back-facing.
  static const CullMode Back = const CullMode._internal(2);

  //---------------------------------------------------------------------
  // Values
  //---------------------------------------------------------------------

  /// List of enumerations.
  static const List<CullMode> values = const [
      None,
      Front,
      Back
  ];
}

/// Mapping of [CullMode] enumerations to WebGL.
const List<int> _cullModeMapping = const [
    0,           // None
    WebGL.FRONT, // Front
    WebGL.BACK   // Back
];

/// Converts the [CullMode] enumeration to its WebGL value.
int _cullModeToWebGL(CullMode cullMode) {
  return _cullModeMapping[cullMode.index];
}
