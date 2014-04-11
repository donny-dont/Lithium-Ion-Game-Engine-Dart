// Copyright (c) 2013-2014, the Lithium-Ion Engine project authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

part of lithium_content;

/// Defines a [EffectPass] asset to load.
///
/// This corresponds roughly to the shader specification within the
/// [OpenGL Transmission Format (glTF)](https://github.com/KhronosGroup/glTF/blob/master/specification/README.md#program)
/// which ignores the uniform variables field.
class ProgramAttribute {
  //---------------------------------------------------------------------
  // Member variables
  //---------------------------------------------------------------------

  /// The [_SemanticFormat] that the attribute is referring to.
  _SemanticFormat _semantic;
  /// The name of the symbol within the [EffectPass].
  ///
  /// Used to map the name of the attribute within the [EffectPass] to
  /// the associated [VertexElement].
  String _symbol;

  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  /// Creates an instance of the [ProgramAttribute] class from JSON data.
  ProgramAttribute.fromJson(Map json) {
    _semantic = new _SemanticFormat.parse(json['semantic']);

    _symbol = json['symbol'];

    if (_symbol == null) {
      throw new ArgumentError('Symbol not present');
    }
  }

  //---------------------------------------------------------------------
  // Properties
  //---------------------------------------------------------------------

  /// The [VertexElementUsage] of the semantic.
  VertexElementUsage get usage => _semantic.usage;

  /// The index of the semantic.
  int get usageIndex => _semantic.usageIndex;

  /// The name of the symbol within the [EffectPass].
  ///
  /// Used to map the name of the attribute within the [EffectPass] to
  /// the associated [VertexElement].
  String get symbol => _symbol;
}
