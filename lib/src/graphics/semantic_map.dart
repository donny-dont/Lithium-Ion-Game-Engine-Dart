// Copyright (c) 2013-2014, the Lithium-Ion Engine project authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

part of lithium_graphics;

///
///
class SemanticMap {
  //---------------------------------------------------------------------
  // Class variables
  //---------------------------------------------------------------------

  static const int notFound = -1;

  static SemanticMap _defaultMapping;

  /// Default vertex attribute names.
  static Map<String, String> _defaultAttributes;

  //---------------------------------------------------------------------
  // Member variables
  //---------------------------------------------------------------------

  /// Maps the semantic name to a attribute index.
  Map<String, int> _mapping = new Map<String, int>();

  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  SemanticMap();

  //---------------------------------------------------------------------
  // Public methods
  //---------------------------------------------------------------------

  /// Retrieves the vertex attribute index with the given [usage] and [usageIndex].
  ///
  /// Returns [SemanticMap.notFound] if the semantic is not found.
  int indexOf(VertexElementUsage usage, int usageIndex) {
    var semanticName = _toSemanticName(usage, usageIndex);

    return _indexOfSemantic(semanticName);
  }

  /// Maps a [usage] and [usageIndex] to a vertex attribute [index].
  ///
  /// If the [index] is already in use the
  void add(VertexElementUsage usage, int usageIndex, int index) {
    // See if the index is already in use
    if (_mapping.containsValue(index)) {
      var boundTo;

      _mapping.forEach((key, value) {
        if (value == index) {
          boundTo = key;
        }
      });

      _mapping.remove(boundTo);
    }

    // Bind the mapping
    var semanticName = _toSemanticName(usage, usageIndex);
    _mapping[semanticName] = index;
  }

  //---------------------------------------------------------------------
  // Private methods
  //---------------------------------------------------------------------

  /// Retrieves the vertex attribute index with the given semantic [name].
  int _indexOfSemantic(String name) {
    return (_mapping.containsKey(name)) ? _mapping[name] : notFound;
  }

  //---------------------------------------------------------------------
  // Class properties
  //---------------------------------------------------------------------

  /// Gets the default [SemanticMap] which is used whenever a mapper is not provided.
  ///
  ///
  static SemanticMap get defaultMapping {
    if (_defaultMapping == null) {
      _defaultMapping = new SemanticMap();

      _defaultMapping.add(VertexElementUsage.Position         , 0, 0);
      _defaultMapping.add(VertexElementUsage.Normal           , 0, 1);
      _defaultMapping.add(VertexElementUsage.Tangent          , 0, 2);
      _defaultMapping.add(VertexElementUsage.Binormal         , 0, 3);
      _defaultMapping.add(VertexElementUsage.PointSize        , 0, 4);
      _defaultMapping.add(VertexElementUsage.Color            , 0, 5);
      _defaultMapping.add(VertexElementUsage.TextureCoordinate, 0, 6);
      _defaultMapping.add(VertexElementUsage.TextureCoordinate, 1, 7);
      _defaultMapping.add(VertexElementUsage.TextureCoordinate, 2, 8);
      _defaultMapping.add(VertexElementUsage.TextureCoordinate, 3, 9);
    }

    return _defaultMapping;
  }
  static set defaultMapping(SemanticMap value) { _defaultMapping = value; }

  static Map<String, String> get defaultAttributes {
    if (_defaultAttributes == null) {
      _defaultAttributes = {
          'vPosition' : _toSemanticName(VertexElementUsage.Position         , 0),
          'vNormal'   : _toSemanticName(VertexElementUsage.Normal           , 0),
          'vTangent'  : _toSemanticName(VertexElementUsage.Tangent          , 0),
          'vBinormal' : _toSemanticName(VertexElementUsage.Binormal         , 0),
          'vPointSize': _toSemanticName(VertexElementUsage.PointSize        , 0),
          'vColor'    : _toSemanticName(VertexElementUsage.Color            , 0),
          'vTexCoord0': _toSemanticName(VertexElementUsage.TextureCoordinate, 0),
          'vTexCoord1': _toSemanticName(VertexElementUsage.TextureCoordinate, 1),
          'vTexCoord2': _toSemanticName(VertexElementUsage.TextureCoordinate, 2),
          'vTexCoord3': _toSemanticName(VertexElementUsage.TextureCoordinate, 3)
      };
    }

    return _defaultAttributes;
  }
  static set defaultAttributes(Map<String, String> value) { _defaultAttributes = value; }

  static String _toSemanticName(VertexElementUsage usage, int index) {
    String semantic;

    switch (usage) {
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

