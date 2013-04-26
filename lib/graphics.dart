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
import 'dart:mirrors';
import 'dart:web_gl' as WebGL;

//---------------------------------------------------------------------
// Package libraries
//---------------------------------------------------------------------

import 'package:lithium_ion/foundation.dart';
import 'package:vector_math/vector_math.dart';

//---------------------------------------------------------------------
// Graphics library
//---------------------------------------------------------------------

part 'src/graphics/debug_rendering_context.dart';
part 'src/graphics/graphics_context.dart';
part 'src/graphics/graphics_device.dart';
part 'src/graphics/graphics_device_capabilities.dart';
part 'src/graphics/graphics_device_config.dart';
part 'src/graphics/graphics_resource.dart';