// Copyright (c) 2012, the Lihtium-Ion Engine project authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

part of lithium_graphics;

/// Defines the winding used to determine whether a triangle is front or back facing.
class FrontFace implements Enum {
  //---------------------------------------------------------------------
  // Member variables
  //---------------------------------------------------------------------

  /// The index of the enumeration within [values].
  final int index;

  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  /// Create an enumeration with the given index.
  const FrontFace._internal(this.index);

  //---------------------------------------------------------------------
  // Enumerations
  //---------------------------------------------------------------------

  /// Triangles are considered front-facing if its vertices are clockwise.
  static const FrontFace Clockwise = const FrontFace._internal(0);
  /// Triangles are considered front-facing if its vertices are counter-clockwise.
  static const FrontFace CounterClockwise = const FrontFace._internal(1);

  //---------------------------------------------------------------------
  // Values
  //---------------------------------------------------------------------

  /// List of enumerations.
  static const List<FrontFace> values = const [
      Clockwise,
      CounterClockwise
  ];
}

/// Mapping of [FrontFace] enumerations to WebGL.
const List<int> _frontFaceMapping = const [
    WebGL.CW, // Clockwise
    WebGL.CCW // CounterClockwise
];

/// Converts the [FrontFace] enumeration to its WebGL value.
int _frontFaceToWebGL(FrontFace frontFace) {
  return _frontFaceMapping[frontFace.index];
}
