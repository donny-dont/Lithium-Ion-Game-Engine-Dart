// Copyright (c) 2013, the Lihtium-Ion Engine Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

library content_test;

import 'package:unittest/unittest.dart';

import 'content/program_attribute_test.dart' as program_attribute_test;
import 'content/program_format_test.dart' as program_format_test;
import 'content/shader_format_test.dart' as shader_format_test;

void main() {
  group('Content library', () {
    group('ProgramAttribute tests', program_attribute_test.main);
    group('ProgramFormat tests'   , program_format_test.main);
    group('ShaderFormat tests'    , shader_format_test.main);
  });
}
