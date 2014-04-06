// Copyright (c) 2013-2014, the Lithium-Ion Engine project authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

part of lithium_content;

/// Function signature for creating an [OpenGLTransmissionFormat] from a [Map].
///
/// Used when parsing a list of [OpenGLTransmissionFormat]s. The function
/// should just call the fromJson constructor of the format.
typedef OpenGLTransmissionFormat _CreateFormat(Map value);

/// Base class for OpenGL Transmission format readers.
class OpenGLTransmissionFormat {
  //---------------------------------------------------------------------
  // Member variables
  //---------------------------------------------------------------------

  /// Whether the instance just refers to data defined elsewhere.
  bool _isReference;
  /// The name of the resource.
  ///
  /// This should be globally unique.
  String _name;

  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  /// Creates an instance of the [OpenGLTransmissionFormat] where the data is
  /// in another instance.
  OpenGLTransmissionFormat._reference(String name)
      : _isReference = true
      , _name = name;

  /// Creates an instance of the [OpenGLTransmissionFormat] class from JSON
  /// data.
  OpenGLTransmissionFormat._fromJson(Map json)
      : _isReference = false
  {
    // Get the name
    _name = json['name'];

    if (_name == null) {
      throw new ArgumentError('A name was not provided');
    }
  }

  //---------------------------------------------------------------------
  // Properties
  //---------------------------------------------------------------------

  /// Whether the instance just refers to data defined elsewhere.
  ///
  /// If the value is true then the [name] should be used to find the instance
  /// with the actual data; otherwise the instance will contain all the data
  /// required.
  bool get isReference => _isReference;

  /// The name of the resource.
  ///
  /// This should be globally unique.
  String get name => _name;

  //---------------------------------------------------------------------
  // Class methods
  //---------------------------------------------------------------------

  /// Parses a list containing a subclass of [OpenGLTransmissionFormat].
  ///
  /// Uses the [create] function to populate a [Map] containing the values
  /// where the [name] is the key value.
  static Map _parseList(List values, _CreateFormat create) {
    var formats = new Map();

    values.forEach((value) {
      var format = create(value);

      if (formats.containsKey(format.name)) {
        throw new ArgumentError('The name ${format.name} is not unique');
      }

      formats[format.name] = format;
    });

    return formats;
  }
}
