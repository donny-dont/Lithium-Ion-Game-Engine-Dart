// Copyright (c) 2013-2014, the Lithium-Ion Engine Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

library viewport_test;

import 'package:unittest/unittest.dart';
import 'package:lithium_ion/graphics.dart';

import 'graphics_resource_equality.dart';
import 'graphics_mocks.dart';
import '../test_helpers.dart';

var graphicsDevice;

void testDimensionSetter(String testName, dynamic function) {
  var viewport = new Viewport(graphicsDevice);

  test(testName, () {
    expect(function(viewport,    0), 0);
    expect(function(viewport, 1024), 1024);

    expect(() { function(viewport, -1); }, throwsAssertionError);
  });
}

void testDepthRangeSetter(String testName, dynamic function) {
  var viewport = new Viewport(graphicsDevice);

  test(testName, () {
    expect(function(viewport, 0.0), 0.0);
    expect(function(viewport, 0.5), 0.5);
    expect(function(viewport, 1.0), 1.0);

    expect(() { function(viewport, -0.00001); }, throwsAssertionError);
    expect(() { function(viewport,  1.00001); }, throwsAssertionError);
    expect(() { function(viewport, -1.00000); }, throwsAssertionError);
    expect(() { function(viewport,  2.00000); }, throwsAssertionError);

    expect(() { function(viewport, double.INFINITY); }         , throwsAssertionError);
    expect(() { function(viewport, double.NEGATIVE_INFINITY); }, throwsAssertionError);
    expect(() { function(viewport, double.NAN); }              , throwsAssertionError);
  });
}

void testConstructor(Viewport viewport, int x, int y, int width, int height) {
  expect(viewport.x, x);
  expect(viewport.y, y);

  expect(viewport.width , width);
  expect(viewport.height, height);

  expect(viewport.minDepth, 0.0);
  expect(viewport.maxDepth, 1.0);
}

void main() {
  graphicsDevice = createMockGraphicsDevice();

  // Construction
  test('construction', () {
    // Default constructor
    var defaultViewport = new Viewport(graphicsDevice);
    testConstructor(defaultViewport, 0, 0, 640, 480);
    expect(() { var constructWithNull = new Viewport(null); }, throwsAssertionError);

    // Viewport.bounds
    Viewport bounds = new Viewport.bounds(graphicsDevice, 160, 120, 320, 240);
    testConstructor(bounds, 160, 120, 320, 240);
    expect(() { Viewport constructWithNull = new Viewport.bounds(null, 160, 120, 320, 240); }, throwsAssertionError);
  });

  // Dimension setters
  testDimensionSetter('width', (viewport, value) {
    viewport.width = value;
    return viewport.width;
  });

  testDimensionSetter('height', (viewport, value) {
    viewport.height = value;
    return viewport.height;
  });

  // Range setters
  testDepthRangeSetter('minDepth', (viewport, value) {
    viewport.minDepth = value;
    return viewport.minDepth;
  });

  testDepthRangeSetter('maxDepth', (viewport, value) {
    viewport.maxDepth = value;
    return viewport.maxDepth;
  });

  // Equality
  test('equality', () {
    var viewport0 = new Viewport(graphicsDevice);
    var viewport1 = new Viewport(graphicsDevice);

    // Check identical
    expect(viewportEqual(viewport0, viewport0), true);
    expect(viewportEqual(viewport0, viewport1), true);

    // Check inequality
    viewport0.x = 160;
    expect(viewportEqual(viewport0, viewport1), false);
    viewport1.x = viewport0.x;
    expect(viewportEqual(viewport0, viewport1), true);

    viewport0.y = 120;
    expect(viewportEqual(viewport0, viewport1), false);
    viewport1.y = viewport0.y;
    expect(viewportEqual(viewport0, viewport1), true);

    viewport0.width = 320;
    expect(viewportEqual(viewport0, viewport1), false);
    viewport1.width = viewport0.width;
    expect(viewportEqual(viewport0, viewport1), true);

    viewport0.height = 240;
    expect(viewportEqual(viewport0, viewport1), false);
    viewport1.height = viewport0.height;
    expect(viewportEqual(viewport0, viewport1), true);

    viewport0.minDepth = 0.1;
    expect(viewportEqual(viewport0, viewport1), false);
    viewport1.minDepth = viewport0.minDepth;
    expect(viewportEqual(viewport0, viewport1), true);

    viewport0.maxDepth = 0.9;
    expect(viewportEqual(viewport0, viewport1), false);
    viewport1.maxDepth = viewport0.maxDepth;
    expect(viewportEqual(viewport0, viewport1), true);
  });
}
