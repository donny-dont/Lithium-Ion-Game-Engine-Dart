// Copyright (c) 2013, the Lihtium-Ion Engine Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

library foundation_test;

import 'package:unittest/unittest.dart';

import 'graphics/graphics_device_test.dart' as graphics_device_test;

void main() {
  group('Graphics library', () {
    group('GraphicsDevice tests', graphics_device_test.main);
  });
}
