// Copyright (c) 2012, the Lihtium-Ion Engine project authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

part of lithium_content;

/// Defines an [EffectPass] asset to load.
///
/// This corresponds roughly to the shader specification within the
/// [OpenGL Transmission Format (glTF)](https://github.com/KhronosGroup/glTF/blob/master/specification/README.md#program)
/// which ignores the uniform variables field.
class ProgramFormat extends OpenGLTransmissionFormat {
  //---------------------------------------------------------------------
  // Member variables
  //---------------------------------------------------------------------

  /// The [ProgramAttribute]s associated with the [EffectPass].
  ///
  /// The semantics specified allow mapping of an [VertexElement] to a specific
  /// vertex attribute within the [EffectPass].
  List<ProgramAttribute> _attributes;
  /// The vertex shader to attach to the [EffectPass].
  ShaderFormat _vertexShader;
  /// The fragment shader to attach to the [EffectPass].
  ShaderFormat _fragmentShader;

  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  /// Creates an instance of the [ProgramFormat] where the data is in another instance.
  ProgramFormat.reference(String name)
      : super._reference(name);

  /// Creates an instance of the [ProgramFormat] class from JSON data.
  ProgramFormat.fromJson(Map json)
      : super._fromJson(json)
  {
    List attributes = json['attributes'];

    if (attributes == null) {
      throw new ArgumentError('No attribute data is provided');
    }

    int attributeCount = attributes.length;
    _attributes = new List<ProgramAttribute>(attributeCount);

    for (int i = 0; i < attributeCount; ++i) {
      _attributes[i] = new ProgramAttribute.fromJson(attributes[i]);
    }

    // Parse the shader data
    _vertexShader   = _parseShader(json['vertexShader']);
    _fragmentShader = _parseShader(json['fragmentShader']);
  }

  /// Parses the [ShaderFormat].
  ShaderFormat _parseShader(dynamic shader) {
    if (shader == null) {
      throw new ArgumentError('Shader not present');
    }

    if (shader is Map) {
      return new ShaderFormat.fromJson(shader);
    } else if (shader is String) {
      return new ShaderFormat.reference(shader);
    } else {
      throw new ArgumentError('Shader data is invalid');
    }
  }

  //---------------------------------------------------------------------
  // Properties
  //---------------------------------------------------------------------

  /// The [ProgramAttribute]s associated with the [EffectPass].
  ///
  /// The semantics specified allow mapping of an [VertexElement] to a specific
  /// vertex attribute within the [EffectPass].
  List<ProgramAttribute> get attributes => _attributes;

  /// The vertex shader to attach to the [EffectPass].
  ShaderFormat get vertexShader => _vertexShader;

  /// The fragment shader to attach to the [EffectPass].
  ShaderFormat get fragmentShader => _fragmentShader;

  //---------------------------------------------------------------------
  // Class methods
  //---------------------------------------------------------------------

  /// Parses a list containing [ProgramFormat]s.
  ///
  /// Returns a [Map] containing the [ProgramFormat]s where the [name] is the
  /// key value.
  static Map<String, ProgramFormat> parseList(List formats) {
    var create = (value) => new ProgramFormat.fromJson(value);

    return OpenGLTransmissionFormat._parseList(formats, create);
  }
}