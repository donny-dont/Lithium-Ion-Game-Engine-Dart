// Copyright (c) 2012, the Lihtium-Ion Engine project authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

part of lithium_graphics;

abstract class EffectParameter<T> {
  ///

  void setValue(T value);
}

class EffectParamterScalar extends EffectParameter<double> {

}

class EffectParamterMatrix4 extends EffectParameter<mat4> {

  Float32List _values = new Float32List(16);

  void setValue(mat4 value) {

  }
}
