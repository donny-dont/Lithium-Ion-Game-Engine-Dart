// Copyright (c) 2013, the Lihtium-Ion Engine Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

library foundation_test;

import 'package:unittest/unittest.dart';

import 'graphics/buffer_usage_test.dart'          as buffer_usage_test;
import 'graphics/graphics_device_test.dart'       as graphics_device_test;
import 'graphics/graphics_context_test.dart'      as graphics_context_test;
import 'graphics/index_buffer_test.dart'          as index_buffer_test;
import 'graphics/index_element_size_test.dart'    as index_element_size_test;
import 'graphics/vertex_buffer_test.dart'         as vertex_buffer_test;
import 'graphics/vertex_declaration_test.dart'    as vertex_declaration_test;
import 'graphics/vertex_element_test.dart'        as vertex_element_test;
import 'graphics/vertex_element_format_test.dart' as vertex_element_format_test;
import 'graphics/vertex_element_usage_test.dart'  as vertex_element_usage_test;
import 'graphics/vertex_list_test.dart'           as vertex_list_test;
import 'graphics/viewport_test.dart'              as viewport_test;

void main() {
  group('Graphics library', () {
    group('BufferUsage tests'        , buffer_usage_test.main);
    group('GraphicsDevice tests'     , graphics_device_test.main);
    group('GraphicsContext tests'    , graphics_context_test.main);
    group('IndexBuffer tests'        , index_buffer_test.main);
    group('IndexElementSize tests'   , index_element_size_test.main);
    group('VertexBuffer tests'       , vertex_buffer_test.main);
    group('VertexDeclaration tests'  , vertex_declaration_test.main);
    group('VertexElement tests'      , vertex_element_test.main);
    group('VertexElementFormat tests', vertex_element_format_test.main);
    group('VertexElementUsage tests' , vertex_element_usage_test.main);
    group('VertexList tests'         , vertex_list_test.main);
    group('Viewport tests'           , viewport_test.main);
  });
}
