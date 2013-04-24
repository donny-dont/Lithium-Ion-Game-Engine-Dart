// Copyright (c) 2013, the Lihtium-Ion Engine Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

library foundation_test;

import 'package:unittest/unittest.dart';

import 'foundation/bit_hack_test.dart' as bit_hack_test;

void main() {
  group('Foundation library', () {
    group('Bit hack tests', bit_hack_test.main);
  });
}
