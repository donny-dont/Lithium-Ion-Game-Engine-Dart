// Copyright (c) 2013-2014, the Lithium-Ion Engine project authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

part of lithium_content;

class TextureManager {
  GraphicsDevice _graphicsDevice;

  TextureManager(GraphicsDevice graphicsDevice)
      : _graphicsDevice = graphicsDevice;

  Future<Texture> loadTexture(String path) {
    var image = new Html.ImageElement();
    var completer = new Completer<Texture>();

    image.onLoad.listen((_) {
      var texture = new Texture2D(_graphicsDevice);

      texture.setElement(image);

      completer.complete(texture);
    });

    image.src = path;

    return completer.future;
  }
}
