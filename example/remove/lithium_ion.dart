import 'dart:html';
import 'dart:typed_data';
import 'dart:web_gl' as WebGL;
import 'package:lithium_ion/graphics.dart';
import 'package:lithium_ion/mesh.dart';
import 'package:vector_math/vector_math.dart';

GraphicsDevice device;
GraphicsContext context;
WebGL.RenderingContext gl;
VertexDeclaration declaration;
VertexBuffer vertexBuffer;
Viewport viewport;
Mesh mesh;

WebGL.Program program;

String vertShader =
'''
attribute vec3 aVertexPosition;
attribute vec4 aVertexColor;

uniform mat4 uMVMatrix;
uniform mat4 uPMatrix;

varying lowp vec4 vColor;

void main(void) {
  gl_Position = uPMatrix * vec4(aVertexPosition, 1.0);
  vColor = aVertexColor;
}
''';

String fragShader =
'''
varying lowp vec4 vColor;

void main(void) {
  gl_FragColor = vColor;
  gl_FragColor = vec4(1.0, 1.0, 1.0, 1.0);
}
''';

void onGLError(RenderingErrorEvent error) {
  print('Error! ${error.error} ${error.methodName}');
}

void init() {
  var vert = gl.createShader(WebGL.VERTEX_SHADER);

  gl.shaderSource(vert, vertShader);
  gl.compileShader(vert);

  if (!gl.getShaderParameter(vert, WebGL.COMPILE_STATUS)) {
    print('An error occurred compiling the shaders: ' + gl.getShaderInfoLog(vert));
  }

  var frag = gl.createShader(WebGL.FRAGMENT_SHADER);

  gl.shaderSource(frag, fragShader);
  gl.compileShader(frag);

  if (!gl.getShaderParameter(frag, WebGL.COMPILE_STATUS)) {
    print('An error occurred compiling the shaders: ' + gl.getShaderInfoLog(frag));
  }

  program = gl.createProgram();

  gl.attachShader(program, vert);
  gl.attachShader(program, frag);

  gl.bindAttribLocation(program, VertexElementUsage.Position, 'aVertexPosition');
  gl.bindAttribLocation(program, VertexElementUsage.Color   , 'aVertexColor');

  gl.linkProgram(program);

  gl.deleteShader(vert);
  gl.deleteShader(frag);

  if (!gl.getProgramParameter(program, WebGL.LINK_STATUS)) {
    print('Unable to initialize the shader program.');
  }

  gl.useProgram(program);

  var pMatrixList = new Float32List(16);
  var pMatrix = makePerspectiveMatrix(45.0, 640.0 / 480.0, 0.1, 100.0);

  pMatrix.copyIntoArray(pMatrixList);

  var pUniform  = gl.getUniformLocation(program, 'uPMatrix');
  gl.uniformMatrix4fv(pUniform, false, pMatrixList);

  var vMatrix = new mat4.identity();//makeViewMatrix(new vec3(0.0, 0.0, -6.0), new vec3.zero(), new vec3(0.0, 1.0, 0.0));
  vMatrix.setTranslation(new vec3(0.0, 0.0, -6.0));
  var vMatrixList = new Float32List(16);

  vMatrix.copyIntoArray(pMatrixList);

  var mvUniform = gl.getUniformLocation(program, 'uMVMatrix');
  gl.uniformMatrix4fv(mvUniform, false, vMatrixList);
}

void update(num time) {
  gl.clear(WebGL.COLOR_BUFFER_BIT | WebGL.DEPTH_BUFFER_BIT);

  context.setMesh(mesh);
//  context.setVertexDeclaration(declaration);
//  context.setVertexBuffers([ vertexBuffer ]);

  context.drawIndexedPrimitives(PrimitiveType.TriangleList);

  window.animationFrame.then(update);
}

void main() {
  var surface = query('#surface') as CanvasElement;
  surface.width = 640;
  surface.height = 480;

  var config = new GraphicsDeviceConfig();
  //config.debug = f;

  device = new GraphicsDevice(surface, config);

  //print(device.capabilities);

  context = device.graphicsContext;
  gl = device.gl;
  //gl.onError.listen(onGLError);

  gl.clearColor(0.0, 0.0, 0.0, 1.0);

  init();

  declaration = new VertexDeclaration.positionColor(device);

  mesh = PlaneGenerator.createPlane(device, declaration, doubleSided: true, center: new vec3(0.0, 0.0, -2.0));
  //BoxGenerator.createBox(device, declaration, center: new vec3(0.0, 0.0, -2.0));

  var vertexList = new VertexList(declaration, 4);

  var positions = vertexList.positions;

  double positionZ = -4.0;

  positions[0] = new vec3( 1.0,  1.0, positionZ);
  positions[1] = new vec3(-1.0,  1.0, positionZ);
  positions[2] = new vec3( 1.0, -1.0, positionZ);
  positions[3] = new vec3(-1.0, -1.0, positionZ);

  var colors = vertexList.colors;

  colors[0] = new vec4(1.0, 1.0, 1.0, 1.0); // white
  colors[1] = new vec4(1.0, 0.0, 0.0, 1.0); // red
  colors[2] = new vec4(0.0, 1.0, 0.0, 1.0); // green
  colors[3] = new vec4(0.0, 0.0, 1.0, 1.0); // blue

  vertexBuffer = new VertexBuffer.static(device);

  var data = vertexList.getBuffer(0) as Float32List;

  vertexBuffer.setData(data);

  window.animationFrame.then(update);
}
