// Copyright (c) 2013-2014, the Lithium-Ion Engine project authors.
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
  /// The model matrix for the pyramid.
  Matrix4 _pyramidMatrix = new Matrix4.identity();
  /// The [Mesh] containing the cube.
  Mesh _cubeMesh;
  /// The model matrix for the cube.
  Matrix4 _cubeMatrix = new Matrix4.identity();
  /// The [Effect] to use for rendering.
  Effect _effect;
  /// The [EffectPass] to use for rendering.
  EffectPass _effectPass;
  /// The view projection matrix.
  Matrix4 _vpMatrix;
  /// The model view projection matrix.
  Matrix4 _mvpMatrix;

  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  SimpleShapesScreen();

  //---------------------------------------------------------------------
  // Private methods
  //---------------------------------------------------------------------

  /// Loads all resources for the [SimpleScreen].
  Future<bool> _onLoad() {
    // Create the effect
    _effect = createColoredVertexEffect(_graphicsDevice);

    // Get the effect pass
    _effectPass = _effect.techniques['color'].passes[0];

    // Create the view projection matrix
    var view = makeViewMatrix(
        new Vector3(0.0, 0.0, 0.0), // Camera position
        new Vector3(0.0, 0.0, 1.0), // Look at
        new Vector3(0.0, 1.0, 0.0)  // Up direction
    );

    var projection = makePerspectiveMatrix(
        45,         // Degrees
        16.0 / 9.0, // Aspect ratio
        0.0001,
        1000.0
    );

    _vpMatrix = projection * view;

    _graphicsContext.viewport = new Viewport.bounds(_graphicsDevice, 0, 0, 1280, 720);

    // Create the meshes
    _pyramidMesh = _createPyramid();
    _cubeMesh = _createCube();

    // Everything has loaded successfully return a completed future
    return new Future.value(true);
  }

  /// Creates a pyramid mesh with colored vertices.
  Mesh _createPyramid() {
    // Define how the vertex data should be laid out
    var declaration = new VertexDeclaration.positionColor(_graphicsDevice);

    // Create a VertexList to generate the data
    var vertices = new VertexList(declaration, 12);

    // Create the vertex data
    var positions = vertices.positions;
    var colors = vertices.colors;

    positions[0]  = new Vector3( 0.0,  0.5,  0.0); colors[0]  = Color.red;   // Top Of Triangle   (Front)
    positions[1]  = new Vector3(-0.5, -0.5,  0.5); colors[1]  = Color.green; // Left Of Triangle  (Front)
    positions[2]  = new Vector3( 0.5, -0.5,  0.5); colors[2]  = Color.blue;  // Right Of Triangle (Front)

    positions[3]  = new Vector3( 0.0,  0.5,  0.0); colors[3]  = Color.red;   // Top Of Triangle   (Right)
    positions[4]  = new Vector3( 0.5, -0.5,  0.5); colors[4]  = Color.blue;  // Left Of Triangle  (Right)
    positions[5]  = new Vector3( 0.5, -0.5, -0.5); colors[5]  = Color.green; // Right Of Triangle (Right)

    positions[6]  = new Vector3( 0.0,  0.5,  0.0); colors[6]  = Color.red;   // Top Of Triangle   (Back)
    positions[7]  = new Vector3( 0.5, -0.5, -0.5); colors[7]  = Color.green; // Left Of Triangle  (Back)
    positions[8]  = new Vector3(-0.5, -0.5, -0.5); colors[8]  = Color.blue;  // Right Of Triangle (Back)

    positions[9]  = new Vector3( 0.0,  0.5,  0.0); colors[9]  = Color.red;   // Top Of Triangle   (Left)
    positions[10] = new Vector3(-0.5, -0.5, -0.5); colors[10] = Color.blue;  // Left Of Triangle  (Left)
    positions[11] = new Vector3(-0.5, -0.5,  0.5); colors[11] = Color.green; // Right Of Triangle (Left)

    // Upload the graphics data
    var vertexBuffer = new VertexBuffer.static(_graphicsDevice);
    vertexBuffer.setData(vertices.getBuffer(0));

    // Create the mesh
    Mesh mesh = new Mesh(_graphicsDevice, declaration, [ vertexBuffer ]);

    return mesh;
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

    // Generate the mesh
    //
    // By default the generator will create a unit cube.
    generator.generateMesh(vertices, indices);

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
    // Dispose of the meshes to reclaim memory
    _pyramidMesh.dispose();
    _cubeMesh.dispose();
  }

  /// Updates the state of the [SimpleScreen].
  void _onUpdate() {
    var time = new Time();
    var angle = (time.currentTime * 0.001);

    // Position the pyramid and rotate around its y axis
    _pyramidMatrix.setIdentity();
    _pyramidMatrix.setTranslationRaw(1.5, 0.0, 3.0);
    _pyramidMatrix.rotateY(angle);

    // Position the cube and rotate it around an axis
    _cubeMatrix.setIdentity();
    _cubeMatrix.setTranslationRaw(-1.5, 0.0, 3.0);
    _cubeMatrix.rotate(new Vector3(1.0, 1.0, 1.0), angle);
  }

  /// Renders the [SimpleScreen].
  void _onDraw() {
    // Clear the screen
    _graphicsContext.clearColor = Color.blueViolet;
    _graphicsContext.clearBuffers();

    // Set the EffectPass
    _graphicsContext.effectPass = _effectPass;

    // Draw the pyramid
    _effect.parameters['uMVPMatrix'] = _vpMatrix * _pyramidMatrix;

    _graphicsContext.setMesh(_pyramidMesh);
    _graphicsContext.drawVertexPrimitiveRange(PrimitiveType.TriangleStrip, 0, 12);

    // Draw the cube
    _effect.parameters['uMVPMatrix'] = _vpMatrix * _cubeMatrix;

    _graphicsContext.setMesh(_cubeMesh);
    _graphicsContext.drawIndexedPrimitives(PrimitiveType.TriangleList);
  }
}
