// Copyright (c) 2013, the Lihtium-Ion Engine Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

part of lithium_graphics;

class EffectParameterType implements Enum {
  //---------------------------------------------------------------------
  // Member variables
  //---------------------------------------------------------------------

  /// The index of the enumeration within [values].
  final int index;

  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  /// Create an enumeration with the given index.
  const EffectParameterType._internal(this.index);

  //---------------------------------------------------------------------
  // Enumerations
  //---------------------------------------------------------------------

  /// A single floating point value.
  static const EffectParameterType Scalar = const EffectParameterType._internal(0);
  /// A two dimensional floating point vector.
  static const EffectParameterType Vector2 = const EffectParameterType._internal(1);
  /// A three dimensional floating point vector.
  static const EffectParameterType Vector3 = const EffectParameterType._internal(2);
  /// A  four dimensional floating point vector.
  static const EffectParameterType Vector4 = const EffectParameterType._internal(3);
  /// A two dimensional floating point matrix.
  static const EffectParameterType Matrix2 = const EffectParameterType._internal(4);
  /// A three dimensional floating point matrix.
  static const EffectParameterType Matrix3 = const EffectParameterType._internal(5);
  /// A four dimensional floating point matrix.
  static const EffectParameterType Matrix4 = const EffectParameterType._internal(6);
  /// An list of floating point values.
  static const EffectParameterType ScalarList = const EffectParameterType._internal(7);
  /// An list of two dimensional floating point vectors.
  static const EffectParameterType Vector2List = const EffectParameterType._internal(8);
  /// An list of three dimensional floating point vectors.
  static const EffectParameterType Vector3List = const EffectParameterType._internal(9);
  /// An list of four dimensional floating point vectors.
  static const EffectParameterType Vector4List = const EffectParameterType._internal(10);
  /// An list of two dimensional floating point matrices.
  static const EffectParameterType Matrix2List = const EffectParameterType._internal(11);
  /// An list of three dimensional floating point matrices.
  static const EffectParameterType Matrix3List = const EffectParameterType._internal(12);
  /// An list of four dimensional floating point matrices.
  static const EffectParameterType Matrix4List = const EffectParameterType._internal(13);
  /// A two dimensional texture.
  static const EffectParameterType Texture2D = const EffectParameterType._internal(14);
  /// A cube map texture.
  static const EffectParameterType TextureCube = const EffectParameterType._internal(15);
  /// A uniform block.
  static const EffectParameterType Block = const EffectParameterType._internal(16);
  /// An array of uniform blocks.
  static const EffectParameterType BlockList = const EffectParameterType._internal(17);

  //---------------------------------------------------------------------
  // Values
  //---------------------------------------------------------------------

  /// List of enumerations.
  static const List<BlendOperation> values = const [
    Scalar,
    Vector2,
    Vector3,
    Vector4,
    Matrix2,
    Matrix3,
    Matrix4,
    ScalarList,
    Vector2List,
    Vector3List,
    Vector4List,
    Matrix2List,
    Matrix3List,
    Matrix4List,
    Texture2D,
    TextureCube,
    Block,
    BlockList
  ];
}

/// Converts the WebGL enumeration to an [EffectParameterType].
EffectParameterType _webGLToEffectParameterType(WebGL.ActiveInfo uniform) {
  var size = uniform.size;
  var type = uniform.type;

  if (size == 1) {
    switch (type) {
      case WebGL.FLOAT       : return EffectParameterType.Scalar;
      case WebGL.FLOAT_VEC2  : return EffectParameterType.Vector2;
      case WebGL.FLOAT_VEC3  : return EffectParameterType.Vector3;
      case WebGL.FLOAT_VEC4  : return EffectParameterType.Vector4;
      case WebGL.FLOAT_MAT2  : return EffectParameterType.Matrix2;
      case WebGL.FLOAT_MAT3  : return EffectParameterType.Matrix3;
      case WebGL.FLOAT_MAT4  : return EffectParameterType.Matrix4;
      case WebGL.SAMPLER_2D  : return EffectParameterType.Texture2D;
      case WebGL.SAMPLER_CUBE: return EffectParameterType.TextureCube;
    }
  } else {
    switch (type) {
      case WebGL.FLOAT     : return EffectParameterType.ScalarList;
      case WebGL.FLOAT_VEC2: return EffectParameterType.Vector2List;
      case WebGL.FLOAT_VEC3: return EffectParameterType.Vector3List;
      case WebGL.FLOAT_VEC4: return EffectParameterType.Vector4List;
      case WebGL.FLOAT_MAT2: return EffectParameterType.Matrix2List;
      case WebGL.FLOAT_MAT3: return EffectParameterType.Matrix3List;
      case WebGL.FLOAT_MAT4: return EffectParameterType.Matrix4List;
    }
  }

  // Unknown enumeration
  assert(false);
  return EffectParameterType.Scalar;
}
