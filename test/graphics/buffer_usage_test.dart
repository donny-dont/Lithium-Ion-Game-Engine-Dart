/*
  Copyright (C) 2013 Spectre Authors

  This software is provided 'as-is', without any express or implied
  warranty.  In no event will the authors be held liable for any damages
  arising from the use of this software.

  Permission is granted to anyone to use this software for any purpose,
  including commercial applications, and to alter it and redistribute it
  freely, subject to the following restrictions:

  1. The origin of this software must not be misrepresented; you must not
     claim that you wrote the original software. If you use this software
     in a product, an acknowledgment in the product documentation would be
     appreciated but is not required.
  2. Altered source versions must be plainly marked as such, and must not be
     misrepresented as being the original software.
  3. This notice may not be removed or altered from any source distribution.
*/

library buffer_usage_test;

import 'dart:web_gl' as WebGL;

import 'package:unittest/unittest.dart';
import 'package:lithium_ion/graphics.dart';

var throwsAssertionError = throwsA(new isInstanceOf<AssertionError>());

void main() {
  test('values', () {
    expect(BufferUsage.Static , WebGL.STATIC_DRAW);
    expect(BufferUsage.Dynamic, WebGL.DYNAMIC_DRAW);
  });

  test('stringify', () {
    expect(BufferUsage.stringify(BufferUsage.Static) , 'Static');
    expect(BufferUsage.stringify(BufferUsage.Dynamic), 'Dynamic');

    expect(() { BufferUsage.stringify(-1); }, throwsAssertionError);
  });

  test('parse', () {
    expect(BufferUsage.parse('Static') , BufferUsage.Static);
    expect(BufferUsage.parse('Dynamic'), BufferUsage.Dynamic);

    expect(() { BufferUsage.parse('NotValid'); }, throwsAssertionError);
  });

  test('isValid', () {
    expect(BufferUsage.isValid(BufferUsage.Static) , true);
    expect(BufferUsage.isValid(BufferUsage.Dynamic), true);

    expect(BufferUsage.isValid(-1), false);
  });
}
