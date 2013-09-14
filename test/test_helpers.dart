// Copyright (c) 2012, the Lihtium-Ion Engine project authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

library test_helpers;

import 'package:unittest/unittest.dart';

var throwsAssertionError = throwsA(new isInstanceOf<AssertionError>());
