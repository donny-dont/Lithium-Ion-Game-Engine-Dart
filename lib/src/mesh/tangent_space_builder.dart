// Copyright (c) 2013-2014, the Lithium-Ion Engine Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

part of lithium_mesh;

/// Contains functions for generating tangents for arbitrary mesh data.
class TangentSpaceBuilder {

  static void build(Vector3List positions,
                    Vector2List texCoords,
                    Vector3List normals,
                    Vector3List tangents,
                    Vector3List bitangents,
                    Uint16List indices,
                   [int vertexOffset = 0,
                    int vertexCount,
                    int indexOffset = 0,
                    int indexCount])
  {
    // Get the maximum vertex index
    int maxVertex = _getMaxIndex(vertexOffset, vertexCount, tangents.length);

    // Create temporary arrays to hold the tangent data
    vertexCount = maxVertex - vertexOffset;

    var tan1 = new Vector3List(vertexCount);
    var tan2 = new Vector3List(vertexCount);

    {
      var v0 = new Vector3.zero();
      var v1 = new Vector3.zero();
      var v2 = new Vector3.zero();

      var w0 = new Vector2.zero();
      var w1 = new Vector2.zero();
      var w2 = new Vector2.zero();

      var tdir = new Vector3.zero();
      var sdir = new Vector3.zero();

      // Get the maximum index within indices to use
      int maxIndex = _getMaxIndex(indexOffset, indexCount, indices.length);

      for (int i = indexOffset; i < maxIndex; i += 3) {
        int i0 = indices[i];
        int i1 = indices[i + 1];
        int i2 = indices[i + 2];

        positions.getAt(i0, v0);
        positions.getAt(i1, v1);
        positions.getAt(i2, v2);

        texCoords.getAt(i0, w0);
        texCoords.getAt(i1, w1);
        texCoords.getAt(i2, w2);

        double x0 = v1.x - v0.x;
        double x1 = v2.x - v0.x;
        double y0 = v1.y - v0.y;
        double y1 = v2.y - v0.y;
        double z0 = v1.z - v0.z;
        double z1 = v2.z - v0.z;

        double s0 = w1.x - w0.x;
        double s1 = w2.x - w0.x;
        double t0 = w1.y - w0.y;
        double t1 = w2.y - w0.y;

        double r = 1.0 / ((s0 * t1) - (s1 * t0));

        sdir.setValues(
          ((t1 * x0) - (t0 * x1)) * r,
          ((t1 * y0) - (t0 * y1)) * r,
          ((t1 * z0) - (t0 * z1)) * r
        );

        tdir.setValues(
          ((s0 * x1) - (s1 * x0)) * r,
          ((s0 * y1) - (s1 * y0)) * r,
          ((s0 * z1) - (s1 * z0)) * r
        );

        // Take into account the offset
        i0 -= vertexOffset;
        i1 -= vertexOffset;
        i2 -= vertexOffset;

        _addToVector3(i0, tan1, sdir, v0);
        _addToVector3(i1, tan1, sdir, v0);
        _addToVector3(i2, tan1, sdir, v0);

        _addToVector3(i0, tan2, tdir, v0);
        _addToVector3(i1, tan2, tdir, v0);
        _addToVector3(i2, tan2, tdir, v0);
      }
    }

    {
      var n = new Vector3.zero();
      var t = new Vector3.zero();
      var nCrossT = new Vector3.zero();

      for (int i = vertexOffset, j = 0; i < maxVertex; ++i, ++j) {
        normals.getAt(i, n);
        tan1.getAt(j, t);

        double nDotT = n.dot(t);
        n.crossInto(t, nCrossT);

        n.x *= nDotT;
        n.y *= nDotT;
        n.z *= nDotT;
        t.sub(n);
        t.normalize();

        tangents.setAt(i, t);

        tan2.getAt(j, t);
        double h = nCrossT.dot(t) < 0.0 ? -1.0 : 1.0;
        nCrossT.x *= h;
        nCrossT.y *= h;
        nCrossT.z *= h;
        nCrossT.normalize();
        bitangents.setAt(i, nCrossT);
      }
    }
  }
}