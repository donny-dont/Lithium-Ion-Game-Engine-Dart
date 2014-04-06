// Copyright (c) 2013-2014, the Lithium-Ion Engine Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

library vertex_buffer_test;

import 'dart:typed_data';
import 'dart:web_gl' as WebGL;

import 'package:unittest/unittest.dart';
import 'package:unittest/mock.dart';
import 'package:lithium_ion/graphics.dart';

import 'graphics_mocks.dart';

var graphicsDevice;
var gl;

int bufferUsageToWebGL(BufferUsage bufferUsage) {
  return (bufferUsage == BufferUsage.Static)
      ? WebGL.STATIC_DRAW
      : WebGL.DYNAMIC_DRAW;
}

void testConstructor(BufferUsage bufferUsage) {
  // Clear the logs
  gl.clearLogs();

  // Create the buffer
  var buffer = (bufferUsage == BufferUsage.Static)
      ? new VertexBuffer.static(graphicsDevice)
      : new VertexBuffer.dynamic(graphicsDevice);

  expect(buffer.bufferUsage, bufferUsage);

  // Create buffer data
  var data = new Float32List(4);

  data[0] = 0.0;
  data[1] = 1.0;
  data[2] = 2.0;
  data[3] = 3.0;

  buffer.setData(data);

  // Replace portions of the buffer data
  var subData = new Float32List(2);

  subData[0] = 4.0;
  subData[1] = 5.0;

  const int offset = 4;

  buffer.replaceData(subData, offset);

  // Check GL calls
  gl.getLogs(callsTo('createBuffer')).verify(happenedOnce);
  gl.getLogs(callsTo('bindBuffer')).verify(happenedOnce);
  gl.getLogs(callsTo('bufferDataTyped', WebGL.ARRAY_BUFFER, data, bufferUsageToWebGL(bufferUsage))).verify(happenedOnce);
  gl.getLogs(callsTo('bufferSubDataTyped', WebGL.ARRAY_BUFFER, offset, subData)).verify(happenedOnce);

  expect(gl.log.logs.length, 4);
}

void main() {
  graphicsDevice = createMockGraphicsDevice();
  gl = graphicsDevice.gl as MockRenderingContext;

  // Construction
  test('construction', () {
    testConstructor(BufferUsage.Static);
    testConstructor(BufferUsage.Dynamic);
  });
}
