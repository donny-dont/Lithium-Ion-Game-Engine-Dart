// Copyright (c) 2013-2014, the Lithium-Ion Engine project authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

part of lithium_graphics;

class Texture2D extends Texture {
  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  Texture2D(GraphicsDevice device)
      : super._internal(device, WebGL.TEXTURE_2D);

  void setElement(Html.HtmlElement element) {
    assert(element is Html.ImageElement || element is Html.CanvasElement || element is Html.VideoElement);

    _graphicsDevice._setElementTexture2D(this, element);
  }
}
