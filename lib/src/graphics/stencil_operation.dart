// Copyright (c) 2013-2014, the Lithium-Ion Engine project authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

part of lithium_graphics;

/// Defines stencil buffer operations.
class StencilOperation implements Enum {
  //---------------------------------------------------------------------
  // Member variables
  //---------------------------------------------------------------------

  /// The index of the enumeration within [values].
  final int index;

  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  /// Create an enumeration with the given index.
  const StencilOperation._internal(this.index);

  //---------------------------------------------------------------------
  // Enumerations
  //---------------------------------------------------------------------

  /// Decrements the stencil-buffer entry, wrapping to the maximum value if the new value is less than 0.
  static const StencilOperation Decrement = const StencilOperation._internal(0);
  /// Decrements the stencil-buffer entry, clamping to 0.
  static const StencilOperation DecrementSaturation = const StencilOperation._internal(0);
  ///	Increments the stencil-buffer entry, wrapping to 0 if the new value exceeds the maximum value.
  static const StencilOperation Increment = const StencilOperation._internal(0);
  /// Increments the stencil-buffer entry, clamping to the maximum value.
  static const StencilOperation IncrementSaturation = const StencilOperation._internal(0);
  ///	Inverts the bits in the stencil-buffer entry.
  static const StencilOperation Invert = const StencilOperation._internal(0);
  /// Does not update the stencil-buffer entry.
  static const StencilOperation Keep = const StencilOperation._internal(0);
  ///	Replaces the stencil-buffer entry with a reference value.
  static const StencilOperation Replace = const StencilOperation._internal(0);
  ///	Sets the stencil-buffer entry to 0.
  static const StencilOperation Zero = const StencilOperation._internal(0);

  //---------------------------------------------------------------------
  // Values
  //---------------------------------------------------------------------

  /// List of enumerations.
  static const List<StencilOperation> values = const [
      Decrement,
      DecrementSaturation,
      Increment,
      IncrementSaturation,
      Invert,
      Keep,
      Replace,
      Zero
  ];
}

const List<int> _stencilOperationMapping = const [
    WebGL.DECR,      // Decrement
    WebGL.DECR_WRAP, // DecrementSaturation
    WebGL.INCR,      // Increment
    WebGL.INCR_WRAP, // IncrementSaturation
    WebGL.INVERT,    // Invert
    WebGL.KEEP,      // Keep
    WebGL.REPLACE,   // Replace
    WebGL.ZERO       // Zero
];

/// Converts the [StencilOperation] enumeration to its WebGL value.
int _stencilOperationToWebGL(StencilOperation stencilOperation)
    => _stencilOperationMapping[stencilOperation.index];
