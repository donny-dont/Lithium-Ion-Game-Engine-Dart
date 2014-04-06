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
  int _target;
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

  /// Immediately releases the unmanaged resources used by this object.
  void dispose() {
    _samplerState.dispose();
    _graphicsDevice._destroyTexture(this);
  }

  //---------------------------------------------------------------------
  // Internal methods
  //---------------------------------------------------------------------

  /// Sets the initial state for the [Texture].
  void _initializeState() {
    var gl = _graphicsDevice._gl;

    // Set the parameters otherwise the texture object cannot be rendered
    gl.texParameteri(
        _target,
        WebGL.TEXTURE_WRAP_S,
        _textureAddressModeToWebGL(_samplerState.addressU)
    );

    gl.texParameteri(
        _target,
        WebGL.TEXTURE_WRAP_T,
        _textureAddressModeToWebGL(_samplerState.addressV)
    );

    var filter = _samplerState.filter;

    gl.texParameteri(
        _target,
        WebGL.TEXTURE_MIN_FILTER,
        _textureFilterMinToWebGL(filter)
    );

    gl.texParameteri(
        _target,
        WebGL.TEXTURE_MAG_FILTER,
        _textureFilterMagToWebGL(filter)
    );
  }

  /// Applies the [SamplerState] to the [Texture].
  ///
  /// WebGL does not have the concept of a [SamplerState] that you can just
  /// apply to the pipeline. Instead the state is attached to the underlying
  /// texture object. So to get ensure redudant state changes are not occurring
  /// checks are made within [Texture] rather than [GraphicsContext].
  void _applySampler(SamplerState value) {
    var gl = _graphicsDevice._gl;

    // Modify the texture wrapping if necessary
    var addressU = value.addressU;

    if (addressU != _samplerState.addressU) {
      gl.texParameteri(
          _target,
          WebGL.TEXTURE_WRAP_S,
          _textureAddressModeToWebGL(addressU)
      );

      debug('Address mode changed in the U direction', 'lithium_graphics.Texture');
      _samplerState.addressU = addressU;
    }

    var addressV = value.addressV;

    if (addressV != _samplerState.addressV) {
      gl.texParameteri(
          _target,
          WebGL.TEXTURE_WRAP_T,
          _textureAddressModeToWebGL(addressV)
       );

      debug('Address mode changed in the V direction', 'lithium_graphics.Texture');
      _samplerState.addressV = addressV;
    }

    // Modify the filtering
    var filter = value.filter,
        currentFilter = _samplerState.filter,
        isAnisotropic = filter == TextureFilter.Anisotropic;

    if ((filter != currentFilter) && (!isAnisotropic)) {
      // Turn off Anisotropic filtering
      if (currentFilter == TextureFilter.Anisotropic) {
        gl.texParameterf(
            _target,
            WebGL.ExtTextureFilterAnisotropic.TEXTURE_MAX_ANISOTROPY_EXT,
            1.0
        );

        debug('Anisotropy turned off', 'lithium_graphics.Texture');
        _samplerState.maxAnisotropy = 1.0;
      }

      // Set the minification filter
      var minFilter = _textureFilterMinToWebGL(filter),
          currentMinFilter = _textureFilterMinToWebGL(currentFilter);

      if (minFilter != currentMinFilter) {
        debug('Minification filter changed', 'lithium_graphics.Texture');
        gl.texParameteri(_target, WebGL.TEXTURE_MIN_FILTER, minFilter);
      }

      // Set the magnification filter
      var magFilter = _textureFilterMagToWebGL(filter),
          currentMagFilter = _textureFilterMagToWebGL(filter);

      if (magFilter != currentMagFilter) {
        debug('Magnification filter changed', 'lithium_graphics.Texture');
        gl.texParameteri(_target, WebGL.TEXTURE_MAG_FILTER, magFilter);
      }

      _samplerState.filter = filter;
    }

    if (isAnisotropic) {
      var maxAnisotropy = value.maxAnisotropy;

      if (maxAnisotropy != _samplerState.maxAnisotropy) {
        gl.texParameterf(
            _target,
            WebGL.ExtTextureFilterAnisotropic.TEXTURE_MAX_ANISOTROPY_EXT,
            1.0
        );

        debug('Max anisotropy changed to $maxAnisotropy', 'lithium_graphics.Texture');
        _samplerState.maxAnisotropy = maxAnisotropy;
      }
    }
  }
}
