// Copyright (c) 2013, the Lihtium-Ion Engine Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

library flags_test;

import 'package:unittest/unittest.dart';
import 'package:lithium_ion/foundation.dart';

class TestEnum implements Enum {
  final index;
  const TestEnum(this.index);

  static const Enum0 = const TestEnum(0);
  static const Enum1 = const TestEnum(1);
  static const Enum2 = const TestEnum(2);
  static const Enum3 = const TestEnum(3);
  static const Enum4 = const TestEnum(4);
  static const Enum5 = const TestEnum(5);
  static const Enum6 = const TestEnum(6);
  static const Enum7 = const TestEnum(7);

  static const values = const [
      Enum0,
      Enum1,
      Enum2,
      Enum3,
      Enum4,
      Enum5,
      Enum6,
      Enum7
  ];
}

class FlagsTest extends Flags<TestEnum> {}

void setAll(FlagsTest flags) {
  for (var flag in TestEnum.values){
    flags.setFlag(flag);
  }
}

void removeAll(FlagsTest flags) {
  for (var flag in TestEnum.values){
    flags.removeFlag(flag);
  }
}

void toggleAll(FlagsTest flags) {
  for (var flag in TestEnum.values){
    flags.toggleFlag(flag);
  }
}

void main() {
  test('set flags', () {
    // Test setting individual flags
    for (var flag in TestEnum.values){
      var flags = new FlagsTest();

      expect(flags.hasFlag(flag), false);
      expect(flags.value, 0);

      flags.setFlag(flag);

      expect(flags.hasFlag(flag), true);
      expect(flags.value, (1 << flag.index));
    }

    // Set all flags
    var all = new FlagsTest();

    setAll(all);

    expect(all.value, (1 << 8) - 1);
  });

  test('remove flags', () {
    var testRemove = (flag) {
      var flags = new FlagsTest();

      flags.setFlag(flag);

      expect(flags.hasFlag(flag), true);
      expect(flags.value, (1 << flag.index));

      flags.removeFlag(flag);

      expect(flags.hasFlag(flag), false);
      expect(flags.value, 0);
    };

    // Set each flag
    testRemove(TestEnum.Enum0);
    testRemove(TestEnum.Enum1);
    testRemove(TestEnum.Enum2);
    testRemove(TestEnum.Enum3);
    testRemove(TestEnum.Enum4);
    testRemove(TestEnum.Enum5);
    testRemove(TestEnum.Enum6);
    testRemove(TestEnum.Enum7);

    // Set all flags
    var all = new FlagsTest();

    setAll(all);

    expect(all.value, (1 << 8) - 1);
  });

  test('toggle flags', () {
    var testToggle = (flag) {
      var flags = new FlagsTest();

      expect(flags.hasFlag(flag), false);
      expect(flags.value, 0);

      // Set flag
      flags.toggleFlag(flag);

      expect(flags.hasFlag(flag), true);
      expect(flags.value, (1 << flag.index));

      // Remove flag
      flags.toggleFlag(flag);

      expect(flags.hasFlag(flag), false);
      expect(flags.value, 0);
    };

    // Set each flag
    testToggle(TestEnum.Enum0);
    testToggle(TestEnum.Enum1);
    testToggle(TestEnum.Enum2);
    testToggle(TestEnum.Enum3);
    testToggle(TestEnum.Enum4);
    testToggle(TestEnum.Enum5);
    testToggle(TestEnum.Enum6);
    testToggle(TestEnum.Enum7);

    // Set all flags
    var all = new FlagsTest();

    toggleAll(all);

    expect(all.value, (1 << 8) - 1);

    toggleAll(all);

    expect(all.value, 0);
  });

  test('operator |', () {
    var testSet = (flag) {
      var flags = new FlagsTest();

      expect(flags.hasFlag(flag), false);
      expect(flags.value, 0);

      flags |= flag;

      expect(flags == flag, true);
      expect(flags.hasFlag(flag), true);
      expect(flags.value, (1 << flag.index));
    };

    // Set each flag
    testSet(TestEnum.Enum0);
    testSet(TestEnum.Enum1);
    testSet(TestEnum.Enum2);
    testSet(TestEnum.Enum3);
    testSet(TestEnum.Enum4);
    testSet(TestEnum.Enum5);
    testSet(TestEnum.Enum6);
    testSet(TestEnum.Enum7);
  });
}
