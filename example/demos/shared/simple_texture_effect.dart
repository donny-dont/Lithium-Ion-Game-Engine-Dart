// Copyright (c) 2012, the Lihtium-Ion Engine project authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

part of lithium_demos;

/// Source code for the colored vertex shader.
const String _simpleTextureVertexSource =
'''
attribute vec3 vPosition;
attribute vec2 vTexCoord0;

uniform mat4 uMVPMatrix;

varying highp vec2 texCoord;

void main() {
  texCoord = vTexCoord0;

  gl_Position = uMVPMatrix[0] * vec4(vPosition, 1.0);
}
''';

/// Source code for the colored pixel shader.
const String _simpleTexturePixelSource =
'''
uniform sampler2D uTexture;

varying highp vec2 texCoord;

void main() {
  gl_FragColor = texture2D(uTexture, texCoord);
}
''';

/// The name of the colored vertex shader.
const String _simpleTextureVertexName = 'textureVertex';
/// The name of the colored pixel shader.
const String _simpleTexturePixelName = 'texturePixel';


/// Creates an [Effect] for rendering a texture onto a mesh.
///
/// The created [Effect] has a single [EffectTechnique] which contains a single
/// [EffectPass].
///
///     var effect = createSimpleTextureEffect(device);
///
///     // Apply the effect paramter
///     effect.parameters['uMVPMatrix'] = mvpMatrix;
///     effect.parameters['uTexture'] = texture;
///
///     // Get the pass
///     var technique = effect.techniques['texmap'];
///     var pass = technique.passes[0];
///
///     // Apply the effect
///     context.effectPass = pass;
///
///     // Draw the mesh
///     context.setMesh(mesh);
///     context.drawIndexedPrimitives(PrimitiveType.TriangleStrip);
Effect createSimpleTextureEffect(GraphicsDevice device) {
  var effectBuilder = new EffectBuilder(device);

  // Add the vertex and pixel shaders to the effect
  effectBuilder.addVertexShader(_simpleTextureVertexName, _simpleTextureVertexSource);
  effectBuilder.addPixelShader(_simpleTexturePixelName, _simpleTexturePixelSource);

  // Create the pass
  effectBuilder.addEffectPass('texmap', _simpleTextureVertexName, _simpleTexturePixelName);

  // Create the effect
  return effectBuilder.create();
}
