// Copyright (c) 2013, the Lihtium-Ion Engine Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

part of lithium_foundation;

// \TODO These functions should go away if vector_math gets any equality
//       operators for their classes

/// Determines whether two [Vector2] instances are equal.
bool isVector2Equal(Vector2 lhs, Vector2 rhs) {
  return (lhs.x == rhs.x) && (lhs.y == rhs.y);
}

/// Determines whether two [Vector3] instances are equal.
bool isVector3Equal(Vector3 lhs, Vector3 rhs) {
  return (lhs.x == rhs.x) && (lhs.y == rhs.y) && (lhs.z == rhs.z);
}

/// Determines whether two [Vector4] instances are equal.
bool isVector4Equal(Vector4 lhs, Vector4 rhs) {
  return (lhs.x == rhs.x) && (lhs.y == rhs.y) && (lhs.z == rhs.z) && (lhs.w == rhs.w);
}
