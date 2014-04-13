// Copyright (c) 2013-2014, the Lithium-Ion Engine project authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

part of lithium_demos;

/// Draws a batch of cubes through instancing.
class InstancingScreen extends SimpleScreen {
  //---------------------------------------------------------------------
  // Class variables
  //---------------------------------------------------------------------

  /// The number of instances per dimension.
  static const int _instanceLength = 10;
  /// The total number of instances.
  static const int _instanceCount = _instanceLength * _instanceLength * _instanceLength;
  /// The padding between each instance.
  static const double _instancePadding = 1.0;

  //---------------------------------------------------------------------
  // Member variables
  //---------------------------------------------------------------------

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

  InstancingScreen();

  //---------------------------------------------------------------------
  // Private methods
  //---------------------------------------------------------------------

  /// Loads all resources for the [SimpleScreen].
  Future<bool> _onLoad() {
    // Create the effect
    _effect = createInstancedColoredVertexEffect(_graphicsDevice);

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

    // Create the mesh
    _cubeMesh = _createInstancedCube();

    // Everything has loaded successfully return a completed future
    return new Future.value(true);
  }

  /// Creates instances of a cube mesh.
  Mesh _createInstancedCube() {
    // Create a BoxGenerator to create the mesh data
    var generator = new BoxGenerator();

    // Define how the vertex data should be laid out
    var perVertexSlot = 0;
    var perInstanceSlot = 1;

    var elements = [
        // Per-vertex data is at slot 0
        new VertexElement( 0, VertexElementFormat.Vector3, VertexElementUsage.Position         , slot: perVertexSlot),

        // Per-instance data is at slot 1
        new VertexElement( 0, VertexElementFormat.Vector3, VertexElementUsage.Color            , slot: perInstanceSlot, instanceDataStepRate: 1),
        new VertexElement(12, VertexElementFormat.Vector3, VertexElementUsage.TextureCoordinate, slot: perInstanceSlot, usageIndex: 1, instanceDataStepRate: 1)
    ];

    var declaration = new VertexDeclaration(_graphicsDevice, elements);

    // Query the storage requirements for creating a cube and create the data
    var vertices = new VertexList(declaration, generator.vertexCount, _instanceCount);
    var indices  = new Uint16List(generator.indexCount);

    // Generate the mesh
    //
    // By default the generator will create a unit cube.
    generator.generateMesh(vertices, indices);

    // Get the instance data
    var offsets = vertices.getElement(VertexElementUsage.TextureCoordinate, 1);
    var colors  = vertices.getElement(VertexElementUsage.Color, 0);

    // Create the instance data
    var position = new Vector3.zero();
    var incrementPositionBy = 1.0 + _instancePadding;
    var startPosition = -0.5 * (((_instanceLength - 1) * _instancePadding) + _instanceLength);

    var color = new Vector3.zero();
    var incrementColorBy = 1.0 / (_instanceLength - 1);

    position.x = startPosition;
    var i = 0;

    for (var x = 0; x < _instanceLength; ++x) {
      position.y = startPosition;
      color.y = 0.0;

      for (var y = 0; y < _instanceLength; ++y) {
        position.z = startPosition;
        color.z = 0.0;

        for (var z = 0; z < _instanceLength; ++z) {
          // Set the instance data
          offsets[i] = position;
          colors [i] = color;

          ++i;

          position.z += incrementPositionBy;
          color.z += incrementColorBy;
        }

        position.y += incrementPositionBy;
        color.y += incrementColorBy;
      }

      position.x += incrementPositionBy;
      color.x += incrementColorBy;
    }

    // Upload the graphics data
    var perVertexBuffer = new VertexBuffer.static(_graphicsDevice);
    perVertexBuffer.setData(vertices.getBuffer(perVertexSlot));

    var perInstanceBuffer = new VertexBuffer.static(_graphicsDevice);
    perInstanceBuffer.setData(vertices.getBuffer(perInstanceSlot));

    var indexBuffer = new IndexBuffer.static(_graphicsDevice);
    indexBuffer.setData(indices);

    // Create the mesh
    Mesh mesh = new Mesh(_graphicsDevice, declaration, [ perVertexBuffer, perInstanceBuffer ], indexBuffer);

    return mesh;
  }

  /// Unloads all resources for the [SimpleScreen].
  void _onUnload() {
    // Dispose of the meshes to reclaim memory
    _cubeMesh.dispose();
  }

  /// Updates the state of the [SimpleScreen].
  void _onUpdate() {
    var time = new Time();
    var angle = (time.currentTime * 0.001);

    // Position the cube and rotate it around an axis
    _cubeMatrix.setIdentity();
    _cubeMatrix.setTranslationRaw(0.0, 0.0, 17.5);
    _cubeMatrix.rotate(new Vector3(1.0, 0.0, 0.0), angle);
    _cubeMatrix.rotate(new Vector3(0.0, 1.0, 0.0), angle);
    _cubeMatrix.rotate(new Vector3(0.0, 0.0, 1.0), angle);
  }

  /// Renders the [SimpleScreen].
  void _onDraw() {
    // Clear the screen
    _graphicsContext.clearColor = Color.black;
    _graphicsContext.clearBuffers();

    // Set the EffectPass
    _graphicsContext.effectPass = _effectPass;

    // Draw the cube
    _effect.parameters['uMVPMatrix'] = _vpMatrix * _cubeMatrix;

    _graphicsContext.setMesh(_cubeMesh);
    _graphicsContext.drawInstancedPrimitives(PrimitiveType.TriangleList, 0, _instanceCount);
  }
}
