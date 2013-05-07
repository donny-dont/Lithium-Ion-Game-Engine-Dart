// Copyright (c) 2013, the Lihtium-Ion Engine Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

library lithium_graphics;

//---------------------------------------------------------------------
// Standard libraries
//---------------------------------------------------------------------

import 'dart:async';
import 'dart:html';
import 'dart:math' as Math;
import 'dart:mirrors';
import 'dart:typed_data';
import 'dart:web_gl' as WebGL;

//---------------------------------------------------------------------
// Package libraries
//---------------------------------------------------------------------

import 'package:lithium_ion/foundation.dart';
import 'package:vector_math/vector_math.dart';

//---------------------------------------------------------------------
// Graphics library
//---------------------------------------------------------------------

part 'src/graphics/buffer_usage.dart';
part 'src/graphics/debug_rendering_context.dart';
part 'src/graphics/effect_pass.dart';
part 'src/graphics/graphics_context.dart';
part 'src/graphics/graphics_device.dart';
part 'src/graphics/graphics_device_capabilities.dart';
part 'src/graphics/graphics_device_config.dart';
part 'src/graphics/graphics_device_extensions.dart';
part 'src/graphics/graphics_resource.dart';
part 'src/graphics/index_buffer.dart';
part 'src/graphics/index_element_size.dart';
part 'src/graphics/mesh.dart';
part 'src/graphics/primitive_type.dart';
part 'src/graphics/rendering_error_event.dart';
part 'src/graphics/resource_created_event.dart';
part 'src/graphics/resource_destroyed_event.dart';
part 'src/graphics/texture.dart';
part 'src/graphics/vertex_buffer.dart';
part 'src/graphics/vertex_declaration.dart';
part 'src/graphics/vertex_element.dart';
part 'src/graphics/vertex_element_format.dart';
part 'src/graphics/vertex_element_usage.dart';
part 'src/graphics/vertex_list.dart';
part 'src/graphics/viewport.dart';
