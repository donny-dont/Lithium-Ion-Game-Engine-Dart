// Copyright (c) 2013-2014, the Lithium-Ion Engine project authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

part of lithium_demos;

/// Source code for the colored vertex shader.
const String _instancedColoredVertexSource =
'''
attribute vec3 vPosition;

attribute vec4 vColor;

uniform mat4 uMVPMatrix;

varying lowp vec4 color;

void main() {
  color = vColor;

  gl_Position = uMVPMatrix * vec4(vPosition, 1.0);
}
''';

/// Source code for the colored pixel shader.
const String _instancedColoredPixelSource =
'''
varying lowp vec4 color;

void main() {
  gl_FragColor = color;
}
''';

/// The name of the colored vertex shader.
const String _instancedColoredVertexName = 'instancedColorVertex';
/// The name of the colored pixel shader.
const String _instancedColoredPixelName = 'instancedColorPixel';


/// Creates an [Effect] for rendering colored vertices on instanced models.
///
/// The created [Effect] has a single [EffectTechnique] which contains a single
/// [EffectPass].
///
///     var effect = createColoredVertexEffect(device);
///
///     // Apply the effect parameter
///     effect.parameters['uMVPMatrix'] = mvpMatrix;
///
///     // Get the pass
///     var technique = effect.techniques['color'];
///     var pass = technique.passes[0];
///
///     // Apply the effect
///     context.effectPass = pass;
///
///     // Draw the mesh
///     context.setMesh(mesh);
///     context.drawIndexedPrimitives(PrimitiveType.TriangleList);
Effect createInstancedColoredVertexEffect(GraphicsDevice device) {
  var effectBuilder = new EffectBuilder(device);

  // Add the vertex and pixel shaders to the effect
  effectBuilder.addVertexShader(_coloredVertexName, _coloredVertexSource);
  effectBuilder.addPixelShader(_coloredPixelName, _coloredPixelSource);

  // Create the pass
  effectBuilder.addEffectPass('color', _coloredVertexName, _coloredPixelName);

  // Create the effect
  return effectBuilder.create();
}
