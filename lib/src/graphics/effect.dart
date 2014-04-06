// Copyright (c) 2013-2014, the Lithium-Ion Engine project authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

part of lithium_graphics;

class Effect extends GraphicsResource {
  //---------------------------------------------------------------------
  // Member variables
  //---------------------------------------------------------------------

  /// The [EffectParameter]s that are used with this effect.
  EffectParameterBlock _parameters;
  /// The [EffectTechnique]s that are defined for this effect.
  Map<String, EffectTechnique> _techniques;

  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  Effect._internal(GraphicsDevice device, Map<String, EffectTechnique> techniques)
      : _techniques = techniques
      , super._internal(device)
  {
    _graphicsDevice._createEffect(this);
  }

  //---------------------------------------------------------------------
  // Properties
  //---------------------------------------------------------------------

  /// The [EffectParameter]s that are used with this effect.
  EffectParameterBlock get parameters => _parameters;

  /// The [EffectTechnique]s that are defined for this effect.
  Map<String, EffectTechnique> get techniques => _techniques;
}
