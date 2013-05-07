// Copyright (c) 2013, the Lihtium-Ion Engine Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

part of lithium_mesh;

/// Base class for mesh generation.
///
/// Contains the base information for what vertex attributes should be
/// generated. This includes texture coordinates, normal data, and
/// tangent data. Additionally the generator provides methods to
/// calculate the normal, and tangent data.
///
/// Mesh generators do not allocate any memory, instead the client is
/// expected to query the number of vertices and indices required and
/// pass in an array with enough space to hold the mesh data.
abstract class MeshGenerator {
  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  /// Creates an instance of the MeshGenerator class.
  MeshGenerator();

  //---------------------------------------------------------------------
  // Properties
  //---------------------------------------------------------------------

  /// Gets the number of vertices that will be generated.
  int get vertexCount;

  /// Retrieves the size of the index buffer necessary to hold the generated [Mesh].
  int get indexCount;

  //---------------------------------------------------------------------
  // Public methods
  //---------------------------------------------------------------------

  /// Adds the generated mesh's data to the [vertices] and [indices].
  ///
  /// Specifying the [center] point changes the location the position data is
  /// generated at. By default the mesh will be centered at \[0.0, 0.0, 0.0\].
  /// Additionally an offset into the vertex and index data can be specified by
  /// [vertexOffset] and [indexOffset]. If unspecified the mesh will be
  /// generated at the start of the arrays.
  void generateMesh(VertexList vertices, Uint16List indices, [vec3 center, int vertexOffset = 0, int indexOffset = 0]) {
    // Ensure that there is enough room in the vertex and index data to hold the mesh
    if (vertices.vertexCount < vertexOffset + vertexCount) {
      throw new ArgumentError('The vertex data does not have enough space to hold the mesh');
    }

    if (indices.length < indexOffset + indexCount) {
      throw new ArgumentError('The index data does not have enough space to hold the mesh');
    }

    // Default to a center at (0, 0, 0)
    if (center == null) {
      center = new vec3.zero();
    }

    // Generate position data
    Vector3List positions = vertices.positions;

    if (positions == null) {
      throw new ArgumentError('The vertex data does not contain a position attribute');
    }

    _generatePositions(positions, center, vertexOffset);

    // Generate indices
    _generateIndices(indices, vertexOffset, indexOffset);

    // Generate texture coordinates if requested
    Vector2List texCoords = vertices.textureCoordinates;

    if (texCoords != null) {
      _generateTextureCoordinates(texCoords, vertexOffset);
    }

    // Generate normals if requested
    Vector3List normals = vertices.normals;

    if (normals != null) {
      _generateNormals(positions, normals, indices, vertexOffset, indexOffset);
    }

    // Generate texture data if requested
    Vector3List tangents  = vertices.tangents;
    Vector3List binormals = vertices.binormals;

    if ((tangents != null) && (binormals != null)) {
      _generateTangents(positions, texCoords, normals, tangents, binormals, indices, vertexOffset, indexOffset);
    }
  }

  //---------------------------------------------------------------------
  // Private methods
  //---------------------------------------------------------------------

  /// Populates the indices for the mesh.
  ///
  /// Index data will be placed within the [indices] array starting at the
  /// specified [indexOffset].
  void _generateIndices(Uint16List indices, int vertexOffset, int indexOffset);

  /// Generates the positions for the mesh.
  ///
  /// Positions will be placed within the [positions] array starting at the
  /// specified [vertexOffset]. When complete \[[vertexOffset], [vertexOffset]
  /// + [vertexCount]\] within the array will be populated.
  ///
  /// The mesh will be centered at the given [center] position.
  void _generatePositions(Vector3List positions, vec3 center, int vertexOffset);

  /// Generates the texture coordinates for the mesh.
  ///
  /// Texture coordinates will be placed within the [texCoords] array starting
  /// at the specified [vertexOffset]. When complete the \[[vertexOffset],
  /// [vertexOffset] + [vertexCount]\] within the array will be populated.
  void _generateTextureCoordinates(Vector2List texCoords, int vertexOffset);

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
    NormalDataBuilder.build(
        positions,
        normals,
        indices,
        vertexOffset,
        vertexCount,
        indexOffset,
        indexCount
    );
  }

  /// Generates the tangent data for the mesh.
  void _generateTangents(Vector3List positions, Vector2List texCoords, Vector3List normals, Vector3List tangents, Vector3List bitangents, Uint16List indices, int vertexOffset, int indexOffset) {
    TangentSpaceBuilder.build(
        positions,
        texCoords,
        normals,
        tangents,
        bitangents,
        indices,
        vertexOffset,
        vertexCount,
        indexOffset,
        indexCount
    );
  }

  /// Creates a single [Mesh] using the supplied [MeshGenerator].
  ///
  /// Provides a shorthand way for [MeshGenerator]s to create a single mesh.
  /// The [MeshGenerator] should be supplied with any options regarding its
  /// creation before calling this.
  static Mesh _createMesh(GraphicsDevice graphicsDevice, VertexDeclaration declaration, MeshGenerator generator, vec3 center) {
    // Create storage space for the vertices and indices
    var vertices = new VertexList(declaration, generator.vertexCount);
    var indices  = new Uint16List(generator.indexCount);

    // Generate the box
    generator.generateMesh(vertices, indices, center);

    // Upload the graphics data
    var vertexBuffer = new VertexBuffer.static(graphicsDevice);
    vertexBuffer.setData(vertices.getBuffer(0));

    var indexBuffer = new IndexBuffer.static(graphicsDevice);
    indexBuffer.setData(indices);

    // Create the mesh
    Mesh mesh = new Mesh(graphicsDevice, declaration, [ vertexBuffer ], indexBuffer);

    return mesh;
  }
}
