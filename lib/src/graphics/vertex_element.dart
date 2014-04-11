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
  final int slot;
  /// The offset (if any) from the beginning of the [VertexBuffer] to the beginning of the vertex data.
  final int offset;
  /// Modifies the usage data to allow the user to specify multiple usage types.
  final int usageIndex;
  /// The [VertexElementFormat] of this vertex element.
  final VertexElementFormat format;
  /// The [VertexElementUsage] for this vertex element.
  final VertexElementUsage usage;
  /// The number of instances to draw using the same per instance data before advancing the buffer by one element.
  ///
  /// For non-instanced data this value is set to 0.
  final int instanceDataStepRate;

  int _vertexAttribIndex;

  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  /// Initializes an instance of the [VertexElement] class.
  VertexElement(this.offset, this.format, this.usage, {this.usageIndex : 0, this.slot : 0, this.instanceDataStepRate: 0}) {
    assert(slot >= 0);
    assert(offset >= 0);
    assert(usageIndex >= 0);
    assert(instanceDataStepRate >= 0);

    // \TODO REMOVE
    _vertexAttribIndex = usage.index;
  }
}
