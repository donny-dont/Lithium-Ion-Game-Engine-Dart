// Copyright (c) 2013, the Lihtium-Ion Engine Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

library lithium_mesh;

//---------------------------------------------------------------------
// Standard libraries
//---------------------------------------------------------------------

import 'dart:math' as Math;
import 'dart:typed_data';

//---------------------------------------------------------------------
// Package libraries
//---------------------------------------------------------------------

import 'package:lithium_ion/foundation.dart';
import 'package:lithium_ion/graphics.dart';
import 'package:vector_math/vector_math.dart';

//---------------------------------------------------------------------
// Mesh library
//---------------------------------------------------------------------

part 'src/mesh/box_generator.dart';
part 'src/mesh/mesh_generator.dart';
part 'src/mesh/normal_data_builder.dart';
part 'src/mesh/plane_generator.dart';
part 'src/mesh/tangent_space_builder.dart';

//---------------------------------------------------------------------
// Helper functions
//---------------------------------------------------------------------

/// Gets the maximum vertex index.
///
/// Uses the [offset], [length] and [lastIndex] to determine what the actual
/// maximum index should be. This is computed by adding the [length] to the [offset].
/// If that value is greater than [lastIndex] then [lastIndex] is returned.
///
/// The value of [length] can be null. If that's the case then the value in
/// [lastIndex] is always returned.
int _getMaxIndex(int offset, int length, int lastIndex) {
  if (length == null) {
    return lastIndex;
  } else {
    int maxIndex = offset + length;
    return Math.min(maxIndex, lastIndex);
  }
}

/// Helper method to add a [value] to the [array] at the given [index].
///
/// A [temp] value is passed in to the function to prevent additional allocations.
void _addToVector3(int index, Vector3List array, Vector3 value, Vector3 temp) {
  array.getAt(index, temp);
  temp.add(value);
  array.setAt(index, temp);
}
