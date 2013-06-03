// Copyright (c) 2013, the Lihtium-Ion Engine Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

library vertex_element_format_test;

import 'package:unittest/unittest.dart';
import 'package:lithium_ion/graphics.dart';

var throwsAssertionError = throwsA(new isInstanceOf<AssertionError>());

void main() {
  test('values', () {
    expect(VertexElementFormat.Scalar , 1);
    expect(VertexElementFormat.Vector2, 2);
    expect(VertexElementFormat.Vector3, 3);
    expect(VertexElementFormat.Vector4, 4);
  });

  test('stringify', () {
    expect(VertexElementFormat.stringify(VertexElementFormat.Scalar) , 'Scalar');
    expect(VertexElementFormat.stringify(VertexElementFormat.Vector2), 'Vector2');
    expect(VertexElementFormat.stringify(VertexElementFormat.Vector3), 'Vector3');
    expect(VertexElementFormat.stringify(VertexElementFormat.Vector4), 'Vector4');

    expect(() { VertexElementFormat.stringify(-1); }, throwsAssertionError);
  });

  test('parse', () {
    expect(VertexElementFormat.parse('Scalar') , VertexElementFormat.Scalar);
    expect(VertexElementFormat.parse('Vector2'), VertexElementFormat.Vector2);
    expect(VertexElementFormat.parse('Vector3'), VertexElementFormat.Vector3);
    expect(VertexElementFormat.parse('Vector4'), VertexElementFormat.Vector4);

    expect(() { VertexElementFormat.parse('NotValid'); }, throwsAssertionError);
  });

  test('isValid', () {
    expect(VertexElementFormat.isValid(VertexElementFormat.Scalar) , true);
    expect(VertexElementFormat.isValid(VertexElementFormat.Vector2), true);
    expect(VertexElementFormat.isValid(VertexElementFormat.Vector3), true);
    expect(VertexElementFormat.isValid(VertexElementFormat.Vector4), true);

    expect(VertexElementFormat.isValid(-1), false);
  });
}
