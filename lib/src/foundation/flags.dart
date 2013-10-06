// Copyright (c) 2013, the Lihtium-Ion Engine Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

part of lithium_foundation;

///
///
class Flags<T extends Enum> {
  //---------------------------------------------------------------------
  // Member variables
  //---------------------------------------------------------------------

  /// The value of the flag.
  int _value;

  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  Flags()
      : _value = 0;

  Flags._internal(int value)
      : _value = value;

  //---------------------------------------------------------------------
  // Operators
  //---------------------------------------------------------------------

  int get value => _value;

  //---------------------------------------------------------------------
  // Operators
  //---------------------------------------------------------------------

  bool operator== (Object compare) {
    return _value == _getFlag(compare);
  }

  Flags<T> operator| (Object value) {
    return new Flags<T>._internal(_value | _getFlag(value));
  }

  Flags<T> operator& (Object value) {
    return new Flags<T>._internal(_value & _getFlag(value));
  }

  Flags<T> operator^ (Object value) {
    return new Flags<T>._internal(_value ^ _getFlag(value));
  }

  //---------------------------------------------------------------------
  // Public methods
  //---------------------------------------------------------------------


  bool hasFlag(T flag) {
    var index = (1 << flag.index);

    return (_value & index) == index;
  }

  void setFlag(T flag) {
    _value |= (1 << flag.index);
  }

  void removeFlag(T flag) {
    _value &= ~(1 << flag.index);
  }

  void toggleFlag(T flag) {
    _value ^= (1 << flag.index);
  }

  //---------------------------------------------------------------------
  // Private methods
  //---------------------------------------------------------------------

  int _getFlag(Object value) {
    if (value is Flags<T>) {
      var flags = value as Flags<T>;

      return flags._value;
    } else if (value is T) {
      var flags = value as T;

      return (1 << flags.index);
    } else {
      assert(false);
      return 0;
    }
  }

  get hashCode => _value;
}
