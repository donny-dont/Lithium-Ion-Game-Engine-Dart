// Copyright (c) 2013-2014, the Lithium-Ion Engine Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

part of lithium_foundation;

/// Interface for an object that has resources that can be copied.
///
/// The [Cloneable] interface provides an interface to copy the values from an
/// object into another object. This is to avoid creating additional objects on
/// the heap and instead reuse objects that are already present which helps
/// minimize the time spent in garbage collection.
abstract class Cloneable {
  /// Copies the values from the object into the [to] object.
  void copyInto(Cloneable to);
}
