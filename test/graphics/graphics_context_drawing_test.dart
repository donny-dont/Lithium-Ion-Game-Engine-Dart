// Copyright (c) 2013-2014, the Lithium-Ion Engine Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

part of graphics_context_test;

//---------------------------------------------------------------------
// VertexDeclaration tests
//---------------------------------------------------------------------

/// Compares two [VertexElement]s for equality.
bool vertexElementUsageEqual(VertexElement a, VertexElement b) {
  if (identical(a, b)) {
    return true;
  }

  return ((a.usage == b.usage) && (a.usageIndex == b.usageIndex));
}

void testVertexElementEnabled(MockRenderingContext gl, VertexElement element, int index, int stride) {
  var call = callsTo(
      'vertexAttribPointer',
      index,
      element.format,
      0x1406, //WebGL.FLOAT,
      false,
      stride,
      element.offset
  );

  gl.getLogs(call).verify(happenedOnce);
}

void verifyVertexDeclaration(MockRenderingContext gl, List<VertexElement> elements, List<VertexElement> lastElements, int stride) {
  var alreadyEnabled = new List<VertexElement>();
  var justEnabled    = new List<VertexElement>();
  var disabled       = new List<VertexElement>();

  int elementCount = elements.length;
  int lastElementCount = lastElements.length;

  // Get the elements that are enabled
  for (int i = 0; i < elementCount; ++i) {
    bool isAlreadyEnabled = false;
    var element = elements[i];

    for (int j = 0; j < lastElementCount; ++j) {
      if (vertexElementUsageEqual(element, lastElements[j])) {
        isAlreadyEnabled = true;
        break;
      }
    }

    if (isAlreadyEnabled) {
      alreadyEnabled.add(element);
    } else {
      justEnabled.add(element);
    }
  }

  // Get the elements that are disabled
  for (int i = 0; i < lastElementCount; ++i) {
    bool isDisabled = true;
    var element = lastElements[i];

    for (int j = 0; j < elementCount; ++j) {
      if (vertexElementUsageEqual(element, elements[j])) {
        isDisabled = false;
        break;
      }
    }

    if (isDisabled) {
      disabled.add(element);
    }
  }

  // Check the enabled elements
  int justEnabledCount = justEnabled.length;

  gl.getLogs(callsTo('enableVertexAttribArray')).verify(happenedExactly(justEnabledCount));

  for (int i = 0; i < justEnabledCount; ++i) {
    var element = justEnabled[i];

    // \TODO Get the actual attribute index
    int index = element.usage;

    gl.getLogs(callsTo('enableVertexAttribArray', index)).verify(happenedOnce);
    testVertexElementEnabled(gl, element, index, stride);
  }

  // Check the already enabled elements
  int alreadyEnabledCount = alreadyEnabled.length;

  gl.getLogs(callsTo('vertexAttribPointer')).verify(happenedExactly(alreadyEnabledCount + justEnabledCount));

  for (int i = 0; i < alreadyEnabledCount; ++i) {
    var element = alreadyEnabled[i];

    // \TODO Get the actual attribute index
    int index = element.usage;

    testVertexElementEnabled(gl, element, index, stride);
  }

  // Check the disabled elements
  int disabledCount = disabled.length;

  gl.getLogs(callsTo('disableVertexAttribArray')).verify(happenedExactly(disabledCount));

  for (int i = 0; i < disabledCount; ++i) {
    // \TODO Get the actual attribute index
    int index = disabled[i].usage;

    gl.getLogs(callsTo('disableVertexAttribArray', index)).verify(happenedOnce);
  }
}

void testVertexDeclarationTransitions() {
  var graphicsDevice = createMockGraphicsDevice();
  var gl = graphicsDevice.gl as MockRenderingContext;
  var graphicsContext = graphicsDevice.graphicsContext;

  var vertexBuffer = new VertexBuffer.static(graphicsDevice);

  graphicsContext.setVertexBuffers([ vertexBuffer ]);

  var elementUsages = [
      VertexElementUsage.Position,
      VertexElementUsage.Normal,
      VertexElementUsage.Tangent,
      VertexElementUsage.Binormal,
      VertexElementUsage.TextureCoordinate,
      VertexElementUsage.PointSize
  ];

  int elementUsageCount = elementUsages.length;

  var elements = new List<VertexElement>();
  var vertexDeclaration;
  var lastElements = [];

  for (int i = 0; i < elementUsageCount; ++i) {
    elements = new List<VertexElement>();
    int offset = 0;

    for (int j = i; j < elementUsageCount; ++j) {
      var element = new VertexElement(
          offset,
          VertexElementFormat.Vector4,
          elementUsages[j]
      );

      elements.add(element);
      offset += 4;
    }

    vertexDeclaration = new VertexDeclaration(graphicsDevice, elements);

    graphicsContext.setVertexDeclaration(vertexDeclaration);
    graphicsContext.drawVertexPrimitiveRange(PrimitiveType.TriangleList, 0, 4);

    verifyVertexDeclaration(gl, elements, lastElements, vertexDeclaration.getStride(0));

    gl.clearLogs();

    lastElements = elements;
  }
}

void testVertexDeclaration() {
  test('setVertexDeclaration', () {
    testVertexDeclarationTransitions();
  });
}
