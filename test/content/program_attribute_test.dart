// Copyright (c) 2013-2014, the Lithium-Ion Engine project authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

library program_attribute_test;

import 'dart:convert';
import 'package:unittest/unittest.dart';
import 'package:lithium_ion/graphics.dart';
import 'package:lithium_ion/content.dart';

ProgramAttribute createProgramAttribute(String value) {
  return new ProgramAttribute.fromJson(JSON.decode(value));
}

void testValues() {
  var names = [
      ['POSITION', VertexElementUsage.Position],
      ['NORMAL'  , VertexElementUsage.Normal],
      ['TANGENT' , VertexElementUsage.Tangent],
      ['BINORMAL', VertexElementUsage.Binormal],
      ['TEXCOORD', VertexElementUsage.TextureCoordinate],
      ['COLOR'   , VertexElementUsage.Color],
  ];

  names.forEach((value) {
    var semantic = value[0];
    int usage = value[1];

    String noIndexString = '{"semantic":"${semantic}","symbol":"vAttrib"}';

    var noIndex = createProgramAttribute(noIndexString);

    expect(noIndex.symbol    , 'vAttrib');
    expect(noIndex.usage     , usage);
    expect(noIndex.usageIndex, 0);

    for (int i = 0; i < 8; ++i) {
      String withIndexString = '{"semantic":"${semantic}_${i}","symbol":"vAttrib"}';

      var withIndex = createProgramAttribute(withIndexString);

      expect(withIndex.symbol    , 'vAttrib');
      expect(withIndex.usage     , usage);
      expect(withIndex.usageIndex, i);
    }
  });
}

void testExceptions() {
  // Should throw if no semantic is provided
  String noSemantic = '{"symbol":"vPosition"}';

  expect(() {
    var format = createProgramAttribute(noSemantic);
  }, throwsArgumentError);

  // Should throw if no symbol is provided
  var noSymbol = '{"semantic":"POSITION"}';

  expect(() {
    var format = createProgramAttribute(noSymbol);
  }, throwsArgumentError);

  // Should throw if the semantic is not supported
  String invalidSemantic = '{"semantic":"INVALID","symbol":"vInvalid"}';

  expect(() {
    var format = createProgramAttribute(invalidSemantic);
  }, throwsArgumentError);

  // Should throw if the usage index is invalid
  String invalidIndex = '{"semantic":"TEXCOORD_A","symbol":"vTexCoordA"}';

  expect(() {
    var format = createProgramAttribute(invalidIndex);
  }, throwsFormatException);
}

void main() {
  test('values', testValues);
  test('exceptions', testExceptions);
}
