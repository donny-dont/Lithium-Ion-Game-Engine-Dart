// Copyright (c) 2013, the Lihtium-Ion Engine Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

part of lithium_foundation;

// \TODO These functions should go away if vector_math gets any equality
//       operators for their classes

/// Determines whether two [vec2] instances are equal.
bool isVec2Equal(vec2 lhs, vec2 rhs) {
  return (lhs.x == rhs.x) && (lhs.y == rhs.y);
}

/// Determines whether two [vec3] instances are equal.
bool isVec3Equal(vec3 lhs, vec3 rhs) {
  return (lhs.x == rhs.x) && (lhs.y == rhs.y) && (lhs.z == rhs.z);
}

/// Determines whether two [vec4] instances are equal.
bool isVec4Equal(vec4 lhs, vec4 rhs) {
  return (lhs.x == rhs.x) && (lhs.y == rhs.y) && (lhs.z == rhs.z) && (lhs.w == rhs.w);
}
