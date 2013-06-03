// Copyright (c) 2012, the Lihtium-Ion Engine project authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

part of lithium_graphics;

class EffectPass extends GraphicsResource {
  //---------------------------------------------------------------------
  // Member variables
  //---------------------------------------------------------------------

  /// The binding to [WebGL].
  WebGL.Program _binding;
  /// The log from the compiler.
  ///
  /// Contains any compiler errors. If none then the string is empty.
  String _compilerLog = '';
  /// The log from the linker.
  ///
  /// Contains any linker errors. If none then the string is empty.
  String _linkerLog = '';

  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  /// Creates an instance of the [EffectPass] class from the given sources.
  ///
  ///
  EffectPass(GraphicsDevice device, String vertexSource, String fragmentSource)
      : super._internal(device)
  {
    _graphicsDevice._createEffectPass(this, vertexSource, fragmentSource);
  }

  //---------------------------------------------------------------------
  // Properties
  //---------------------------------------------------------------------

  /// Whether the shaders were compiled successfully.
  bool get compiled => _compilerLog.isEmpty;

  /// Whether the effect was linked successfully.
  bool get linked => _linkerLog.isEmpty;

  /// \TODO REMOVE
  WebGL.Program get binding => _binding;

  //---------------------------------------------------------------------
  // Public methods
  //---------------------------------------------------------------------

  /// Associates the attribute [name] with the given semantic.
  void setSemantic(String name, int usage, int usageIndex, [SemanticMap semanticMap]) {
    assert(VertexElementUsage.isValid(usage));

    if (semanticMap == null) {
      semanticMap = SemanticMap.defaultMapping;
    }

    _graphicsDevice._setSemantic(this, name, usage, usageIndex, semanticMap);
  }

  /// Links the [EffectPass].
  ///
  /// After calls to [setSemantic] this method must be called before the
  /// changes will be reflected.
  void link() {
    _graphicsDevice._linkProgram(this);
  }
}
