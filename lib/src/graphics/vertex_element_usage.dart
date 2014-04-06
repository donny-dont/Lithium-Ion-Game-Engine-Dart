// Copyright (c) 2013-2014, the Lithium-Ion Engine Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

part of lithium_graphics;

/// Defines usage for the vertex elements.
class VertexElementUsage {
  //---------------------------------------------------------------------
  // Serialization names
  //---------------------------------------------------------------------

  /// String representation of [Position].
  static const String _positionName = 'Position';
  /// String representation of [Normal].
  static const String _normalName = 'Normal';
  /// String representation of [Tangent].
  static const String _tangentName = 'Tangent';
  /// String representation of [Binormal].
  static const String _binormalName = 'Binormal';
  /// String representation of [TextureCoordinate].
  static const String _textureCoordinateName = 'TextureCoordinate';
  /// String representation of [Color].
  static const String _colorName = 'Color';
  /// String representation of [PointSize].
  static const String _pointSizeName = 'PointSize';

  //---------------------------------------------------------------------
  // Enumerations
  //---------------------------------------------------------------------

  /// Vertex position data.
  static const int Position = 0;
  /// Vertex normal data.
  static const int Normal = 1;
  /// Vertex tangent data.
  static const int Tangent = 2;
  /// Vertex binormal (bitangent) data.
  static const int Binormal = 3;
  /// Vertex texture coordinate data.
  static const int TextureCoordinate = 4;
  /// Vertex color data.
  static const int Color = 5;
  /// Point size data.
  static const int PointSize = 6;

  //---------------------------------------------------------------------
  // Class methods
  //---------------------------------------------------------------------

  /// Convert from a [String] name to the corresponding [VertexElementUsage] enumeration.
  static int parse(String name) {
    switch (name) {
      case _positionName         : return Position;
      case _normalName           : return Normal;
      case _tangentName          : return Tangent;
      case _binormalName         : return Binormal;
      case _textureCoordinateName: return TextureCoordinate;
      case _colorName            : return Color;
      case _pointSizeName        : return PointSize;
    }

    assert(false);
    return Position;
  }

  /// Converts the [VertexElementUsage] enumeration to a [String].
  static String stringify(int value) {
    switch (value) {
      case Position         : return _positionName;
      case Normal           : return _normalName;
      case Tangent          : return _tangentName;
      case Binormal         : return _binormalName;
      case TextureCoordinate: return _textureCoordinateName;
      case Color            : return _colorName;
      case PointSize        : return _pointSizeName;
    }

    assert(false);
    return _positionName;
  }

  /// Checks whether the value is a valid enumeration.
  ///
  /// Should be gotten rid of when enums are supported properly.
  static bool isValid(int value) {
    switch (value) {
      case Position         :
      case Normal           :
      case Tangent          :
      case Binormal         :
      case TextureCoordinate:
      case Color            :
      case PointSize        : return true;
    }

    return false;
  }

  //---------------------------------------------------------------------
  // Private class methods
  //---------------------------------------------------------------------

  /// Uses the [VertexElementUsage] and usage index to create a semantic name.
  ///
  /// A semantic name is used to map between the [VertexDeclaration] and the
  /// vertex attributes used in an [EffectPass].
  ///
  /// This aligns to DirectX conventions.
  static String _toSemanticName(int value, int index) {
    String semantic;

    switch (value) {
      case VertexElementUsage.Position         : semantic = 'POSITION'; break;
      case VertexElementUsage.Normal           : semantic = 'NORMAL'  ; break;
      case VertexElementUsage.Tangent          : semantic = 'TANGENT' ; break;
      case VertexElementUsage.Binormal         : semantic = 'BINORMAL'; break;
      case VertexElementUsage.TextureCoordinate: semantic = 'TEXCOORD'; break;
      case VertexElementUsage.Color            : semantic = 'COLOR'   ; break;
      case VertexElementUsage.PointSize        : semantic = 'PSIZE'   ; break;
    }

    return '${semantic}${index}';
  }
}
