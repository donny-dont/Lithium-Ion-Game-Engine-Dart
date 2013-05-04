// Copyright (c) 2013, the Lihtium-Ion Engine Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

part of lithium_mesh;

/// Contains functions for generating normals for arbitrary mesh data.
class NormalDataBuilder {
  /// Uses the index data and positions to compute the vertex [normals].
  ///
  /// To compute the normal for a vertex the [indices] are used to access the [positions]
  /// that make up a triangle face. The face normal is then computed and added to the value
  /// contained in [normals]. As a final step the values within [normals] are themselves
  /// normalized.
  ///
  /// It is assumed that the indices in the range \[indexOffset .. indexOffset + indexCount] refer
  /// only to vertices within the range \[[vertexOffset], .. [vertexOffset] + [vertexCount]\].
  /// No checks are done to ensure this. This is to remove the cost of determining the vertex
  /// range.
  ///
  /// It is also assumed that the values within [normals] are all set to (0, 0, 0). If this
  /// is not the case the values within [normals] will be incorrect.
  static void build(Vector3List positions, Vector3List normals, Uint16List indices, [int vertexOffset = 0, int vertexCount, int indexOffset = 0, int indexCount]) {
    // Temporary variables
    vec3 v0 = new vec3();
    vec3 v1 = new vec3();
    vec3 v2 = new vec3();

    // Get the maximum index within indices to use
    int maxIndex =_VertexDataBuilder._getMaxIndex(indexOffset, indexCount, indices.length);

    // Run through the indices computing the normals for each triangle
    // and adding them to the normal data
    for (int i = indexOffset; i < maxIndex; i += 3) {
      int i0 = indices[i];
      int i1 = indices[i + 1];
      int i2 = indices[i + 2];

      positions.getAt(i0, v0);
      positions.getAt(i1, v1);
      positions.getAt(i2, v2);

      // Compute the normal
      v1.sub(v0); // p0 = v1 - v0
      v2.sub(v0); // p0 = v2 - v0

      v1.cross(v2, v0); // cross(v1, v2)
      v0.normalize();

      // Add the normal to the vertices
      _VertexDataBuilder._addToVec3(i0, normals, v0, v1);
      _VertexDataBuilder._addToVec3(i1, normals, v0, v1);
      _VertexDataBuilder._addToVec3(i2, normals, v0, v1);
    }

    // Get the maximum vertex index
    int maxVertex = _VertexDataBuilder._getMaxIndex(vertexOffset, vertexCount, normals.length);

    // Normalize the values
    vec3 normal = new vec3();

    for (int i = vertexOffset; i < maxVertex; ++i) {
      normals.getAt(i, normal);
      normal.normalize();
      normals.setAt(i, normal);
    }
  }
}
