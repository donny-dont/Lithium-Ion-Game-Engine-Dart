// Copyright (c) 2013-2014, the Lithium-Ion Engine project authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

part of lithium_graphics;

class Texture extends GraphicsResource {
  //---------------------------------------------------------------------
  // Member variables
  //---------------------------------------------------------------------

  /// The binding to [WebGL].
  WebGL.Texture _binding;
  /// The target type for the [Texture] in [WebGL].
  final int _target;
  /// The current [SamplerState] attached to the [Texture].
  ///
  /// Constructed with the values in [SamplerState.linearWrap].
  SamplerState _samplerState;

  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  /// Creates an instance of the [Texture] class.
  Texture._internal(GraphicsDevice device, int target)
      : _target = target
      , super._internal(device)
  {
    _samplerState = new SamplerState.linearWrap(device);
    _graphicsDevice._createTexture(this);
  }

  //---------------------------------------------------------------------
  // Public methods
  //---------------------------------------------------------------------

  @override
  void dispose() {
    _samplerState.dispose();
    _graphicsDevice._destroyTexture(this);
  }
}
