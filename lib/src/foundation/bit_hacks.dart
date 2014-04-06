// Copyright (c) 2013-2014, the Lithium-Ion Engine Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

part of lithium_foundation;

/// Determines whether a [flag] is enabled in the [value].
bool isFlagEnabled(int value, int flag) {
  return (value & flag) == flag;
}

/// Determines whether a [value] is a power of two.
///
/// Assumes that the given value will always be positive.
bool isPowerOfTwo(int value) {
  return (value & (value - 1)) == 0;
}
