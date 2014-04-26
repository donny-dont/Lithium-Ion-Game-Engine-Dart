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

  Future<Texture> loadCubemap(String negativeXPath,
                              String negativeYPath,
                              String negativeZPath,
                              String positiveXPath,
                              String positiveYPath,
                              String positiveZPath)
  {
    var imagePaths = [
        negativeXPath,
        negativeYPath,
        negativeZPath,
        positiveXPath,
        positiveYPath,
        positiveZPath
    ];

    var texture = new TextureCube(_graphicsDevice);
    var loaded = 0;
    var completer = new Completer<Texture>();

    for (var i = 0; i < 6; ++i) {
      var image = new Html.ImageElement();

      image.onLoad.listen((_) {
        texture.setElement(CubeMapFace.values[i], image);

        ++loaded;

        if (loaded == 6) {
          completer.complete(texture);
        }
      });

      image.src = imagePaths[i];
    }

    return completer.future;
  }
}
