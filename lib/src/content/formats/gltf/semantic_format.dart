// Copyright (c) 2012, the Lihtium-Ion Engine project authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

part of lithium_content;

/// Defines a semantic.
///
/// Semantics are used to resolve a [VertexDeclaration] and an [EffectPass]'s
/// attribute indices. This corresponds to the semantics specification within
/// the [OpenGL Transmission Format (glTF)]
/// (https://github.com/KhronosGroup/glTF/tree/master/specification#semantics)
class _SemanticFormat {
  //---------------------------------------------------------------------
  // Member variables
  //---------------------------------------------------------------------

  /// The [VertexElementUsage] of the semantic.
  int _usage;
  /// The index of the semantic.
  int _usageIndex = 0;

  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  /// Creates an instance of the [_SemanticFormat] from a string.
  _SemanticFormat.parse(String value) {
    if (value == null) {
      throw new ArgumentError('No semantic provided');
    }

    // The '_' character is used to separate the semantic name from
    // an optional index
    List<String> values = value.split('_');
    int valueCount = values.length;

    if ((valueCount <= 0) || (valueCount > 2)) {
      throw new ArgumentError('Invalid semantic format');
    }

    _usage = _getVertexElementUsage(values[0]);

    if (valueCount == 2) {
      _usageIndex = int.parse(values[1]);
    }
  }

  //---------------------------------------------------------------------
  // Properties
  //---------------------------------------------------------------------

  /// The [VertexElementUsage] of the semantic.
  int get usage => _usage;

  /// The index of the semantic.
  int get usageIndex => _usageIndex;

  //---------------------------------------------------------------------
  // Class methods
  //---------------------------------------------------------------------

  /// Determines the corresponding [VertexElementUsage].
  static int _getVertexElementUsage(String value) {
    switch (value) {
      case 'POSITION': return VertexElementUsage.Position;
      case 'NORMAL'  : return VertexElementUsage.Normal;
      case 'TANGENT' : return VertexElementUsage.Tangent;
      case 'BINORMAL': return VertexElementUsage.Binormal;
      case 'TEXCOORD': return VertexElementUsage.TextureCoordinate;
      case 'COLOR'   : return VertexElementUsage.Color;
    }

    throw new ArgumentError('Unsupported semantic name');
  }
}