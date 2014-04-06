// Copyright (c) 2013-2014, the Lithium-Ion Engine Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

part of lithium_graphics;

/// Defines input vertex data to the pipeline.
class VertexElement {
  //---------------------------------------------------------------------
  // Member variables
  //---------------------------------------------------------------------

  /// The index of the [VertexBuffer] the vertex element refers to.
  int _slot;
  /// The offset (if any) from the beginning of the [VertexBuffer] to the beginning of the vertex data.
  int _offset;
  /// Modifies the usage data to allow the user to specify multiple usage types.
  int _usageIndex;
  /// The [VertexElementFormat] of this vertex element.
  int _format;
  /// The [VertexElementUsage] for this vertex element.
  int _usage;
  /// The actual attribute index within WebGL.
  int _vertexAttribIndex;

  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  /// Initializes an instance of the [VertexElement] class.
  VertexElement(int offset, int format, int usage, {int usageIndex : 0, int slot : 0})
      : _slot = slot
      , _offset = offset
      , _format = format
      , _usage = usage
      , _usageIndex = usageIndex
  {
    assert(slot >= 0);
    assert(offset >= 0);
    assert(VertexElementFormat.isValid(format));
    assert(VertexElementUsage.isValid(usage));
    assert(usageIndex >= 0);

    // \TODO REMOVE!
    _vertexAttribIndex = usage;
  }

  //---------------------------------------------------------------------
  // Properties
  //---------------------------------------------------------------------

  /// The index of the [VertexBuffer] the vertex element refers to.
  int get slot => _slot;

  /// The offset (if any) from the beginning of the [VertexBuffer] to the beginning of the vertex data.
  int get offset => _offset;

  /// Modifies the usage data to allow the user to specify multiple usage types.
  int get usageIndex => _usageIndex;

  /// The [VertexElementFormat] of this vertex element.
  int get format => _format;

  /// The [VertexElementUsage] for this vertex element.
  int get usage => _usage;

  //---------------------------------------------------------------------
  // Private methods
  //---------------------------------------------------------------------

  /// Converts the [VertexElement] to a semantic name.
  ///
  /// A semantic name is used to map between the [VertexDeclaration] and the
  /// vertex attributes used in an [EffectPass].
  ///
  /// This aligns to DirectX conventions.
  String _toSemanticName() {
    return VertexElementUsage._toSemanticName(_usage, _usageIndex);
  }
}
