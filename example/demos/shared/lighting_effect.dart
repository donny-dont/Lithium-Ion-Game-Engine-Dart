// Copyright (c) 2013-2014, the Lithium-Ion Engine project authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

part of lithium_demos;

/// Source code for the colored vertex shader.
const String _lightingVertexSource =
'''
attribute vec3 vPosition;
attribute vec4 vColor;

uniform mat4 uMVPMatrix[3];

varying lowp vec4 color;

void main() {
  color = vColor;

  gl_Position = uMVPMatrix[0] * vec4(vPosition, 1.0);
}
''';

/// Source code for the colored pixel shader.
const String _lightingPixelSource =
'''
precision highp float;
varying vec4 color;

struct Test
{
  vec4 color0;
  vec4 color1;
};

uniform Test structArray[10];
uniform Test testing;

void main() {
  vec4 accum = vec4(0.0, 0.0, 0.0, 0.0);

  for (int i = 0; i < 10; ++i) {
    accum += structArray[i].color0;
    accum += structArray[i].color1;
  }

  accum += testing.color0;
  accum += testing.color1;

  gl_FragColor = color * accum;
}
''';

/// The name of the colored vertex shader.
const String _lightingVertexName = 'colorVertex';
/// The name of the colored pixel shader.
const String _lightingPixelName = 'colorPixel';


/// Creates an [Effect] for rendering colored vertices.
///
/// The created [Effect] has a single [EffectTechnique] which contains a single
/// [EffectPass].
///
///     var effect = createColoredVertexEffect(device);
///
///     // Apply the effect parameter
///     effect.parameters['uMVPMatrix'].setValue(mvpMatrix);
///
///     // Get the pass
///     var technique = effect.techniques['color'];
///     var pass = technique.passes[0];
///
///     // Apply the effect
///     pass.apply();
///
///     // Draw the mesh
///     context.setMesh(mesh);
///     context.drawIndexedPrimitives(PrimitiveType.TriangleStrip);
Effect createLightingEffect(GraphicsDevice device) {
  var effectBuilder = new EffectBuilder(device);

  // Add the vertex and pixel shaders to the effect
  effectBuilder.addVertexShader(_lightingVertexName, _lightingVertexSource);
  effectBuilder.addPixelShader(_lightingPixelName, _lightingPixelSource);

  // Create the pass
  effectBuilder.addEffectPass('lighting', _lightingVertexName, _lightingPixelName);

  // Create the effect
  return effectBuilder.create();
}
