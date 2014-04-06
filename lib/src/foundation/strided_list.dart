// Copyright (c) 2013-2014, the Lithium-Ion Engine Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

part of lithium_foundation;

abstract class StridedList<E> {//implements List<E> {
  //---------------------------------------------------------------------
  // Member variables
  //---------------------------------------------------------------------

  /// The underlying [Float32List] containing the elements.
  Float32List _list;
  /// The offset to the element.
  int _offset;
  /// The length of the list.
  int _length;
  /// The stride between elements.
  int _stride;

  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  /// Creates an instance of the [StridedList] class with the given [length].
  StridedList._create(int length, int itemCount)
      : _offset = 0
      , _stride = itemCount
      , _length = length
      , _list = new Float32List(length * itemCount);

  /// Creates a [StridedList] view of the specified region in the specified byte buffer.
  StridedList._view(ByteBuffer buffer, int offsetInBytes, int strideInBytes, int bytesPerElement)
      : _offset = offsetInBytes >> 2
      , _stride = strideInBytes >> 2
  {
    if (offsetInBytes % 4 != 0) {
      throw new ArgumentError('The byte offset must be on a 4-byte boundary');
    }

    if (strideInBytes % 4 != 0) {
      throw new ArgumentError('The stride offset must be on a 4-byte boundary');
    }

    if (strideInBytes < bytesPerElement) {
      throw new ArgumentError('The stride is less than the element size');
    }

    _list = new Float32List.view(buffer);
    _length = _list.length ~/ _stride;
  }

  //---------------------------------------------------------------------
  // Operators
  //---------------------------------------------------------------------

  E operator[](int index);

  void operator[]=(int index, E value);

  //---------------------------------------------------------------------
  // Properties
  //---------------------------------------------------------------------

  /// Returns the number of elements.
  int get length;

  /// Returns the underlying [Float32List].
  Float32List get list => _list;

  //---------------------------------------------------------------------
  // Methods
  //---------------------------------------------------------------------

  /// Gets the [value] at the specified [index].
  ///
  /// Copies the value at [index] into [value]. Dependent on the type of [E] the
  /// \[\] operator can create a new object. Prefer this method when [E] is
  /// an object.
  void getAt(int index, E value);

  /// Sets the [value] at the specified [index].
  void setAt(int index, E value);

  //---------------------------------------------------------------------
  // Unsupported methods
  //
  // Define all the List<E> methods that are unsupported by the
  // implementation.
  //---------------------------------------------------------------------

}
