// Copyright (c) 2012, the Lihtium-Ion Engine project authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

part of lithium_graphics;

abstract class EffectParameter<T> {
  /// The name of the paramter
  String _name;

  EffectParameter._internal(String name)
      : _name = name;

  void setValue(T value);
}

class EffectParameterScalar extends EffectParameter<double> {
  EffectParameterScalar._internal(String name)
      : super._internal(name);

  void setValue(double value) {

  }
}

class EffectParameterMatrix4 extends EffectParameter<Matrix4> {

  Float32List _values = new Float32List(16);

  EffectParameterMatrix4._internal(String name)
      : super._internal(name);

  void setValue(Matrix4 value) {

  }
}
