// Copyright (c) 2013-2014, the Lithium-Ion Engine Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

library index_buffer_test;

import 'dart:typed_data';
import 'dart:web_gl' as WebGL;

import 'package:unittest/unittest.dart';
import 'package:unittest/mock.dart';
import 'package:lithium_ion/graphics.dart';

import 'graphics_mocks.dart';
import '../test_helpers.dart';

var graphicsDevice;
var gl;

void testSetData(IndexBuffer buffer, IndexElementSize elementSize) {
  // Create buffer data
  var data = (elementSize == IndexElementSize.Short)
      ? new Uint16List(4)
      : new Uint32List(4);

  data[0] = 0;
  data[1] = 1;
  data[2] = 2;
  data[3] = 3;

  buffer.setData(data);

  expect(buffer.indexCount, data.length);

  gl.getLogs(callsTo('bufferDataTyped', WebGL.ELEMENT_ARRAY_BUFFER, data, buffer.bufferUsage)).verify(happenedOnce);
}

void testReplaceData(IndexBuffer buffer, IndexElementSize elementSize) {
  // Replace portions of the buffer data
  var subData = (elementSize == IndexElementSize.Short)
      ? new Uint16List(2)
      : new Uint32List(2);

  subData[0] = 4;
  subData[1] = 5;

  int offset = (elementSize == IndexElementSize.Short) ? 2 : 4;

  buffer.replaceData(subData, offset);

  gl.getLogs(callsTo('bufferSubDataTyped', WebGL.ELEMENT_ARRAY_BUFFER, offset, subData)).verify(happenedOnce);
}

void testConstructor(BufferUsage bufferUsage, IndexElementSize elementSize) {
  // Clear the logs
  gl.clearLogs();

  // Create the buffer
  var buffer = (bufferUsage == BufferUsage.Static)
      ? new IndexBuffer.static(graphicsDevice, elementSize)
      : new IndexBuffer.dynamic(graphicsDevice, elementSize);

  expect(buffer.bufferUsage, bufferUsage);
  expect(buffer.indexElementSize, elementSize);
  expect(buffer.indexCount, 0);

  testSetData(buffer, elementSize);
  testReplaceData(buffer, elementSize);

  // Check GL calls
  gl.getLogs(callsTo('createBuffer')).verify(happenedOnce);
  gl.getLogs(callsTo('bindBuffer')).verify(happenedOnce);

  expect(gl.log.logs.length, 4);
}

void main() {
  graphicsDevice = createMockGraphicsDevice();
  gl = graphicsDevice.gl as MockRenderingContext;

  // Construction
  test('construction', () {
    testConstructor(BufferUsage.Static , IndexElementSize.Short);
    testConstructor(BufferUsage.Static , IndexElementSize.Integer);

    testConstructor(BufferUsage.Dynamic, IndexElementSize.Short);
    testConstructor(BufferUsage.Dynamic, IndexElementSize.Integer);

    var graphicsDeviceNoExtensions = createMockGraphicsDeviceNoExtensions();

    expect(() { var indexBuffer = new IndexBuffer.static(graphicsDeviceNoExtensions, IndexElementSize.Integer); }, throwsAssertionError);
  });

  // Test assertions
  test('setData', () {
    var buffer16 = new IndexBuffer.static(graphicsDevice, IndexElementSize.Short);

    expect(() { testSetData(buffer16, IndexElementSize.Integer); }, throwsAssertionError);

    var buffer32 = new IndexBuffer.static(graphicsDevice, IndexElementSize.Integer);

    expect(() { testSetData(buffer32, IndexElementSize.Short); }, throwsAssertionError);
  });

  test('replaceData', () {
    var buffer16 = new IndexBuffer.static(graphicsDevice, IndexElementSize.Short);
    testSetData(buffer16, IndexElementSize.Short);
    gl.clearLogs();

    expect(() { testReplaceData(buffer16, IndexElementSize.Integer); }, throwsAssertionError);

    var buffer32 = new IndexBuffer.static(graphicsDevice, IndexElementSize.Integer);
    testSetData(buffer32, IndexElementSize.Integer);
    gl.clearLogs();

    expect(() { testReplaceData(buffer32, IndexElementSize.Short); }, throwsAssertionError);
  });
}
