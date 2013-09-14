// Copyright (c) 2013, the Lihtium-Ion Engine Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

part of lithium_graphics;

/// Contains sampler state, which determines how to sample texture data.
class SamplerState extends GraphicsResource {
  //---------------------------------------------------------------------
  // Member variables
  //---------------------------------------------------------------------

  /// The texture-address mode for the u-coordinate.
  TextureAddressMode _addressU = TextureAddressMode.Wrap;
  /// The texture-address mode for the v-coordinate.
  TextureAddressMode _addressV = TextureAddressMode.Wrap;
  /// The type of filtering to use during sampling.
  TextureFilter _filter = TextureFilter.Linear;
  /// The maximum anisotropy.
  ///
  /// The default value is 1.0.
  double _maxAnisotropy = 1.0;

  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  /// Creates an instance of [SamplerState] with default values.
  SamplerState(GraphicsDevice device)
    : super._internalWithoutBinding(device);

  /// Initializes an instance of [SamplerState] with anisotropic filtering and texture coordinate clamping.
  ///
  /// The state object has the following settings.
  ///     addressU = TextureAddressMode.Clamp;
  ///     addressV = TextureAddressMode.Clamp;
  ///     filter = TextureFilter.Anisotropic
  ///     maxAnisotropy = 4;
  SamplerState.anisotropicClamp(GraphicsDevice device)
    : super._internalWithoutBinding(device)
    , _addressU = TextureAddressMode.Clamp
    , _addressV = TextureAddressMode.Clamp
    , _filter = TextureFilter.Anisotropic;

  /// Initializes an instance of [SamplerState] with anisotropic filtering and texture coordinate wrapping.
  ///
  /// The state object has the following settings.
  ///     addressU = TextureAddressMode.Wrap;
  ///     addressV = TextureAddressMode.Wrap;
  ///     filter = TextureFilter.Anisotropic;
  ///     maxAnisotropy = 4;
  SamplerState.anisotropicWrap(GraphicsDevice device)
    : super._internalWithoutBinding(device)
    , _addressU = TextureAddressMode.Wrap
    , _addressV = TextureAddressMode.Wrap
    , _filter = TextureFilter.Anisotropic;

  /// Initializes an instance of [SamplerState] with linear filtering and texture coordinate clamping.
  ///
  /// The state object has the following settings.
  ///     addressU = TextureAddressMode.Clamp;
  ///     addressV = TextureAddressMode.Clamp;
  ///     filter = TextureFilter.Linear;
  SamplerState.linearClamp(GraphicsDevice device)
    : super._internal(device)
    , _addressU = TextureAddressMode.Clamp
    , _addressV = TextureAddressMode.Clamp
    , _filter = TextureFilter.Linear;

  /// Initializes an instance of [SamplerState] with linear filtering and texture coordinate wrapping.
  ///
  /// The state object has the following settings.
  ///     addressU = TextureAddressMode.Wrap;
  ///     addressV = TextureAddressMode.Wrap;
  ///     filter = TextureFilter.Linear;
  SamplerState.linearWrap(GraphicsDevice device)
    : super._internalWithoutBinding(device)
    , _addressU = TextureAddressMode.Wrap
    , _addressV = TextureAddressMode.Wrap
    , _filter = TextureFilter.Linear;

  /// Initializes an instance of [SamplerState] with point filtering and texture coordinate clamping.
  ///
  /// The state object has the following settings.
  ///     addressU = TextureAddressMode.Clamp;
  ///     addressV = TextureAddressMode.Clamp;
  ///     minFilter = TextureMinFilter.Point;
  ///     magFilter = TextureMagFilter.Point;
  SamplerState.pointClamp(GraphicsDevice device)
    : super._internalWithoutBinding(device)
    , _addressU = TextureAddressMode.Clamp
    , _addressV = TextureAddressMode.Clamp
    , _filter = TextureFilter.Point;

  /// Initializes an instance of [SamplerState] with point filtering and texture coordinate wrapping.
  ///
  /// The state object has the following settings.
  ///     addressU = TextureAddressMode.Wrap;
  ///     addressV = TextureAddressMode.Wrap;
  ///     minFilter = TextureMinFilter.Point;
  ///     magFilter = TextureMagFilter.Point;
  SamplerState.pointWrap(GraphicsDevice device)
    : super._internalWithoutBinding(device)
    , _addressU = TextureAddressMode.Wrap
    , _addressV = TextureAddressMode.Wrap
    , _filter = TextureFilter.Point;

  //---------------------------------------------------------------------
  // Properties
  //---------------------------------------------------------------------

  /// The texture-address mode for the u-coordinate.
  TextureAddressMode get addressU => _addressU;
  set addressU(TextureAddressMode value) { _addressU = value; }

  /// The texture-address mode for the v-coordinate.
  TextureAddressMode get addressV => _addressV;
  set addressV(TextureAddressMode value) { _addressV = value; }

  /// The type of filtering to use during sampling.
  TextureFilter get filter => _filter;
  set filter(TextureFilter value) { _filter = value; }

  /// The maximum anisotropy.
  ///
  /// Anisotropic filtering is only available through an extension to WebGL.
  /// The maximum acceptable value is dependent on the graphics hardware, and
  /// can be queried within [GraphicsDeviceCapabilites]. When setting the value
  /// the anisotropy level will be capped to the range 1 <
  /// [GraphicsDeviceCapabilities.maxAnisotropyLevel]
  ///
  /// Asserts [value] is a positive number greater than or equal to 1.
  double get maxAnisotropy => _maxAnisotropy;
  set maxAnisotropy(double value) {
    assert(value >= 1.0);

    _maxAnisotropy = Math.min(value, _graphicsDevice.capabilities.maxAnisotropyLevel);
  }
}
