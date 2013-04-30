// Copyright (c) 2013, the Lihtium-Ion Engine Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

library strided_list_test_helper;

import 'dart:typed_data';

Float32List createSequentialList(int count) {
  var list = new Float32List(count);

  for (int i = 0; i < count; ++i) {
    list[i] = i.toDouble();
  }

  return list;
}
