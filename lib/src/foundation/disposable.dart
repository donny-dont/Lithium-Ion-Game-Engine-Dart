// Copyright (c) 2013-2014, the Lithium-Ion Engine Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

part of lithium_foundation;

/// Interface for an object that has resources that need to be released explicitly.
///
/// Objects that implement [Disposable] should have some form of managed
/// resource that needs to be cleaned up explicitly to avoid memory leaks.
///
/// One example is a class that subscribes to a [Stream]. Before the class is
/// disposed of through garbage collection the subscription should be
/// relinquished.
abstract class Disposable {
  /// Whether the object has been disposed
  bool get isDisposed;

  /// Disposes of the object.
  ///
  /// All resources should be released after a call to dispose.
  void dispose();
}
