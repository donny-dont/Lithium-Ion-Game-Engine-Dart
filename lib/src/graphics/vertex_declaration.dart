// Copyright (c) 2013-2014, the Lithium-Ion Engine Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

part of lithium_graphics;

/// Defines per-vertex data.
class VertexDeclaration extends GraphicsResource {
  //---------------------------------------------------------------------
  // Member variables
  //---------------------------------------------------------------------

  /// The [VertexElement]s to bind to the pipeline.
  ///
  /// The elements are sorted by the [VertexElement.slot].
  List<VertexElement> _elements;
  /// The vertex strides for each individual [VertexBuffer] associated with the declaration.
  List<int> _strides;

  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  /// Creates an instance of the [VertexDeclaration] class from a list of [VertexElement]s.
  ///
  /// The vertex strides for each slot are computed by using the
  /// [VertexElement.offset]s and [VertexElement.format]s. If this computation
  /// does not reflect the actual stride, in the case of additional padding
  /// be used, then the [strides] should be explicitly specified.
  VertexDeclaration(GraphicsDevice device, List<VertexElement> elements, [List strides])
      : super._internal(device)
  {
    assert(elements != null);
    assert(_areElementsValid(elements));

    _graphicsDevice._createWithoutBinding(this);

    // Copy the elements
    _copyVertexElements(elements);

    // Sort the elements
    _elements.sort(_compareVertexElement);

    if (strides != null) {
      assert(_areStridesValid(strides));

      _strides = new List<int>.from(strides, growable: false);
    } else {
      // Compute the strides
      _computeStrides();
    }
  }

  /// Creates an instance of the [VertexDeclaration] class that contains position data.
  ///
  /// If [simdAligned] is set to true then each [VertexElement] will be aligned
  /// to a 128-bit value.
  VertexDeclaration.position(GraphicsDevice device, [bool simdAligned = false])
      : super._internal(device)
  {
    _graphicsDevice._createWithoutBinding(this);

    var elements = [ VertexElementUsage.Position ];

    _createElements(elements, simdAligned);
  }

  /// Creates an instance of the [VertexDeclaration] class that contains position and color data.
  ///
  /// If [simdAligned] is set to true then each [VertexElement] will be aligned
  /// to a 128-bit value.
  VertexDeclaration.positionColor(GraphicsDevice device, [bool simdAligned = false])
      : super._internal(device)
  {
    _graphicsDevice._createWithoutBinding(this);

    var elements = [
        VertexElementUsage.Position,
        VertexElementUsage.Color
    ];

    _createElements(elements, simdAligned);
  }

  /// Creates an instance of the [VertexDeclaration] class that contains position, color and size data.
  ///
  /// If [simdAligned] is set to true then each [VertexElement] will be aligned
  /// to a 128-bit value.
  VertexDeclaration.positionColorSize(GraphicsDevice device, [bool simdAligned = false])
      : super._internal(device)
  {
    _graphicsDevice._createWithoutBinding(this);

    var elements = [
        VertexElementUsage.Position,
        VertexElementUsage.Color,
        VertexElementUsage.PointSize
    ];

    _createElements(elements, simdAligned);
  }

  /// Creates an instance of the [VertexDeclaration] class that contains position, color and texture data.
  ///
  /// If [simdAligned] is set to true then each [VertexElement] will be aligned
  /// to a 128-bit value.
  VertexDeclaration.positionColorTexture(GraphicsDevice device, [bool simdAligned = false])
      : super._internal(device)
  {
    _graphicsDevice._createWithoutBinding(this);

    var elements = [
        VertexElementUsage.Position,
        VertexElementUsage.Color,
        VertexElementUsage.TextureCoordinate
    ];

    _createElements(elements, simdAligned);
  }

  /// Creates an instance of the [VertexDeclaration] class that contains position, normal and texture data.
  ///
  /// If [simdAligned] is set to true then each [VertexElement] will be aligned
  /// to a 128-bit value.
  VertexDeclaration.positionNormalTexture(GraphicsDevice device, [bool simdAligned = false])
      : super._internal(device)
  {
    _graphicsDevice._createWithoutBinding(this);

    var elements = [
        VertexElementUsage.Position,
        VertexElementUsage.Normal,
        VertexElementUsage.TextureCoordinate
    ];

    _createElements(elements, simdAligned);
  }

  /// Creates an instance of the [VertexDeclaration] class that contains position and texture data.
  ///
  /// If [simdAligned] is set to true then each [VertexElement] will be aligned
  /// to a 128-bit value.
  VertexDeclaration.positionTexture(GraphicsDevice device, [bool simdAligned = false])
      : super._internal(device)
  {
    _graphicsDevice._createWithoutBinding(this);

    var elements = [
        VertexElementUsage.Position,
        VertexElementUsage.TextureCoordinate
    ];

    _createElements(elements, simdAligned);
  }

  /// Creates the element and offset data from the given list of [VertexElementUsage] enumerations.
  ///
  /// If [simdAligned] is set to true then each [VertexElement] will be aligned
  /// to a 128-bit value.
  void _createElements(List<VertexElementUsage> elements, bool simdAligned) {
    // Create the offsets in bytes for the data
    int scalarSize  = (simdAligned) ? 16 :  4;
    int vector2Size = (simdAligned) ? 16 :  8;
    int vector3Size = (simdAligned) ? 16 : 12;
    int vector4Size = 16;

    // Create the element list
    int elementCount = elements.length;
    int offset = 0;

    _elements = new List<VertexElement>(elementCount);

    for (int i = 0; i < elementCount; ++i) {
      var usage = elements[i];
      var element;

      switch (usage) {
        case VertexElementUsage.Position:
        case VertexElementUsage.Normal:
        case VertexElementUsage.Tangent:
        case VertexElementUsage.Binormal:
          element = new VertexElement(offset, VertexElementFormat.Vector3, usage);
          offset += vector3Size;
          break;
        case VertexElementUsage.TextureCoordinate:
          element = new VertexElement(offset, VertexElementFormat.Vector2, usage);
          offset += vector2Size;
          break;
        case VertexElementUsage.Color:
          element = new VertexElement(offset, VertexElementFormat.Vector4, usage);
          offset += vector4Size;
          break;
        case VertexElementUsage.PointSize:
          element = new VertexElement(offset, VertexElementFormat.Scalar, usage);
          offset += scalarSize;
          break;
      }

      _elements[i] = element;
    }

    // Set the stride
    _strides = new List<int>(1);
    _strides[0] = offset;
  }

  //---------------------------------------------------------------------
  // Properties
  //---------------------------------------------------------------------

  /// The number of [VertexBuffer] slots used in this declaration.
  int get slots => _strides.length;

  //---------------------------------------------------------------------
  // Public methods
  //---------------------------------------------------------------------

  /// Gets the stride for the vertex buffer at the given [index].
  int getVertexStride(int index) {
    assert((index >= 0) && (index < _strides.length));

    return _strides[index];
  }

  /// Queries whether a [VertexElement] with the given [usage] and [usageIndex] is present.
  bool hasElement(VertexElementUsage usage, int usageIndex) {
    return _findElement(usage, usageIndex) != null;
  }

  /// Immediately releases the unmanaged resources used by this object.
  void dispose() {
    _graphicsDevice._destroyWithoutBinding(this);
  }

  //---------------------------------------------------------------------
  // Private methods
  //---------------------------------------------------------------------

  /// Finds a [VertexElement] with the given [usage] and [usageIndex].
  VertexElement _findElement(VertexElementUsage usage, int usageIndex) {
    int elementCount = _elements.length;

    for (int i = 0; i < elementCount; ++i) {
      var element = _elements[i];

      if ((element.usage == usage) && (element.usageIndex == usageIndex)) {
        return element;
      }
    }

    // Not found
    return null;
  }

  /// Copies the values in [elements] internally.
  void _copyVertexElements(List<VertexElement> elements) {
    int elementCount = elements.length;

    _elements = new List<VertexElement>(elementCount);

    for (int i = 0; i < elementCount; ++i) {
      _elements[i] = elements[i];
    }
  }

  /// Compute the strides for each slot.
  ///
  ///
  void _computeStrides() {
    int elementCount = _elements.length;

    // The elements are sorted according to slots so the last element has the
    // largest vertex buffer slot
    int slotCount = _elements[elementCount - 1].slot + 1;

    _strides = new List<int>.filled(slotCount, 0);

    // Compute the strides
    for (int i = 0; i < elementCount; ++i) {
      var element = _elements[i];

      int slot = element.slot;
      int endingByte = element.offset + _vertexElementFormatInBytes(element.format);

      _strides[slot] = Math.max(endingByte, _strides[slot]);
    }
  }

  /// Verifies the values in [strides] are valid.
  ///
  /// If the values computed are greater than the values contained in [strides]
  /// then the method returns false. It also returns false if not all [strides]
  /// are specified.
  bool _areStridesValid(List<int> strides) {
    _computeStrides();

    int slotCount = _strides.length;

    if (slotCount != strides.length) {
      return false;
    }

    for (int i = 0; i < slotCount; ++i) {
      if (_strides[i] > strides[i]) {
        return false;
      }
    }

    return true;
  }

  //---------------------------------------------------------------------
  // Class methods
  //---------------------------------------------------------------------

  /// Verifies the values in [elements].
  ///
  /// Checks that the same semantic does not point to different locations.
  static bool _areElementsValid(List<VertexElement> elements) {
    int elementCount = elements.length;

    for (int i = 0; i < elementCount; ++i) {
      for (int j = i + 1; j < elementCount; ++j) {
        var a = elements[i];
        var b = elements[j];

        if ((a.usage == b.usage) && (a.usageIndex == b.usageIndex)) {
          return false;
        }
      }
    }

    return true;
  }

  /// Compares two [VertexElement]s.
  ///
  /// Sorts by first comparing the [VertexElement.slot]. If equal then the value
  /// of [VertexElement.usage] is compared. If that is equal as well the
  /// [VertexElement.usageIndex] is compared.
  static int _compareVertexElement(VertexElement a, VertexElement b) {
    if (identical(a, b)) {
      return 0;
    }

    // Compare the slots
    int aSlot = a.slot;
    int bSlot = b.slot;

    if (aSlot == bSlot) {
      // Compare the usage
      var aUsage = a.usage;
      var bUsage = b.usage;

      if (aUsage == bUsage) {
        // Compare the usage index
        int aUsageIndex = a.usageIndex;
        int bUsageIndex = b.usageIndex;

        if (aUsageIndex == bUsageIndex) {
          return 0;
        } else {
          return (aUsageIndex < bUsageIndex) ? -1 : 1;
        }
      } else {
        return (aUsage.index < bUsage.index) ? -1 : 1;
      }
    } else {
      return (aSlot < bSlot) ? -1 : 1;
    }
  }
}
