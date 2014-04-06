// Copyright (c) 2013-2014, the Lithium-Ion Engine Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

/// Graphics library for the Lithium-Ion engine.
library lithium_graphics;

//---------------------------------------------------------------------
// Standard libraries
//---------------------------------------------------------------------

import 'dart:async';
import 'dart:collection';
import 'dart:html' as Html;
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

part 'src/graphics/blend.dart';
part 'src/graphics/blend_operation.dart';
part 'src/graphics/buffer_usage.dart';
part 'src/graphics/compare_function.dart';
part 'src/graphics/cube_map_face.dart';
part 'src/graphics/cull_mode.dart';
part 'src/graphics/debug_rendering_context.dart';
part 'src/graphics/depth_stencil_state.dart';
part 'src/graphics/effect.dart';
part 'src/graphics/effect_builder.dart';
part 'src/graphics/effect_parameter.dart';
part 'src/graphics/effect_parameter_block.dart';
part 'src/graphics/effect_parameter_type.dart';
part 'src/graphics/effect_pass.dart';
part 'src/graphics/effect_technique.dart';
part 'src/graphics/front_face.dart';
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
part 'src/graphics/rasterizer_state.dart';
part 'src/graphics/rendering_error_event.dart';
part 'src/graphics/resource_created_event.dart';
part 'src/graphics/resource_destroyed_event.dart';
part 'src/graphics/sampler_state.dart';
part 'src/graphics/semantic_map.dart';
part 'src/graphics/surface_format.dart';
part 'src/graphics/texture.dart';
part 'src/graphics/texture_2d.dart';
part 'src/graphics/texture_address_mode.dart';
part 'src/graphics/texture_cube.dart';
part 'src/graphics/texture_filter.dart';
part 'src/graphics/vertex_buffer.dart';
part 'src/graphics/vertex_declaration.dart';
part 'src/graphics/vertex_element.dart';
part 'src/graphics/vertex_element_format.dart';
part 'src/graphics/vertex_element_usage.dart';
part 'src/graphics/vertex_list.dart';
part 'src/graphics/viewport.dart';
