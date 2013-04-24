// Copyright (c) 2013, the Lihtium-Ion Engine Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

library bit_hack_test;

import 'dart:math' as Math;

import 'package:unittest/unittest.dart';
import 'package:lithium_ion/lithium_foundation.dart';

void main() {
  test('isFlagEnabled', () {
    const int maxPower = 32;

    var check = (value, expectation) {
      for (int i = 0; i < maxPower; ++i) {
        int flag = 1 << i;

        expect(isFlagEnabled(value, flag), expectation);
      }
    };

    // Check if all the flags are enabled
    var allEnabled = 0xFFFFFFFF;

    check(allEnabled, true);

    // Check if no flags are enabled
    var noneEnabled = 0;

    check(noneEnabled, false);
  });

  test('isPowerOfTwo', () {
    const int maxPower = 24;

    // Create a list of powers of two
    var powersOfTwo = new Set<int>();

    for (int i = 0; i < maxPower; ++i) {
      powersOfTwo.add(1 << i);
    }

    // Verify isPowerOfTwo by running through all values
    int maxValue = Math.pow(2, maxPower).toInt();

    for (int i = 1; i < maxValue; ++i) {
      expect(isPowerOfTwo(i), powersOfTwo.contains(i));
    }
  });
}
