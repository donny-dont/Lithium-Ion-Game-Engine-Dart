// Copyright (c) 2012, the Lihtium-Ion Engine project authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

part of lithium_graphics;

//---------------------------------------------------------------------
// Base class
//---------------------------------------------------------------------

abstract class _EffectParameter<T> {
  /// The name of the paramter.
  String _name;
  /// The location of the uniform value.
  WebGL.UniformLocation _location;

  _EffectParameter._internal(String name, WebGL.UniformLocation location)
      : _name = name
      , _location = location;

  String get name => _name;

  void setValue(WebGL.RenderingContext gl, T value);
}

//---------------------------------------------------------------------
// Scalar parameters
//---------------------------------------------------------------------

class _EffectParameterScalar extends _EffectParameter<double> {
  double _value;

  _EffectParameterScalar._internal(String name, WebGL.UniformLocation location)
      : super._internal(name, location);

  void setValue(WebGL.RenderingContext gl, double value) {
    if (value != value) {
      gl.uniform1f(_location, value);

      _value = value;
    }
  }
}

//---------------------------------------------------------------------
// Matrix4 parameters
//---------------------------------------------------------------------

class _EffectParameterMatrix4 extends _EffectParameter<Matrix4> {
  _EffectParameterMatrix4._internal(String name, WebGL.UniformLocation location)
    : super._internal(name, location);

  void setValue(WebGL.RenderingContext gl, Matrix4 value) {
    gl.uniformMatrix4fv(_location, false, value.storage);
  }
}

//---------------------------------------------------------------------
// Sampler parameters
//---------------------------------------------------------------------

class _EffectParameterSampler {
  String _name;
  int _textureUnit;

  _EffectParameterSampler._internal(String name, int textureUnit)
      : _name = name
      , _textureUnit = textureUnit;

  String get name => _name;
  int get textureUnit => _textureUnit;
}
