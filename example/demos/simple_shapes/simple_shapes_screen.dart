// Copyright (c) 2012, the Lihtium-Ion Engine project authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

part of lithium_demos;

/// Draws a pyramid and cube using vertex colors.
///
/// Matches the [NeHe 3D shapes tutorial](http://nehe.gamedev.net/tutorial/3d_shapes/10035/).
class SimpleShapesScreen extends SimpleScreen {
  //---------------------------------------------------------------------
  // Member variables
  //---------------------------------------------------------------------

  /// The [Mesh] containing the pyramid.
  Mesh _pyramidMesh;
  /// The [Mesh] containing the cube.
  Mesh _cubeMesh;

  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  SimpleShapesScreen();

  //---------------------------------------------------------------------
  // Private methods
  //---------------------------------------------------------------------

  /// Loads all resources for the [SimpleScreen].
  Future<bool> _onLoad() {
    // Create the meshes
    _pyramidMesh = _createPyramid();
    _cubeMesh = _createCube();

    return new Future.value(true);
  }

  /// Creates a pyramid mesh with colored vertices.
  Mesh _createPyramid() {
    // Define how the vertex data should be laid out
    var declaration = new VertexDeclaration.positionColor(_graphicsDevice);

    // Create a VertexList to generate the data
    var vertices = new VertexList(declaration, 4);
  }

  /// Creates a cube with colored vertices.
  Mesh _createCube() {
    // Create a BoxGenerator to create the mesh data
    var generator = new BoxGenerator();

    // Define how the vertex data should be laid out
    var declaration = new VertexDeclaration.positionColor(_graphicsDevice);

    // Query the storage requirements for creating a cube and create the data
    var vertices = new VertexList(declaration, generator.vertexCount);
    var indices  = new Uint16List(generator.indexCount);

    // The BoxGenerator does not know how to create color data so this
    // needs to be created manually
    var colors = vertices.colors;

    // Each face should have a unique color
    var faceColors = [
        Color.blue,   // Negative X (left)
        Color.orange, // Negative Y (bottom)
        Color.yellow, // Negative Z (back)
        Color.green,  // Positive Y (top)
        Color.red,    // Positive Z (front)
        Color.violet  // Positive X (right)
    ];

    int faceCount = faceColors.length;
    int vertexIndex = 0;

    for (int i = 0; i < faceCount; ++i) {
      var color = faceColors[i];

      // Each face has 4 vertices associated with it
      colors[vertexIndex++] = color;
      colors[vertexIndex++] = color;
      colors[vertexIndex++] = color;
      colors[vertexIndex++] = color;
    }

    // Upload the graphics data
    var vertexBuffer = new VertexBuffer.static(_graphicsDevice);
    vertexBuffer.setData(vertices.getBuffer(0));

    var indexBuffer = new IndexBuffer.static(_graphicsDevice);
    indexBuffer.setData(indices);

    // Create the mesh
    Mesh mesh = new Mesh(_graphicsDevice, declaration, [ vertexBuffer ], indexBuffer);

    return mesh;
  }

  /// Unloads all resources for the [SimpleScreen].
  void _onUnload() {
    // Unload the meshes to reclaim memory
    _pyramidMesh.unload();
    _cubeMesh.unload();
  }

  /// Updates the state of the [SimpleScreen].
  void _onUpdate() {

  }

  /// Renders the [SimpleScreen].
  void _onDraw() {
    _graphicsDevice.gl.clearColor(1.0, 0.0, 0.0, 1.0);
    _graphicsDevice.gl.clear(WebGL.COLOR_BUFFER_BIT);
  }
}
