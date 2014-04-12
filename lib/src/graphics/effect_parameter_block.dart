// Copyright (c) 2013-2014, the Lithium-Ion Engine project authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

part of lithium_graphics;

class _EffectParameterInfo<T> {
  //---------------------------------------------------------------------
  // Member variables
  //---------------------------------------------------------------------

  /// The value.
  T _value;
  /// The type of parameter.
  EffectParameterType _type;
  /// The number of elements.
  int _size;

  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  _EffectParameterInfo(T value, EffectParameterType type, int size)
      : _value = value
      , _type = type
      , _size = size;

  //---------------------------------------------------------------------
  // Properties
  //---------------------------------------------------------------------


  T get value => _value;
  set value(T v) { _value = v; }

  EffectParameterType get type => _type;

  int get size => _size;
}

class EffectParameterBlock {
  //---------------------------------------------------------------------
  // Member variables
  //---------------------------------------------------------------------

  Map<String, _EffectParameterInfo> _parameters = new Map<String, _EffectParameterInfo>();

  Object operator[](String name) {
    assert(_parameters.containsKey(name));

    return _parameters[name].value;
  }

  void operator[]=(String name, Object value) {
    assert(_parameters.containsKey(name));

    _parameters[name].value = value;
  }

  //---------------------------------------------------------------------
  // Internal methods
  //---------------------------------------------------------------------

  void _addEffectParameter(String name, EffectParameterType type, int size) {
    if (_parameters.containsKey(name)) {
      assert(_parameters[name].type == type);

      return;
    }

    switch (type) {
      case EffectParameterType.Scalar:
        _parameters[name] = new _EffectParameterInfo<double>(0.0, type, size);
        break;
      case EffectParameterType.Vector2:
        _parameters[name] = new _EffectParameterInfo<Vector2>(new Vector2.zero(), type, size);
        break;
      case EffectParameterType.Vector3:
        _parameters[name] = new _EffectParameterInfo<Vector3>(new Vector3.zero(), type, size);
        break;
      case EffectParameterType.Vector4:
        _parameters[name] = new _EffectParameterInfo<Vector4>(new Vector4.zero(), type, size);
        break;
      case EffectParameterType.Matrix2:
        _parameters[name] = new _EffectParameterInfo<Matrix2>(new Matrix2.zero(), type, size);
        break;
      case EffectParameterType.Matrix3:
        _parameters[name] = new _EffectParameterInfo<Matrix3>(new Matrix3.zero(), type, size);
        break;
      case EffectParameterType.Matrix4:
        _parameters[name] = new _EffectParameterInfo<Matrix4>(new Matrix4.zero(), type, size);
        break;
      case EffectParameterType.ScalarList:
        _parameters[name] = new _EffectParameterInfo<Float32List>(new Float32List(size), type, size);
        break;
      case EffectParameterType.Vector2List:
        _parameters[name] = new _EffectParameterInfo<Float32List>(new Float32List(2 * size), type, size);
        break;
      case EffectParameterType.Vector3List:
        _parameters[name] = new _EffectParameterInfo<Float32List>(new Float32List(3 * size), type, size);
        break;
      case EffectParameterType.Vector4List:
        _parameters[name] = new _EffectParameterInfo<Float32List>(new Float32List(4 * size), type, size);
        break;
      case EffectParameterType.Matrix2List:
        _parameters[name] = new _EffectParameterInfo<Float32List>(new Float32List(4 * size), type, size);
        break;
      case EffectParameterType.Matrix3List:
        _parameters[name] = new _EffectParameterInfo<Float32List>(new Float32List(9 * size), type, size);
        break;
      case EffectParameterType.Matrix4List:
        _parameters[name] = new _EffectParameterInfo<Float32List>(new Float32List(16 * size), type, size);
        break;
      case EffectParameterType.Texture2D:
        _parameters[name] = new _EffectParameterInfo<Texture2D>(null, type, size);
        break;
      case EffectParameterType.TextureCube:
        _parameters[name] = new _EffectParameterInfo<TextureCube>(null, type, size);
        break;
    }
  }

  void _addEffectParameterBlock(String name) {
    if (_parameters.containsKey(name)) {
      assert(_parameters[name].type == EffectParameterType.Block);

      return;
    }

    _parameters[name] = new _EffectParameterInfo<EffectParameterBlock>(new EffectParameterBlock(), EffectParameterType.Block, 1);
  }

  void _addEffectParameterBlockList(String name) {
    if (_parameters.containsKey(name)) {
      assert(_parameters[name].type == EffectParameterType.BlockList);

      return;
    }

    _parameters[name] = new _EffectParameterInfo<EffectParameterBlockList>(new EffectParameterBlockList._internal(), EffectParameterType.BlockList, 1);
  }

  Object _getParameterValue(String name) {
    if (_parameters.containsKey(name)) {
      return _parameters[name].value;
    } else {
      return null;
    }
  }
}

class EffectParameterBlockList {
  List<EffectParameterBlock> _blocks = new List<EffectParameterBlock>();

  EffectParameterBlockList._internal();

  Object operator[](int index) {
    return _blocks[index];
  }

  void operator[]=(int index, EffectParameterBlock value) {
    _blocks[index] = value;
  }

  void _addEffectParameterBlock(int index) {
    while (_blocks.length <= index) {
      _blocks.add(new EffectParameterBlock());
    }
  }
}
