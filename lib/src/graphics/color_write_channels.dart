// Copyright (c) 2013-2014, the Lithium-Ion Engine project authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

part of lithium_graphics;

/// The color channels.
class ColorChannel implements Enum {
  //---------------------------------------------------------------------
  // Member variables
  //---------------------------------------------------------------------

  /// The index of the enumeration within [values].
  final int index;

  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  /// Create an enumeration with the given index.
  const ColorChannel._internal(this.index);

  //---------------------------------------------------------------------
  // Enumerations
  //---------------------------------------------------------------------

  /// The red component.
  static const ColorChannel Red = const ColorChannel._internal(0);
  /// The green component.
  static const ColorChannel Green = const ColorChannel._internal(1);
  /// The blue component.
  static const ColorChannel Blue = const ColorChannel._internal(2);
  /// The alpha component.
  static const ColorChannel Alpha = const ColorChannel._internal(3);
}

class ColorWriteChannels extends Flags<ColorChannel> {
  //---------------------------------------------------------------------
  // Member variables
  //---------------------------------------------------------------------

  static final ColorWriteChannels None = new ColorWriteChannels();
}
