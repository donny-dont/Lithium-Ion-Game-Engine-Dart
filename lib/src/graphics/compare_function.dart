// Copyright (c) 2012, the Lihtium-Ion Engine project authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

part of lithium_graphics;

/// Defines comparison functions that can be chosen for stencil, or depth-buffer tests.
class CompareFunction implements Enum {
  //---------------------------------------------------------------------
  // Member variables
  //---------------------------------------------------------------------

  /// The index of the enumeration within [values].
  final int index;

  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  /// Create an enumeration with the given index.
  const CompareFunction._internal(this.index);

  //---------------------------------------------------------------------
  // Enumerations
  //---------------------------------------------------------------------

  /// Always pass the test.
  static const CompareFunction Always = const CompareFunction._internal(0);
  /// Accept the new pixel if its value is equal to the value of the current pixel.
  static const CompareFunction Equal = const CompareFunction._internal(1);
  /// Accept the new pixel if its value is greater than the value of the current pixel.
  static const CompareFunction Greater = const CompareFunction._internal(2);
  /// Accept the new pixel if its value is greater than or equal to the value of the current pixel.
  static const CompareFunction GreaterEqual = const CompareFunction._internal(3);
  /// Accept the new pixel if its value is less than the value of the current pixel.
  static const CompareFunction Less = const CompareFunction._internal(4);
  /// Accept the new pixel if its value is less than or equal to the value of the current pixel.
  static const CompareFunction LessEqual = const CompareFunction._internal(5);
  /// Always fail the test.
  static const CompareFunction Fail = const CompareFunction._internal(6);
  ///  Accept the new pixel if its value does not equal the value of the current pixel.
  static const CompareFunction NotEqual = const CompareFunction._internal(7);

  //---------------------------------------------------------------------
  // Values
  //---------------------------------------------------------------------

  /// List of enumerations.
  static const List<CompareFunction> values = const [
      Always,
      Equal,
      Greater,
      GreaterEqual,
      Less,
      LessEqual,
      Fail,
      NotEqual
  ];
}

/// Mapping of [CompareFunction] enumerations to WebGL.
const List<int> _compareFunctionMapping = const [
    WebGL.ALWAYS,  // Always
    WebGL.EQUAL,   // Equal
    WebGL.GREATER, // Greater
    WebGL.GEQUAL,  // GreaterEqual
    WebGL.LESS,    // Less
    WebGL.LEQUAL,  // LessEqual
    WebGL.NEVER,   // Fail
    WebGL.NOTEQUAL // NotEqual
];

/// Converts the [CompareFunction] enumeration to its WebGL value.
int _compareFunctionToWebGL(CompareFunction compareFunction) {
  return _compareFunctionMapping[compareFunction.index];
}
