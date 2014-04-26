// Copyright (c) 2013-2014, the Lithium-Ion Engine Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

part of lithium_mesh;

class SphereGenerator extends MeshGenerator {
  //---------------------------------------------------------------------
  // Member variables
  //---------------------------------------------------------------------

  /// The radius of the [Mesh] to create
  num radius = 0.5;

  /// The number of segments the [Mesh] will be divided into vertically
  int latSegments = 16;

  /// The number of segments the [Mesh] will be divided into horizontally
  int lonSegments = 16;

  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  /// Creates an instance of the [SphereGenerator] class.
  SphereGenerator();

  //---------------------------------------------------------------------
  // Properties
  //---------------------------------------------------------------------

  /// Gets the number of vertices that will be generated.
  ///
  /// For the amount of storage space required see [vertexBufferSize].
  int get vertexCount => (lonSegments + 1) * (latSegments + 1);

  /// Retrieves the size of the index buffer necessary to hold the generated [Mesh].
  int get indexCount => 6 * lonSegments * latSegments;

  //---------------------------------------------------------------------
  // Private mesh generation methods
  //---------------------------------------------------------------------

  /// Populates the indices for the mesh.
  ///
  /// Index data will be placed within the [indices] array starting at the specified
  /// [indexOffset].
  void _generateIndices(Uint16List indices, int vertexOffset, int indexOffset) {
    int x;

    // Sides
    for (int y = 0; y < latSegments; ++y) {
      int base1 = (lonSegments + 1) * y;
      int base2 = (lonSegments + 1) * (y + 1);

      for(x = 0; x < lonSegments; ++x) {
        indices[indexOffset++] = base1 + x;
        indices[indexOffset++] = base1 + x + 1;
        indices[indexOffset++] = base2 + x;

        indices[indexOffset++] = base1 + x + 1;
        indices[indexOffset++] = base2 + x + 1;
        indices[indexOffset++] = base2 + x;
      }
    }
  }

  /// Generates the positions for the mesh.
  ///
  /// Positions will be placed within the [positions] array starting at the specified
  /// [vertexOffset]. When complete \[[vertexOffset], [vertexOffset] + [vertexCount]\]
  /// within the [array] will contain position data.
  ///
  /// The mesh will be centered at the given [center] position.
  void _generatePositions(Vector3List positions, Vector3 center, int vertexOffset) {
    for (int y = 0; y <= latSegments; ++y) {
      double v = y / latSegments;
      double sv = Math.sin(v * Math.PI);
      double cv = Math.cos(v * Math.PI);

      for (int x = 0; x <= lonSegments; ++x) {
        double u = x / lonSegments;

        positions[vertexOffset++] = new Vector3(
            radius * Math.cos(u * Math.PI * 2.0) * sv + center.x,
            radius * cv + center.y,
            radius * Math.sin(u * Math.PI * 2.0) * sv + center.z
        );
      }
    }
  }

  /// Generates the texture coordinates for the mesh.
  ///
  /// Texture coordinates will be placed within the [array] starting at the
  /// specified [vertexData]. When complete the \[[vertexOffset], [vertexOffset] + [vertexCount]\]
  /// within the [array] will contain texture coordinate data.
  void _generateTextureCoordinates(Vector2List texCoords, int vertexOffset) {
    for (int y = 0; y <= latSegments; ++y) {
      double v = y / latSegments;

      for (int x = 0; x <= lonSegments; ++x) {
        double u = x / lonSegments;
        texCoords[vertexOffset++] = new Vector2(u, v);
      }
    }
  }

  /// Generates the normals for the mesh.
  ///
  /// Normals will be placed within the [vertexArray] starting at the specified
  /// [vertexOffset]. When complete the \[[vertexOffset], [vertexOffset] + [vertexCount]\]
  /// within the [vertexArray] will contain normal data.
  void _generateNormals(Vector3List positions, Vector3List normals, Uint16List indices, int vertexOffset, int indexOffset) {
    for (int y = 0; y <= latSegments; ++y) {
      double v = y / latSegments;
      double sv = Math.sin(v * Math.PI);
      double cv = Math.cos(v * Math.PI);

      for (int x = 0; x <= lonSegments; ++x) {
        double u = x / lonSegments;

        normals[vertexOffset++] = new Vector3(
            Math.cos(u * Math.PI * 2.0) * sv,
            cv,
            Math.sin(u * Math.PI * 2.0) * sv
        );
      }
    }
  }

  //---------------------------------------------------------------------
  // Single mesh generation
  //---------------------------------------------------------------------

  /// Creates a single sphere with the given [radius] at the specified [center].
  ///
  /// This is a helper method for creating a single sphere. If you are creating
  /// many sphere meshes prefer creating a [SphereGenerator] and using that to generate
  /// multiple meshes.
  static Mesh createSphere(GraphicsDevice graphicsDevice,
                           VertexDeclaration declaration,
                          {num radius,
                           Vector3 center})
  {
    // Setup the generator
    SphereGenerator generator = new SphereGenerator();
    generator.radius = radius;

    // Create the mesh
    return MeshGenerator._createMesh(graphicsDevice, declaration, generator, center);
  }
}
