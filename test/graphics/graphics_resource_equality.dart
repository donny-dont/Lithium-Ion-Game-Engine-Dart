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
