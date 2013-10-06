// Copyright (c) 2012, the Lihtium-Ion Engine project authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

part of lithium_graphics;

/// Allows the programmatic creation of [Effect]s.
///
/// [Effect]s
class EffectBuilder {
  //---------------------------------------------------------------------
  // Member variables
  //---------------------------------------------------------------------

  GraphicsDevice _device;

  Map<String, List> _techniques = new Map<String, List>();

  Map<String, WebGL.Shader> _vertexShaders = new Map<String, WebGL.Shader>();
  Map<String, WebGL.Shader> _pixelShaders = new Map<String, WebGL.Shader>();

  SemanticMap _semanticMap;

  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  EffectBuilder(GraphicsDevice device)
      : _device = device;


  //---------------------------------------------------------------------
  // Properties
  //---------------------------------------------------------------------

  /// The [SemanticMap] to use for vertex attributes within the [Effect].
  ///
  ///
  SemanticMap get semanticMap => _semanticMap;
  set semanticMap(SemanticMap value) { _semanticMap = value; }

  //---------------------------------------------------------------------
  // EffectPass methods
  //---------------------------------------------------------------------

  bool addEffectPass(String techniqueName, String vertexShader, String pixelShader) {
    // Create the technique if necessary
    var technique = _techniques.putIfAbsent(techniqueName, () => []);

    // Get the shaders
    var vertex = _vertexShaders[vertexShader];
    var pixel = _pixelShaders[pixelShader];

    assert(vertex != null);
    assert(pixel != null);

    // Create the effect pass
    var pass = _device._createProgram(vertex, pixel);

    if (pass == null) {
      return false;
    }

    technique.add(pass);

    return true;
  }

  //---------------------------------------------------------------------
  // Shader methods
  //---------------------------------------------------------------------

  /// Adds a vertex shader to use in the creation of the [Effect].
  ///
  ///
  bool addVertexShader(String name, String source) {
    return _addShader(name, source, WebGL.VERTEX_SHADER, _vertexShaders);
  }

  /// Adds a pixel shader to use in the creation of the [Effect].
  bool addPixelShader(String name, String source) {
    return _addShader(name, source, WebGL.FRAGMENT_SHADER, _pixelShaders);
  }

  bool _addShader(String name, String source, int type, Map shaders) {
    var shader = _device._createShader(type, source);

    if (shader == null) {
      return false;
    }

    shaders[name] = shader;

    return true;
  }

  //---------------------------------------------------------------------
  // Creation methods
  //---------------------------------------------------------------------

  /// Creates the [Effect].
  ///
  /// After the [Effect] has been created the [EffectBuilder] will be
  /// initialized back to its original state. All techniques and passes will
  /// be removed, and any resources will be cleaned up. [Effect]s should be
  /// shared rather than creating multiple instances of the same [Effect].
  /// This behavior is meant to encourage that.
  Effect create() {
    var semanticMap = (_semanticMap != null) ? _semanticMap : SemanticMap.defaultAttributes;

    // Determine the required parameters
    _techniques.forEach((_, passes) {
      var passCount = passes.length;

      for (var i = 0; i < passCount; ++i) {
        var program = passes[i];

        // Setup the attributes
        _device._applySemanticMap(program);

        _device._getUniforms(program);
      }
    });

    // Create the techniques
    var effectTechniques = new Map<String, EffectTechnique>();

    _techniques.forEach((name, passes) {
      var passCount = passes.length;
      var effectPasses = new List<EffectPass>(passCount);

      for (var i = 0; i < passCount; ++i) {
        var program = passes[i];

        effectPasses[i] = new EffectPass._internal(program);
      }

      // Create the technique
      var effectTechnique = new EffectTechnique._internal(name, effectPasses);

      effectTechniques[name] = effectTechnique;
    });

    var effect = new Effect._internal(_device, effectTechniques);

    // Cleanup the shaders as they are no longer needed
    _deleteShaders(_vertexShaders);
    _deleteShaders(_pixelShaders);

    return effect;
  }

  void _deleteShaders(Map<String, WebGL.Shader> shaders) {
    // Delete each individual shader
    shaders.forEach((_, shader) {
      _device._deleteShader(shader);
    });

    // Clear the contents
    shaders.clear();
  }
}
