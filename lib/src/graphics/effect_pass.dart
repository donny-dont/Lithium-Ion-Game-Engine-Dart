// Copyright (c) 2013-2014, the Lithium-Ion Engine project authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

part of lithium_graphics;

class EffectPass {
  //---------------------------------------------------------------------
  // Member variables
  //---------------------------------------------------------------------

  /// The binding to [WebGL].
  WebGL.Program _binding;
  /// The [Effect] associated with the [EffectPass].
  Effect _effect;
  /// The uniforms associated with the [EffectPass].
  List<_EffectParameter> _uniforms = new List<_EffectParameter>();
  /// The samplers associated with the [EffectPass].
  List<_EffectParameterSampler> _samplers = new List<_EffectParameterSampler>();

  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  /// Creates an instance of the [EffectPass] class from the given sources.
  ///
  ///
  EffectPass._internal(WebGL.Program binding)
      : _binding = binding;
}
