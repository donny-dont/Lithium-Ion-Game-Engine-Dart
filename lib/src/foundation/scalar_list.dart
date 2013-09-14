// Copyright (c) 2013, the Lihtium-Ion Engine Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

part of lithium_foundation;

/// Helper for accessing interleaved scalar elements.
///
/// The [ScalarList] class provides easy random access to scalar values
/// interleaved within vertex data. If the vertex data is not interleaved
/// then a [ScalarList] should not be used as it has additional overhead,
/// in comparison to [Float32List] and will perform worse.
class ScalarList extends StridedList<double> {
  //---------------------------------------------------------------------
  // Class variables
  //---------------------------------------------------------------------

  /// The number of bytes per element in the [List]
  static const int BYTES_PER_ELEMENT = 4;
  /// The number of items within the [ScalarList].
  static const int _itemCount = 1;

  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  /// Creates an instance of the [ScalarList] class with the given [length] (in elements).
  ///
  /// Initially all elements are set to zero.
  ScalarList(int length)
      : super._create(length, _itemCount);

  /// Creates a [ScalarList] view of the specified region in the specified byte buffer.
  ScalarList.view(ByteBuffer buffer, [int offsetInBytes = 0, int strideInBytes = BYTES_PER_ELEMENT])
      : super._view(buffer, offsetInBytes, strideInBytes, BYTES_PER_ELEMENT);

  //---------------------------------------------------------------------
  // Operators
  //---------------------------------------------------------------------

  /// Returns the element at the given index in the list.
  ///
  /// Throws a RangeError if index is out of bounds.
  double operator[](int index) {
    return _list[_getActualIndex(index)];
  }

  /// Sets the entry at the given index in the list to value.
  ///
  /// Throws a RangeError if index is out of bounds.
  void operator[]=(int index, double value) {
    _list[_getActualIndex(index)] = value;
  }

  //---------------------------------------------------------------------
  // Properties
  //---------------------------------------------------------------------

  /// Returns the number of elements.
  int get length => _length;

  //---------------------------------------------------------------------
  // Public methods
  //---------------------------------------------------------------------

  /// Gets the [value] at the specified [index].
  ///
  /// Copies the value at [index] into [value]. This is not available for
  /// [ScalarList].
  void getAt(int index, double value) {
    throw new UnsupportedError('The getAt method is not valid for scalars');
  }

  /// Sets the [value] at the specified [index].
  void setAt(int index, double value) {
    _list[_getActualIndex(index)] = value;
  }

  //---------------------------------------------------------------------
  // Private methods
  //---------------------------------------------------------------------

  /// Retrieves the actual index of the data.
  int _getActualIndex(int index) => _offset + (index * _stride);
}
