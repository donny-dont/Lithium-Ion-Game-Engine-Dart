// Copyright (c) 2013, the Lihtium-Ion Engine Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

part of lithium_graphics;

/// Defines how vertex data is ordered.
class PrimitiveType {
  //---------------------------------------------------------------------
  // Serialization names
  //---------------------------------------------------------------------

  /// String representation of [PointList].
  static const String _pointListName = 'PointList';
  /// String representation of [LineList].
  static const String _lineListName = 'LineList';
  /// String representation of [LineStrip].
  static const String _lineStripName = 'LineStrip';
  /// String representation of [TriangleList].
  static const String _triangleListName = 'TriangleList';
  /// String representation of [TriangleStrip].
  static const String _triangleStripName = 'TriangleStrip';

  //---------------------------------------------------------------------
  // Enumerations
  //---------------------------------------------------------------------

  /// The data is ordered as a sequence of points.
  static const int PointList = WebGL.POINTS;
  /// The data is ordered as a sequence of line segments; each line segment is described by two new vertices.
  static const int LineList = WebGL.LINES;
  /// The data is ordered as a sequence of line segments; each line segment is described by one new vertex and the last vertex from the previous line seqment.
  static const int LineStrip = WebGL.LINE_STRIP;
  /// The data is ordered as a sequence of triangles; each triangle is described by three new vertices.
  ///
  /// Back-face culling is affected by the current winding-order render state.
  static const int TriangleList = WebGL.TRIANGLES;
  /// The data is ordered as a sequence of triangles; each triangle is described by two new vertices and one vertex from the previous triangle.
  ///
  /// The back-face culling flag is flipped automatically on even-numbered
  /// triangles.
  static const int TriangleStrip = WebGL.TRIANGLE_STRIP;

  //---------------------------------------------------------------------
  // Class methods
  //---------------------------------------------------------------------

  /// Convert from a [String] name to the corresponding [PrimitiveType] enumeration.
  static int parse(String name) {
    switch (name) {
      case _pointListName    : return PointList;
      case _lineListName     : return LineList;
      case _lineStripName    : return LineStrip;
      case _triangleListName : return TriangleList;
      case _triangleStripName: return TriangleStrip;
    }

    assert(false);
    return TriangleList;
  }

  /// Converts the [PrimitiveType] enumeration to a [String].
  static String stringify(int value) {
    switch (value) {
      case PointList    : return _pointListName;
      case LineList     : return _lineListName;
      case LineStrip    : return _lineStripName;
      case TriangleList : return _triangleListName;
      case TriangleStrip: return _triangleStripName;
    }

    assert(false);
    return _triangleListName;
  }

  /// Checks whether the value is a valid enumeration.
  ///
  /// Should be gotten rid of when enums are supported properly.
  static bool isValid(int value) {
    switch (value) {
      case PointList    :
      case LineList     :
      case LineStrip    :
      case TriangleList :
      case TriangleStrip: return true;
    }

    return false;
  }
}
