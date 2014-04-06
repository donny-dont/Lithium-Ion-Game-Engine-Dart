// Copyright (c) 2013-2014, the Lithium-Ion Engine project authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

library graphics_resource_equality;

import 'package:lithium_ion/graphics.dart';

/// Compares two [Viewport]s for equality.
bool viewportEqual(Viewport viewport0, Viewport viewport1) {
  if (identical(viewport0, viewport1)) {
    return true;
  }

  if ((viewport0.x != viewport1.x) || (viewport0.y != viewport1.y)) {
    return false;
  }

  if ((viewport0.width != viewport1.width) || (viewport0.height != viewport1.height)) {
    return false;
  }

  return ((viewport0.minDepth == viewport1.minDepth) && (viewport0.maxDepth == viewport1.maxDepth));
}
