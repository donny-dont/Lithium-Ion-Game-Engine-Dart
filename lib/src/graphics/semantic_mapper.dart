// Copyright (c) 2012, the Lihtium-Ion Engine project authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

part of lithium_graphics;

class SemanticMapper {
  //---------------------------------------------------------------------
  // Class variables
  //---------------------------------------------------------------------

  SemanticMapper _defaultMapping;

  //---------------------------------------------------------------------
  // Member variables
  //---------------------------------------------------------------------

  /// Maps the semantic name to a attribute index.
  Map<String, int> _mapping = new Map<String, int>();

  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  SemanticMapper();

  //---------------------------------------------------------------------
  // Public methods
  //---------------------------------------------------------------------

  /// Retrives the vertex attribute index with the given [usage] and [usageIndex].
  ///
  /// Returns -1 if the semantic is not found.
  int indexOf(int usage, int usageIndex) {
    var semanticName = VertexElementUsage._toSemanticName(usage, usageIndex);

    return (_mapping.containsKey(semanticName)) ? _mapping[semanticName] : -1;
  }

  /// Maps a [usage] and [usageIndex] to a vertex attribute [index].
  ///
  /// If the [index] is already in use the
  void add(int usage, int usageIndex, int index) {
    assert(VertexElementUsage.isValid(usage));

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
    var semanticName = VertexElementUsage._toSemanticName(usage, usageIndex);
    _mapping[VertexElementUsage] = index;
  }

  //---------------------------------------------------------------------
  // Class properties
  //---------------------------------------------------------------------

  static SemanticMapper get defaultMapping {
    if (_defaultMapping == null) {
      _defaultMapping = new SemanticMapper();

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
  static set defaultMapping(SemanticMapper value) { _defaultMapping = value; }
}
