// Copyright (c) 2013, the Lihtium-Ion Engine Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

part of lithium_mesh;

/// Generates a Box mesh.
class BoxGenerator extends MeshGenerator {
  //---------------------------------------------------------------------
  // Member variables
  //---------------------------------------------------------------------

  /// The extents of the [Mesh] to generate.
  Vector3 _extents = new Vector3(0.5, 0.5, 0.5);

  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  /// Creates an instance of the [BoxGenerator] class.
  BoxGenerator();

  //---------------------------------------------------------------------
  // Properties
  //---------------------------------------------------------------------

  /// Gets the number of vertices that will be generated.
  int get vertexCount => 24;

  /// Retrieves the size of the index buffer necessary to hold the generated [Mesh].
  int get indexCount => 36;

  /// The extents of the box.
  Vector3 get extents => _extents;
  set extents(Vector3 value) {
    _extents.copyInto(value);

    // Get absolute value
    _extents.absolute();
  }

  //---------------------------------------------------------------------
  // Private mesh generation methods
  //---------------------------------------------------------------------

  /// Populates the indices for the mesh.
  ///
  /// Index data will be placed within the [indices] array starting at the
  /// specified [indexOffset].
  void _generateIndices(Uint16List indices, int vertexOffset, int indexOffset) {
    // Negative X
    indices[indexOffset++] =  0;  indices[indexOffset++] =  1;  indices[indexOffset++] =  2;
    indices[indexOffset++] =  0;  indices[indexOffset++] =  2;  indices[indexOffset++] =  3;

    // Negative Y
    indices[indexOffset++] =  4;  indices[indexOffset++] =  6;  indices[indexOffset++] =  7;
    indices[indexOffset++] =  4;  indices[indexOffset++] =  7;  indices[indexOffset++] =  5;

    // Negative Z
    indices[indexOffset++] =  8;  indices[indexOffset++] = 11;  indices[indexOffset++] = 10;
    indices[indexOffset++] =  8;  indices[indexOffset++] = 10;  indices[indexOffset++] =  9;

    // Positive Y
    indices[indexOffset++] = 15;  indices[indexOffset++] = 14;  indices[indexOffset++] = 13;
    indices[indexOffset++] = 15;  indices[indexOffset++] = 13;  indices[indexOffset++] = 12;

    // Positive Z
    indices[indexOffset++] = 18;  indices[indexOffset++] = 19;  indices[indexOffset++] = 16;
    indices[indexOffset++] = 18;  indices[indexOffset++] = 16;  indices[indexOffset++] = 17;

    // Positive X
    indices[indexOffset++] = 20;  indices[indexOffset++] = 22;  indices[indexOffset++] = 23;
    indices[indexOffset++] = 20;  indices[indexOffset++] = 23;  indices[indexOffset++] = 21;
  }

  /// Generates the positions for the mesh.
  ///
  /// Positions will be placed within the [positions] array starting at the
  /// specified [vertexOffset]. When complete \[[vertexOffset], [vertexOffset]
  /// + [vertexCount]\] within the array will be populated.
  ///
  /// The mesh will be centered at the given [center] position.
  void _generatePositions(Vector3List positions, Vector3 center, int vertexOffset) {
    // Create the position values
    double xExtent = _extents.x;
    double yExtent = _extents.y;
    double zExtent = _extents.z;

    double xCenter = center.x;
    double yCenter = center.y;
    double zCenter = center.z;

    List<Vector3> positionValues = [
      new Vector3(-xExtent + xCenter,  yExtent + yCenter,  zExtent + zCenter),
      new Vector3(-xExtent + xCenter,  yExtent + yCenter, -zExtent + zCenter),
      new Vector3(-xExtent + xCenter, -yExtent + yCenter, -zExtent + zCenter),
      new Vector3(-xExtent + xCenter, -yExtent + yCenter,  zExtent + zCenter),
      new Vector3( xExtent + xCenter, -yExtent + yCenter, -zExtent + zCenter),
      new Vector3( xExtent + xCenter, -yExtent + yCenter,  zExtent + zCenter),
      new Vector3( xExtent + xCenter,  yExtent + yCenter, -zExtent + zCenter),
      new Vector3( xExtent + xCenter,  yExtent + yCenter,  zExtent + zCenter)
    ];

    // Negative X
    positions[vertexOffset++] = positionValues[0];
    positions[vertexOffset++] = positionValues[1];
    positions[vertexOffset++] = positionValues[2];
    positions[vertexOffset++] = positionValues[3];

    // Negative Y
    positions[vertexOffset++] = positionValues[2];
    positions[vertexOffset++] = positionValues[3];
    positions[vertexOffset++] = positionValues[4];
    positions[vertexOffset++] = positionValues[5];

    // Negative Z
    positions[vertexOffset++] = positionValues[1];
    positions[vertexOffset++] = positionValues[2];
    positions[vertexOffset++] = positionValues[4];
    positions[vertexOffset++] = positionValues[6];

    // Positive Y
    positions[vertexOffset++] = positionValues[0];
    positions[vertexOffset++] = positionValues[1];
    positions[vertexOffset++] = positionValues[6];
    positions[vertexOffset++] = positionValues[7];

    // Positive Z
    positions[vertexOffset++] = positionValues[0];
    positions[vertexOffset++] = positionValues[3];
    positions[vertexOffset++] = positionValues[5];
    positions[vertexOffset++] = positionValues[7];

    // Positive X
    positions[vertexOffset++] = positionValues[4];
    positions[vertexOffset++] = positionValues[5];
    positions[vertexOffset++] = positionValues[6];
    positions[vertexOffset++] = positionValues[7];
  }

  /// Generates the texture coordinates for the mesh.
  ///
  /// Texture coordinates will be placed within the [texCoords] array starting
  /// at the specified [vertexOffset]. When complete the \[[vertexOffset],
  /// [vertexOffset] + [vertexCount]\] within the array will be populated.
  void _generateTextureCoordinates(Vector2List texCoords, int vertexOffset) {
    var texCoordValues = [
      new Vector2(0.0, 1.0),
      new Vector2(0.0, 0.0),
      new Vector2(1.0, 1.0),
      new Vector2(1.0, 0.0)
    ];

    // Negative X
    texCoords[vertexOffset++] = texCoordValues[3];
    texCoords[vertexOffset++] = texCoordValues[1];
    texCoords[vertexOffset++] = texCoordValues[0];
    texCoords[vertexOffset++] = texCoordValues[2];

    // Negative Y
    texCoords[vertexOffset++] = texCoordValues[1];
    texCoords[vertexOffset++] = texCoordValues[0];
    texCoords[vertexOffset++] = texCoordValues[3];
    texCoords[vertexOffset++] = texCoordValues[2];

    // Negative Z
    texCoords[vertexOffset++] = texCoordValues[1];
    texCoords[vertexOffset++] = texCoordValues[0];
    texCoords[vertexOffset++] = texCoordValues[2];
    texCoords[vertexOffset++] = texCoordValues[3];

    // Positive Y
    texCoords[vertexOffset++] = texCoordValues[1];
    texCoords[vertexOffset++] = texCoordValues[0];
    texCoords[vertexOffset++] = texCoordValues[2];
    texCoords[vertexOffset++] = texCoordValues[3];

    // Positive Z
    texCoords[vertexOffset++] = texCoordValues[1];
    texCoords[vertexOffset++] = texCoordValues[0];
    texCoords[vertexOffset++] = texCoordValues[2];
    texCoords[vertexOffset++] = texCoordValues[3];

    // Positive X
    texCoords[vertexOffset++] = texCoordValues[2];
    texCoords[vertexOffset++] = texCoordValues[0];
    texCoords[vertexOffset++] = texCoordValues[3];
    texCoords[vertexOffset++] = texCoordValues[1];
  }

  /// Generates the normals for the mesh.
  ///
  /// Normals will be placed within the [normals] array starting at the
  /// specified [vertexOffset]. When complete the \[[vertexOffset],
  /// [vertexOffset] + [vertexCount]\] within the array will be populated.
  ///
  /// Uses the values in the [indices] array and the [positions] array to
  /// calculate the normals of the mesh.
  ///
  /// A subclass should override this if the normals can easily be determined.
  /// This is the case for something like a box or plane.
  void _generateNormals(Vector3List positions, Vector3List normals, Uint16List indices, int vertexOffset, int indexOffset) {
    var normalValues = [
        new Vector3(-1.0,  0.0,  0.0),
        new Vector3( 0.0, -1.0,  0.0),
        new Vector3( 0.0,  0.0, -1.0),
        new Vector3( 0.0,  1.0,  0.0),
        new Vector3( 0.0,  0.0,  1.0),
        new Vector3( 1.0,  0.0,  0.0)
    ];

    // Negative X
    normals[vertexOffset++] = normalValues[0];
    normals[vertexOffset++] = normalValues[0];
    normals[vertexOffset++] = normalValues[0];
    normals[vertexOffset++] = normalValues[0];

    // Negative Y
    normals[vertexOffset++] = normalValues[1];
    normals[vertexOffset++] = normalValues[1];
    normals[vertexOffset++] = normalValues[1];
    normals[vertexOffset++] = normalValues[1];

    // Negative Z
    normals[vertexOffset++] = normalValues[2];
    normals[vertexOffset++] = normalValues[2];
    normals[vertexOffset++] = normalValues[2];
    normals[vertexOffset++] = normalValues[2];

    // Positive Y
    normals[vertexOffset++] = normalValues[3];
    normals[vertexOffset++] = normalValues[3];
    normals[vertexOffset++] = normalValues[3];
    normals[vertexOffset++] = normalValues[3];

    // Positive Z
    normals[vertexOffset++] = normalValues[4];
    normals[vertexOffset++] = normalValues[4];
    normals[vertexOffset++] = normalValues[4];
    normals[vertexOffset++] = normalValues[4];

    // Positive X
    normals[vertexOffset++] = normalValues[5];
    normals[vertexOffset++] = normalValues[5];
    normals[vertexOffset++] = normalValues[5];
    normals[vertexOffset++] = normalValues[5];
  }

  //---------------------------------------------------------------------
  // Single mesh generation
  //---------------------------------------------------------------------

  /// Creates a single box with the given [extents] at the specified [center].
  ///
  /// This is a helper method for creating a single box. If you are creating
  /// many box meshes prefer creating a [BoxGenerator] and using that to generate
  /// multiple meshes.
  static Mesh createBox(GraphicsDevice graphicsDevice,
                        VertexDeclaration declaration,
                       {Vector3 extents,
                        Vector3 center})
  {
    // Setup the generator
    var generator = new BoxGenerator();

    if (extents != null) {
      generator.extents = extents;
    }

    // Create the mesh
    return MeshGenerator._createMesh(graphicsDevice, declaration, generator, center);
  }
}
