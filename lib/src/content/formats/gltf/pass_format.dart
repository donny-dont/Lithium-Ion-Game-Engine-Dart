// Copyright (c) 2012, the Lihtium-Ion Engine project authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

part of lithium_content;

/// Defines a shader asset to load.
///
/// This corresponds roughly to the shader specification within the
/// [OpenGL Transmission Format (glTF)](https://github.com/KhronosGroup/glTF/blob/master/specification/README.md#shader)
/// with the addition of a field that can hold the source code.
class ShaderFormat extends OpenGLTransmissionFormat {
  //---------------------------------------------------------------------
  // Member variables
  //---------------------------------------------------------------------

  /// The url for the resource shader source.
  String _url;
  /// The source for the shader.
  String _source;

  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  /// Creates an instance of the [ShaderFormat] where the data is in another instance.
  ShaderFormat.reference(String name)
      : super._reference(name);

  /// Creates an instance of the [ShaderFormat] class from JSON data.
  ShaderFormat.fromJson(Map json)
      : super._fromJson(json)
  {
    // Get the URL or source.
    _url    = json['path'];
    _source = json['source'];

    // Make sure some data is present
    if ((_url == null) && (_source == null)) {
      throw new ArgumentError('Neither source nor a data uri was provided');
    }

    // Make sure only one path to the source is available.
    if ((_url != null) && (_source != null)) {
      throw new ArgumentError('Both source and a data uri was provided');
    }
  }

  //---------------------------------------------------------------------
  // Properties
  //---------------------------------------------------------------------

  /// The name of the resource.
  ///
  /// This should be globally unique.
  String get name => _name;

  /// The url for the resource shader source.
  String get url => _url;

  /// The source for the shader.
  String get source => _source;

  /// Whether the source code is already loaded.
  bool get hasSource => _source != null;

  //---------------------------------------------------------------------
  // Class methods
  //---------------------------------------------------------------------

  /// Parses a list containing [ShaderFormat]s.
  ///
  /// Returns a [Map] containing the [ShaderFormat]s where the [name] is the
  /// key value.
  static Map<String, ShaderFormat> parseList(List formats) {
    var create = (value) => new ShaderFormat.fromJson(value);

    return OpenGLTransmissionFormat._parseList(formats, create);
  }
}