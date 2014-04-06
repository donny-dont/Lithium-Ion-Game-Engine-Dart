// Copyright (c) 2013-2014, the Lithium-Ion Engine Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

library program_format_test;

import 'dart:convert';
import 'package:unittest/unittest.dart';
import 'package:lithium_ion/graphics.dart';
import 'package:lithium_ion/content.dart';

//---------------------------------------------------------------------
// Valid formats
//---------------------------------------------------------------------

String referenceString =
'''
{
  "name":"referenceProgram",
  "attributes": [
    {
      "semantic":"POSITION",
      "symbol":"vPosition"
    },
    {
      "semantic":"COLOR",
      "symbol":"vColor"
    },
    {
      "semantic":"COLOR_2",
      "symbol":"vColor2"
    }
  ],
  "vertexShader":"vertShader",
  "fragmentShader":"fragShader"
}
''';

void verifyReferences(ProgramFormat value) {
  expect(value.name, 'referenceProgram');

  // Test the attributes
  var position = value.attributes[0];

  expect(position.symbol    , 'vPosition');
  expect(position.usage     , VertexElementUsage.Position);
  expect(position.usageIndex, 0);

  var color0 = value.attributes[1];

  expect(color0.symbol    , 'vColor');
  expect(color0.usage     , VertexElementUsage.Color);
  expect(color0.usageIndex, 0);

  var color2 = value.attributes[2];

  expect(color2.symbol    , 'vColor2');
  expect(color2.usage     , VertexElementUsage.Color);
  expect(color2.usageIndex, 2);

  // Test vertex shader
  var vertex = value.vertexShader;

  expect(vertex.name       , 'vertShader');
  expect(vertex.isReference, true);
  expect(vertex.url        , null);
  expect(vertex.source     , null);
  expect(vertex.hasSource  , false);

  // Test fragment shader
  var fragment = value.fragmentShader;

  expect(fragment.name       , 'fragShader');
  expect(fragment.isReference, true);
  expect(fragment.url        , null);
  expect(fragment.source     , null);
  expect(fragment.hasSource  , false);
}

String sourceString =
'''
{
  "name":"sourceProgram",
  "attributes": [
    {
      "semantic":"POSITION",
      "symbol":"vPosition"
    },
    {
      "semantic":"NORMAL",
      "symbol":"vNormal"
    },
    {
      "semantic":"TANGENT",
      "symbol":"vTangent"
    },
    {
      "semantic":"TEXCOORD",
      "symbol":"vTexCoord0"
    },
    {
      "semantic":"TEXCOORD_1",
      "symbol":"vTexCoord1"
    }
  ],
  "vertexShader": {
    "name":"vertShader",
    "source":"void main(){}"
  },
  "fragmentShader": {
    "name":"fragShader",
    "source":"void main(){}"
  }
}
''';

void verifySources(ProgramFormat value) {
  expect(value.name, 'sourceProgram');

  // Test the attributes
  var position = value.attributes[0];

  expect(position.symbol    , 'vPosition');
  expect(position.usage     , VertexElementUsage.Position);
  expect(position.usageIndex, 0);

  var normal = value.attributes[1];

  expect(normal.symbol    , 'vNormal');
  expect(normal.usage     , VertexElementUsage.Normal);
  expect(normal.usageIndex, 0);

  var tangent = value.attributes[2];

  expect(tangent.symbol    , 'vTangent');
  expect(tangent.usage     , VertexElementUsage.Tangent);
  expect(tangent.usageIndex, 0);

  var texCoord0 = value.attributes[3];

  expect(texCoord0.symbol    , 'vTexCoord0');
  expect(texCoord0.usage     , VertexElementUsage.TextureCoordinate);
  expect(texCoord0.usageIndex, 0);

  var texCoord1 = value.attributes[4];

  expect(texCoord1.symbol    , 'vTexCoord1');
  expect(texCoord1.usage     , VertexElementUsage.TextureCoordinate);
  expect(texCoord1.usageIndex, 1);

  // Test vertex shader
  var vertex = value.vertexShader;

  expect(vertex.name       , 'vertShader');
  expect(vertex.isReference, false);
  expect(vertex.url        , null);
  expect(vertex.source     , 'void main(){}');
  expect(vertex.hasSource  , true);

  // Test fragment shader
  var fragment = value.fragmentShader;

  expect(fragment.name       , 'fragShader');
  expect(fragment.isReference, false);
  expect(fragment.url        , null);
  expect(fragment.source     , 'void main(){}');
  expect(fragment.hasSource  , true);
}

//---------------------------------------------------------------------
// ProgramFormat tests
//---------------------------------------------------------------------

ProgramFormat createProgramFormat(String value) {
  return new ProgramFormat.fromJson(JSON.decode(value));
}

void testValues() {
  // Check for a ShaderProgram using references to vertex and fragment shaders
  var reference = createProgramFormat(referenceString);

  verifyReferences(reference);

  // Check for a ShaderProgram with inline vertex and fragment shaders
  var source = createProgramFormat(sourceString);

  verifySources(source);
}

void testExceptions() {
  // Should throw if no name is provided
  String noName =
'''
{
  "attributes":[],
  "vertexShader":"vertShader",
  "fragmentShader":"fragShader"
}
''';

  expect(() {
    var format = createProgramFormat(noName);
  }, throwsArgumentError);

  // Should throw if no vertex shader is provided
  String noVertex =
'''
{
  "name":"noVertex",
  "attributes":[],
  "fragmentShader":"fragShader"
}
''';

  expect(() {
    var format = createProgramFormat(noVertex);
  }, throwsArgumentError);

  // Should throw if an invalid shader is provided
  String invalidShader =
'''
{
  "name":"invalid",
  "attributes":[],
  "vertexShader":["wrong!"],
  "fragmentShader":"fragShader"
}
''';

  expect(() {
    ProgramFormat format = createProgramFormat(invalidShader);
  }, throwsArgumentError);

  // Should throw if the names are not unique
  String repeatList =
'''
[
  {
    "name":"repeat",
    "attributes":[],
    "vertexShader":"vertShader",
    "fragmentShader":"fragShader"
  },
  {
    "name":"repeat",
    "attributes":[],
    "vertexShader":"vertShader",
    "fragmentShader":"fragShader"
  }
]
''';

  expect(() {
    List list = JSON.decode(repeatList);
    Map<String, ProgramFormat> formats = ProgramFormat.parseList(list);
  }, throwsArgumentError);
}

void testList() {
  var formatList = '[${referenceString},${sourceString}]';

  var list = JSON.decode(formatList);
  var formats = ProgramFormat.parseList(list);

  expect(formats.length, 2);
  expect(formats.containsKey('referenceProgram'), true);
  expect(formats.containsKey('sourceProgram')   , true);

  // Check for a ShaderProgram using references to vertex and fragment shaders
  var reference = formats['referenceProgram'];

  verifyReferences(reference);

  // Check for a ShaderProgram with inline vertex and fragment shaders
  var source = formats['sourceProgram'];

  verifySources(source);
}

void main() {
  test('values', testValues);
  test('exceptions', testExceptions);
  test('list', testList);
}
