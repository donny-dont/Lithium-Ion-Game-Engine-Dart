// Copyright (c) 2013, the Lihtium-Ion Engine Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

import 'package:unittest/unittest.dart';
import 'package:unittest/html_enhanced_config.dart';

import 'foundation_test.dart' as foundation_test;

void main() {
  useHtmlEnhancedConfiguration();

  foundation_test.main();
}
