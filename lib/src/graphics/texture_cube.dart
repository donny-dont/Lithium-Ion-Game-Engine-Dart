// Copyright (c) 2012, the Lihtium-Ion Engine project authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

part of lithium_graphics;

class TextureCube extends Texture {
  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  TextureCube(GraphicsDevice device)
      : super._internal(device, WebGL.TEXTURE_CUBE_MAP)
  {

  }
}