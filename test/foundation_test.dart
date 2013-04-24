// Copyright (c) 2013, the Lihtium-Ion Engine Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

library foundation_test;

import 'package:unittest/unittest.dart';

import 'foundation/bit_hack_test.dart' as bit_hack_test;
import 'foundation/scalar_list_test.dart' as scalar_list_test;
import 'foundation/vector2_list_test.dart' as vector2_list_test;
import 'foundation/vector3_list_test.dart' as vector3_list_test;
import 'foundation/vector4_list_test.dart' as vector4_list_test;

void main() {
  group('Foundation library', () {
    group('Bit hack tests', bit_hack_test.main);
    group('ScalarList tests', scalar_list_test.main);
    group('Vector2List tests', vector2_list_test.main);
    group('Vector3List tests', vector3_list_test.main);
    group('Vector4List tests', vector4_list_test.main);
  });
}
