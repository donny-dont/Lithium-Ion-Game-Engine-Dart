// Copyright (c) 2012, the Lihtium-Ion Engine project authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

part of lithium_graphics;

class EffectTechnique {
  //---------------------------------------------------------------------
  // Member variables
  //---------------------------------------------------------------------

  /// The name of the technique.
  String _name;
  /// The individual [EffectPass]es required for the technique.
  List<EffectPass> _passes;
  /// An immutable view over the passes.
  ///
  /// Used to prevent the list of [EffectPass]es from being modified by the
  /// application.
  UnmodifiableListView<EffectPass> _passView;

  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  EffectTechnique._internal(String name, List<EffectPass> passes)
      : _name = name
      , _passes = passes
  {
    _passView = new UnmodifiableListView<EffectPass>(_passes);
  }

  //---------------------------------------------------------------------
  // Properties
  //---------------------------------------------------------------------

  /// The name of the technique.
  String get name => _name;

  /// The individual [EffectPass]es required for the technique.
  UnmodifiableListView<EffectPass> get passes => _passView;
}
