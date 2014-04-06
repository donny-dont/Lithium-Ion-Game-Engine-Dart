// Copyright (c) 2013-2014, the Lithium-Ion Engine Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

part of lithium_graphics;

/// Defines how to combine a source color with the destination color.
class BlendOperation implements Enum {
  //---------------------------------------------------------------------
  // Member variables
  //---------------------------------------------------------------------

  /// The index of the enumeration within [values].
  final int index;

  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  /// Create an enumeration with the given index.
  const BlendOperation._internal(this.index);

  //---------------------------------------------------------------------
  // Enumerations
  //---------------------------------------------------------------------

  /// The result is the destination added to the source.
  ///
  ///     Result = (Source Color * Source Blend) + (Destination Color * Destination Blend)
  static const BlendOperation Add = const BlendOperation._internal(0);
  /// The result is the source subtracted from the destination.
  ///
  ///     Result = (Destination Color * Destination Blend) - (Source Color * Source Blend)
  static const BlendOperation ReverseSubtract = const BlendOperation._internal(1);
  /// The result is the destination subtracted from the source.
  ///
  ///     Result = (Source Color * Source Blend) - (Destination Color * Destination Blend)
  static const BlendOperation Subtract = const BlendOperation._internal(2);

  //---------------------------------------------------------------------
  // Values
  //---------------------------------------------------------------------

  /// List of enumerations.
  static const List<BlendOperation> values = const [
      Add,
      ReverseSubtract,
      Subtract
  ];
}

/// Mapping of [BlendOperation] enumerations to WebGL.
const List<int> _blendOperationMapping = const [
    WebGL.FUNC_ADD,              // Add
    WebGL.FUNC_REVERSE_SUBTRACT, // ReverseSubtract
    WebGL.FUNC_SUBTRACT          // Subtract
];

/// Converts the [BlendOperation] enumeration to its WebGL value.
int blendOperationToWebGL(BlendOperation blendOperation) {
  return _blendOperationMapping[blendOperation.index];
}
