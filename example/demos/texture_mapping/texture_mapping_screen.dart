// Copyright (c) 2013-2014, the Lithium-Ion Engine project authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

part of lithium_demos;

/// Draws a cube with a texture map applied to it.
///
/// Matches the [NeHe 3D shapes tutorial](http://nehe.gamedev.net/tutorial/3d_shapes/10035/).
class TextureMappingScreen extends SimpleScreen {
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

  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  TextureMappingScreen();

  //---------------------------------------------------------------------
  // Private methods
  //---------------------------------------------------------------------

  /// Loads all resources for the [SimpleScreen].
  Future<bool> _onLoad() {
    var completer = new Completer<bool>();

    _textureManager.loadTexture('texture_mapping/textures/uv.jpg').then((texture) {
      // Create the effect
      _effect = createSimpleTextureEffect(_graphicsDevice);

      // Apply the texture to the effect
      _effect.parameters['uTexture'] = texture;

      // Get the effect pass
      _effectPass = _effect.techniques['texmap'].passes[0];

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
      _cubeMesh = _createCube();

      // The screen has been loaded
      completer.complete(true);
    });

    return completer.future;
  }

  /// Creates a cube with colored vertices.
  Mesh _createCube() {
    // Define how the vertex data should be laid out
    var declaration = new VertexDeclaration.positionTexture(_graphicsDevice);

    // Create the box mesh
    //
    // Since the
    return BoxGenerator.createBox(_graphicsDevice, declaration);
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
    _cubeMatrix.setTranslationRaw(0.0, 0.0, 2.0);
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
    _graphicsContext.drawIndexedPrimitives(PrimitiveType.TriangleList);
  }
}
