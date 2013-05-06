// Copyright (c) 2012, the Lihtium-Ion Engine project authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

library lithium_demos;

//---------------------------------------------------------------------
// Standard libraries
//---------------------------------------------------------------------

import 'dart:async';
import 'dart:typed_data';

import 'dart:html' as Html;
import 'dart:web_gl' as WebGL;

//---------------------------------------------------------------------
// Package libraries
//---------------------------------------------------------------------

import 'package:lithium_ion/application.dart';
import 'package:lithium_ion/foundation.dart';
import 'package:lithium_ion/graphics.dart';
import 'package:lithium_ion/mesh.dart';

//---------------------------------------------------------------------
// Shared files
//---------------------------------------------------------------------

part 'shared/simple_screen.dart';

//---------------------------------------------------------------------
// Graphics demos
//---------------------------------------------------------------------

part 'simple_shapes/simple_shapes_screen.dart';

//---------------------------------------------------------------------
// Main entry point
//---------------------------------------------------------------------

/// Application entry-point.
void main() {
  // Start the application
  startApplication('#surface', new SimpleShapesScreen());

  var button = Html.query('#fullscreen');

  button.onClick.listen((_) {
    Application.instance.window.fullscreen = true;
  });
}
