// Copyright (c) 2013-2014, the Lithium-Ion Engine Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

library shader_format_test;

import 'dart:convert';
import 'package:unittest/unittest.dart';
import 'package:lithium_ion/content.dart';

//---------------------------------------------------------------------
// Valid formats
//---------------------------------------------------------------------

String usePathString =
'''
{
  "name":"path",
  "path":"aShader.vert"
}
''';

void verifyUsePath(ShaderFormat value) {
  expect(value.name       , 'path');
  expect(value.isReference, false);
  expect(value.url        , 'aShader.vert');
  expect(value.source     , null);
  expect(value.hasSource  , false);
}

String useSourceString =
'''
{
  "name":"source",
  "source":"void main(){}"
}
''';

void verifyUseSource(ShaderFormat value) {
  expect(value.name       , 'source');
  expect(value.isReference, false);
  expect(value.url        , null);
  expect(value.source     , 'void main(){}');
  expect(value.hasSource  , true);
}

//---------------------------------------------------------------------
// ShaderFormat tests
//---------------------------------------------------------------------

ShaderFormat createShaderFormat(String value) {
  return new ShaderFormat.fromJson(JSON.decode(value));
}

void testValues() {
  // Check for a Shader using a data uri
  var path = createShaderFormat(usePathString);

  verifyUsePath(path);

  // Check for a Shader using source code
  var source = createShaderFormat(useSourceString);

  verifyUseSource(source);
}

void testExceptions() {
  // Should throw if no name is provided
  String noName = '{"path":"aShader.vert"}';

  expect(() {
    var format = createShaderFormat(noName);
  }, throwsArgumentError);

  // Should throw if no data is provided
  String noSource = '{"name":"shader"}';

  expect(() {
    var format = createShaderFormat(noSource);
  }, throwsArgumentError);

  // Should throw if both source code and a data uri are provided
  String bothSourcePaths =
'''
{"name":"shader","path":"aShader.vert","source":"void main(){}"}
''';

  expect(() {
    var format = createShaderFormat(bothSourcePaths);
  }, throwsArgumentError);

  // Should throw if the names are not unique
  String repeatList =
      '''
[
  {"name":"repeat","source":"void main(){}"},
  {"name":"repeat","source":"void main(){}"}
]
      ''';

  expect(() {
    var list = JSON.decode(repeatList);
    var formats = ShaderFormat.parseList(list);
  }, throwsArgumentError);
}

void testList() {
  String formatList = '[${usePathString},${useSourceString}]';

  var list = JSON.decode(formatList);
  var formats = ShaderFormat.parseList(list);

  expect(formats.length, 2);
  expect(formats.containsKey('path')  , true);
  expect(formats.containsKey('source'), true);

  // Check for a Shader using a data uri
  var path = formats['path'];

  verifyUsePath(path);

  // Check for a Shader using source code
  var source = formats['source'];

  verifyUseSource(source);
}

void main() {
  test('values', testValues);
  test('exceptions', testExceptions);
  test('list', testList);
}
