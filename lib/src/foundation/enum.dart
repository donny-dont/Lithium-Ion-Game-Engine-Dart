// Copyright (c) 2013, the Lihtium-Ion Engine Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

part of lithium_foundation;

/// Interface for an enumeration.
///
/// Maps to the current proposal for (enumerations)[http://news.dartlang.org/2013/04/enum-proposal-for-dart.html]
/// in Dart. This proposal is expected to be implemented after Dart has its
/// initial 1.0 release.
abstract class Enum {
  int get index;
}
