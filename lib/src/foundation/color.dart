// Copyright (c) 2013, the Lihtium-Ion Engine Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

part of lithium_foundation;

/// Helper for creating an RGBA color.
///
/// The standard colors correspond to values within the .NET framework.
class Color {
  //---------------------------------------------------------------------
  // Standard colors
  //---------------------------------------------------------------------

  /// A system-defined color with the following value RGBA(240, 248, 255, 255).
  static Vector4 get aliceBlue => new Vector4(0.9411764705882353, 0.9725490196078431, 1.0, 1.0);

  /// A system-defined color with the following value RGBA(250, 235, 215, 255).
  static Vector4 get antiqueWhite => new Vector4(0.9803921568627451, 0.9215686274509803, 0.8431372549019608, 1.0);

  /// A system-defined color with the following value RGBA(0, 255, 255, 255).
  static Vector4 get aqua => new Vector4(0.0, 1.0, 1.0, 1.0);

  /// A system-defined color with the following value RGBA(127, 255, 212, 255).
  static Vector4 get aquamarine => new Vector4(0.4980392156862745, 1.0, 0.8313725490196079, 1.0);

  /// A system-defined color with the following value RGBA(240, 255, 255, 255).
  static Vector4 get azure => new Vector4(0.9411764705882353, 1.0, 1.0, 1.0);

  /// A system-defined color with the following value RGBA(245, 245, 220, 255).
  static Vector4 get beige => new Vector4(0.9607843137254902, 0.9607843137254902, 0.8627450980392157, 1.0);

  /// A system-defined color with the following value RGBA(255, 228, 196, 255).
  static Vector4 get bisque => new Vector4(1.0, 0.8941176470588236, 0.7686274509803922, 1.0);

  /// A system-defined color with the following value RGBA(0, 0, 0, 255).
  static Vector4 get black => new Vector4(0.0, 0.0, 0.0, 1.0);

  /// A system-defined color with the following value RGBA(255, 235, 205, 255).
  static Vector4 get blanchedAlmond => new Vector4(1.0, 0.9215686274509803, 0.803921568627451, 1.0);

  /// A system-defined color with the following value RGBA(0, 0, 255, 255).
  static Vector4 get blue => new Vector4(0.0, 0.0, 1.0, 1.0);

  /// A system-defined color with the following value RGBA(138, 43, 226, 255).
  static Vector4 get blueViolet => new Vector4(0.5411764705882353, 0.16862745098039217, 0.8862745098039215, 1.0);

  /// A system-defined color with the following value RGBA(165, 42, 42, 255).
  static Vector4 get brown => new Vector4(0.6470588235294118, 0.16470588235294117, 0.16470588235294117, 1.0);

  /// A system-defined color with the following value RGBA(222, 184, 135, 255).
  static Vector4 get burlyWood => new Vector4(0.8705882352941177, 0.7215686274509804, 0.5294117647058824, 1.0);

  /// A system-defined color with the following value RGBA(95, 158, 160, 255).
  static Vector4 get cadetBlue => new Vector4(0.37254901960784315, 0.6196078431372549, 0.6274509803921569, 1.0);

  /// A system-defined color with the following value RGBA(127, 255, 0, 255).
  static Vector4 get chartreuse => new Vector4(0.4980392156862745, 1.0, 0.0, 1.0);

  /// A system-defined color with the following value RGBA(210, 105, 30, 255).
  static Vector4 get chocolate => new Vector4(0.8235294117647058, 0.4117647058823529, 0.11764705882352941, 1.0);

  /// A system-defined color with the following value RGBA(255, 127, 80, 255).
  static Vector4 get coral => new Vector4(1.0, 0.4980392156862745, 0.3137254901960784, 1.0);

  /// A system-defined color with the following value RGBA(100, 149, 237, 255).
  static Vector4 get cornflowerBlue => new Vector4(0.39215686274509803, 0.5843137254901961, 0.9294117647058824, 1.0);

  /// A system-defined color with the following value RGBA(255, 248, 220, 255).
  static Vector4 get cornsilk => new Vector4(1.0, 0.9725490196078431, 0.8627450980392157, 1.0);

  /// A system-defined color with the following value RGBA(220, 20, 60, 255).
  static Vector4 get crimson => new Vector4(0.8627450980392157, 0.0784313725490196, 0.23529411764705882, 1.0);

  /// A system-defined color with the following value RGBA(0, 255, 255, 255).
  static Vector4 get cyan => new Vector4(0.0, 1.0, 1.0, 1.0);

  /// A system-defined color with the following value RGBA(0, 0, 139, 255).
  static Vector4 get darkBlue => new Vector4(0.0, 0.0, 0.5450980392156862, 1.0);

  /// A system-defined color with the following value RGBA(0, 139, 139, 255).
  static Vector4 get darkCyan => new Vector4(0.0, 0.5450980392156862, 0.5450980392156862, 1.0);

  /// A system-defined color with the following value RGBA(184, 134, 11, 255).
  static Vector4 get darkGoldenrod => new Vector4(0.7215686274509804, 0.5254901960784314, 0.043137254901960784, 1.0);

  /// A system-defined color with the following value RGBA(169, 169, 169, 255).
  static Vector4 get darkGray => new Vector4(0.6627450980392157, 0.6627450980392157, 0.6627450980392157, 1.0);

  /// A system-defined color with the following value RGBA(0, 100, 0, 255).
  static Vector4 get darkGreen => new Vector4(0.0, 0.39215686274509803, 0.0, 1.0);

  /// A system-defined color with the following value RGBA(189, 183, 107, 255).
  static Vector4 get darkKhaki => new Vector4(0.7411764705882353, 0.7176470588235294, 0.4196078431372549, 1.0);

  /// A system-defined color with the following value RGBA(139, 0, 139, 255).
  static Vector4 get darkMagenta => new Vector4(0.5450980392156862, 0.0, 0.5450980392156862, 1.0);

  /// A system-defined color with the following value RGBA(85, 107, 47, 255).
  static Vector4 get darkOliveGreen => new Vector4(0.3333333333333333, 0.4196078431372549, 0.1843137254901961, 1.0);

  /// A system-defined color with the following value RGBA(255, 140, 0, 255).
  static Vector4 get darkOrange => new Vector4(1.0, 0.5490196078431373, 0.0, 1.0);

  /// A system-defined color with the following value RGBA(153, 50, 204, 255).
  static Vector4 get darkOrchid => new Vector4(0.6, 0.19607843137254902, 0.8, 1.0);

  /// A system-defined color with the following value RGBA(139, 0, 0, 255).
  static Vector4 get darkRed => new Vector4(0.5450980392156862, 0.0, 0.0, 1.0);

  /// A system-defined color with the following value RGBA(233, 150, 122, 255).
  static Vector4 get darkSalmon => new Vector4(0.9137254901960784, 0.5882352941176471, 0.47843137254901963, 1.0);

  /// A system-defined color with the following value RGBA(143, 188, 143, 255).
  static Vector4 get darkSeaGreen => new Vector4(0.5607843137254902, 0.7372549019607844, 0.5607843137254902, 1.0);

  /// A system-defined color with the following value RGBA(72, 61, 139, 255).
  static Vector4 get darkSlateBlue => new Vector4(0.2823529411764706, 0.23921568627450981, 0.5450980392156862, 1.0);

  /// A system-defined color with the following value RGBA(47, 79, 79, 255).
  static Vector4 get darkSlateGray => new Vector4(0.1843137254901961, 0.30980392156862746, 0.30980392156862746, 1.0);

  /// A system-defined color with the following value RGBA(0, 206, 209, 255).
  static Vector4 get darkTurquoise => new Vector4(0.0, 0.807843137254902, 0.8196078431372549, 1.0);

  /// A system-defined color with the following value RGBA(148, 0, 211, 255).
  static Vector4 get darkViolet => new Vector4(0.5803921568627451, 0.0, 0.8274509803921568, 1.0);

  /// A system-defined color with the following value RGBA(255, 20, 147, 255).
  static Vector4 get deepPink => new Vector4(1.0, 0.0784313725490196, 0.5764705882352941, 1.0);

  /// A system-defined color with the following value RGBA(0, 191, 255, 255).
  static Vector4 get deepSkyBlue => new Vector4(0.0, 0.7490196078431373, 1.0, 1.0);

  /// A system-defined color with the following value RGBA(105, 105, 105, 255).
  static Vector4 get dimGray => new Vector4(0.4117647058823529, 0.4117647058823529, 0.4117647058823529, 1.0);

  /// A system-defined color with the following value RGBA(30, 144, 255, 255).
  static Vector4 get dodgerBlue => new Vector4(0.11764705882352941, 0.5647058823529412, 1.0, 1.0);

  /// A system-defined color with the following value RGBA(178, 34, 34, 255).
  static Vector4 get firebrick => new Vector4(0.6980392156862745, 0.13333333333333333, 0.13333333333333333, 1.0);

  /// A system-defined color with the following value RGBA(255, 250, 240, 255).
  static Vector4 get floralWhite => new Vector4(1.0, 0.9803921568627451, 0.9411764705882353, 1.0);

  /// A system-defined color with the following value RGBA(34, 139, 34, 255).
  static Vector4 get forestGreen => new Vector4(0.13333333333333333, 0.5450980392156862, 0.13333333333333333, 1.0);

  /// A system-defined color with the following value RGBA(255, 0, 255, 255).
  static Vector4 get fuchsia => new Vector4(1.0, 0.0, 1.0, 1.0);

  /// A system-defined color with the following value RGBA(220, 220, 220, 255).
  static Vector4 get gainsboro => new Vector4(0.8627450980392157, 0.8627450980392157, 0.8627450980392157, 1.0);

  /// A system-defined color with the following value RGBA(248, 248, 255, 255).
  static Vector4 get ghostWhite => new Vector4(0.9725490196078431, 0.9725490196078431, 1.0, 1.0);

  /// A system-defined color with the following value RGBA(255, 215, 0, 255).
  static Vector4 get gold => new Vector4(1.0, 0.8431372549019608, 0.0, 1.0);

  /// A system-defined color with the following value RGBA(218, 165, 32, 255).
  static Vector4 get goldenrod => new Vector4(0.8549019607843137, 0.6470588235294118, 0.12549019607843137, 1.0);

  /// A system-defined color with the following value RGBA(128, 128, 128, 255).
  static Vector4 get gray => new Vector4(0.5019607843137255, 0.5019607843137255, 0.5019607843137255, 1.0);

  /// A system-defined color with the following value RGBA(0, 128, 0, 255).
  static Vector4 get green => new Vector4(0.0, 0.5019607843137255, 0.0, 1.0);

  /// A system-defined color with the following value RGBA(173, 255, 47, 255).
  static Vector4 get greenYellow => new Vector4(0.6784313725490196, 1.0, 0.1843137254901961, 1.0);

  /// A system-defined color with the following value RGBA(240, 255, 240, 255).
  static Vector4 get honeydew => new Vector4(0.9411764705882353, 1.0, 0.9411764705882353, 1.0);

  /// A system-defined color with the following value RGBA(255, 105, 180, 255).
  static Vector4 get hotPink => new Vector4(1.0, 0.4117647058823529, 0.7058823529411765, 1.0);

  /// A system-defined color with the following value RGBA(205, 92, 92, 255).
  static Vector4 get indianRed => new Vector4(0.803921568627451, 0.3607843137254902, 0.3607843137254902, 1.0);

  /// A system-defined color with the following value RGBA(75, 0, 130, 255).
  static Vector4 get indigo => new Vector4(0.29411764705882354, 0.0, 0.5098039215686274, 1.0);

  /// A system-defined color with the following value RGBA(255, 255, 240, 255).
  static Vector4 get ivory => new Vector4(1.0, 1.0, 0.9411764705882353, 1.0);

  /// A system-defined color with the following value RGBA(240, 230, 140, 255).
  static Vector4 get khaki => new Vector4(0.9411764705882353, 0.9019607843137255, 0.5490196078431373, 1.0);

  /// A system-defined color with the following value RGBA(230, 230, 250, 255).
  static Vector4 get lavender => new Vector4(0.9019607843137255, 0.9019607843137255, 0.9803921568627451, 1.0);

  /// A system-defined color with the following value RGBA(255, 240, 245, 255).
  static Vector4 get lavenderBlush => new Vector4(1.0, 0.9411764705882353, 0.9607843137254902, 1.0);

  /// A system-defined color with the following value RGBA(124, 252, 0, 255).
  static Vector4 get lawnGreen => new Vector4(0.48627450980392156, 0.9882352941176471, 0.0, 1.0);

  /// A system-defined color with the following value RGBA(255, 250, 205, 255).
  static Vector4 get lemonChiffon => new Vector4(1.0, 0.9803921568627451, 0.803921568627451, 1.0);

  /// A system-defined color with the following value RGBA(173, 216, 230, 255).
  static Vector4 get lightBlue => new Vector4(0.6784313725490196, 0.8470588235294118, 0.9019607843137255, 1.0);

  /// A system-defined color with the following value RGBA(240, 128, 128, 255).
  static Vector4 get lightCoral => new Vector4(0.9411764705882353, 0.5019607843137255, 0.5019607843137255, 1.0);

  /// A system-defined color with the following value RGBA(224, 255, 255, 255).
  static Vector4 get lightCyan => new Vector4(0.8784313725490196, 1.0, 1.0, 1.0);

  /// A system-defined color with the following value RGBA(250, 250, 210, 255).
  static Vector4 get lightGoldenrodYellow => new Vector4(0.9803921568627451, 0.9803921568627451, 0.8235294117647058, 1.0);

  /// A system-defined color with the following value RGBA(211, 211, 211, 255).
  static Vector4 get lightGray => new Vector4(0.8274509803921568, 0.8274509803921568, 0.8274509803921568, 1.0);

  /// A system-defined color with the following value RGBA(144, 238, 144, 255).
  static Vector4 get lightGreen => new Vector4(0.5647058823529412, 0.9333333333333333, 0.5647058823529412, 1.0);

  /// A system-defined color with the following value RGBA(255, 182, 193, 255).
  static Vector4 get lightPink => new Vector4(1.0, 0.7137254901960784, 0.7568627450980392, 1.0);

  /// A system-defined color with the following value RGBA(255, 160, 122, 255).
  static Vector4 get lightSalmon => new Vector4(1.0, 0.6274509803921569, 0.47843137254901963, 1.0);

  /// A system-defined color with the following value RGBA(32, 178, 170, 255).
  static Vector4 get lightSeaGreen => new Vector4(0.12549019607843137, 0.6980392156862745, 0.6666666666666666, 1.0);

  /// A system-defined color with the following value RGBA(135, 206, 250, 255).
  static Vector4 get lightSkyBlue => new Vector4(0.5294117647058824, 0.807843137254902, 0.9803921568627451, 1.0);

  /// A system-defined color with the following value RGBA(119, 136, 153, 255).
  static Vector4 get lightSlateGray => new Vector4(0.4666666666666667, 0.5333333333333333, 0.6, 1.0);

  /// A system-defined color with the following value RGBA(176, 196, 222, 255).
  static Vector4 get lightSteelBlue => new Vector4(0.6901960784313725, 0.7686274509803922, 0.8705882352941177, 1.0);

  /// A system-defined color with the following value RGBA(255, 255, 224, 255).
  static Vector4 get lightYellow => new Vector4(1.0, 1.0, 0.8784313725490196, 1.0);

  /// A system-defined color with the following value RGBA(0, 255, 0, 255).
  static Vector4 get lime => new Vector4(0.0, 1.0, 0.0, 1.0);

  /// A system-defined color with the following value RGBA(50, 205, 50, 255).
  static Vector4 get limeGreen => new Vector4(0.19607843137254902, 0.803921568627451, 0.19607843137254902, 1.0);

  /// A system-defined color with the following value RGBA(250, 240, 230, 255).
  static Vector4 get linen => new Vector4(0.9803921568627451, 0.9411764705882353, 0.9019607843137255, 1.0);

  /// A system-defined color with the following value RGBA(255, 0, 255, 255).
  static Vector4 get magenta => new Vector4(1.0, 0.0, 1.0, 1.0);

  /// A system-defined color with the following value RGBA(128, 0, 0, 255).
  static Vector4 get maroon => new Vector4(0.5019607843137255, 0.0, 0.0, 1.0);

  /// A system-defined color with the following value RGBA(102, 205, 170, 255).
  static Vector4 get mediumAquamarine => new Vector4(0.4, 0.803921568627451, 0.6666666666666666, 1.0);

  /// A system-defined color with the following value RGBA(0, 0, 205, 255).
  static Vector4 get mediumBlue => new Vector4(0.0, 0.0, 0.803921568627451, 1.0);

  /// A system-defined color with the following value RGBA(186, 85, 211, 255).
  static Vector4 get mediumOrchid => new Vector4(0.7294117647058823, 0.3333333333333333, 0.8274509803921568, 1.0);

  /// A system-defined color with the following value RGBA(147, 112, 219, 255).
  static Vector4 get mediumPurple => new Vector4(0.5764705882352941, 0.4392156862745098, 0.8588235294117647, 1.0);

  /// A system-defined color with the following value RGBA(60, 179, 113, 255).
  static Vector4 get mediumSeaGreen => new Vector4(0.23529411764705882, 0.7019607843137254, 0.44313725490196076, 1.0);

  /// A system-defined color with the following value RGBA(123, 104, 238, 255).
  static Vector4 get mediumSlateBlue => new Vector4(0.4823529411764706, 0.40784313725490196, 0.9333333333333333, 1.0);

  /// A system-defined color with the following value RGBA(0, 250, 154, 255).
  static Vector4 get mediumSpringGreen => new Vector4(0.0, 0.9803921568627451, 0.6039215686274509, 1.0);

  /// A system-defined color with the following value RGBA(72, 209, 204, 255).
  static Vector4 get mediumTurquoise => new Vector4(0.2823529411764706, 0.8196078431372549, 0.8, 1.0);

  /// A system-defined color with the following value RGBA(199, 21, 133, 255).
  static Vector4 get mediumVioletRed => new Vector4(0.7803921568627451, 0.08235294117647059, 0.5215686274509804, 1.0);

  /// A system-defined color with the following value RGBA(25, 25, 112, 255).
  static Vector4 get midnightBlue => new Vector4(0.09803921568627451, 0.09803921568627451, 0.4392156862745098, 1.0);

  /// A system-defined color with the following value RGBA(245, 255, 250, 255).
  static Vector4 get mintCream => new Vector4(0.9607843137254902, 1.0, 0.9803921568627451, 1.0);

  /// A system-defined color with the following value RGBA(255, 228, 225, 255).
  static Vector4 get mistyRose => new Vector4(1.0, 0.8941176470588236, 0.8823529411764706, 1.0);

  /// A system-defined color with the following value RGBA(255, 228, 181, 255).
  static Vector4 get moccasin => new Vector4(1.0, 0.8941176470588236, 0.7098039215686275, 1.0);

  /// A system-defined color with the following value RGBA(255, 222, 173, 255).
  static Vector4 get navajoWhite => new Vector4(1.0, 0.8705882352941177, 0.6784313725490196, 1.0);

  /// A system-defined color with the following value RGBA(0, 0, 128, 255).
  static Vector4 get navy => new Vector4(0.0, 0.0, 0.5019607843137255, 1.0);

  /// A system-defined color with the following value RGBA(253, 245, 230, 255).
  static Vector4 get oldLace => new Vector4(0.9921568627450981, 0.9607843137254902, 0.9019607843137255, 1.0);

  /// A system-defined color with the following value RGBA(128, 128, 0, 255).
  static Vector4 get olive => new Vector4(0.5019607843137255, 0.5019607843137255, 0.0, 1.0);

  /// A system-defined color with the following value RGBA(107, 142, 35, 255).
  static Vector4 get oliveDrab => new Vector4(0.4196078431372549, 0.5568627450980392, 0.13725490196078433, 1.0);

  /// A system-defined color with the following value RGBA(255, 165, 0, 255).
  static Vector4 get orange => new Vector4(1.0, 0.6470588235294118, 0.0, 1.0);

  /// A system-defined color with the following value RGBA(255, 69, 0, 255).
  static Vector4 get orangeRed => new Vector4(1.0, 0.27058823529411763, 0.0, 1.0);

  /// A system-defined color with the following value RGBA(218, 112, 214, 255).
  static Vector4 get orchid => new Vector4(0.8549019607843137, 0.4392156862745098, 0.8392156862745098, 1.0);

  /// A system-defined color with the following value RGBA(238, 232, 170, 255).
  static Vector4 get paleGoldenrod => new Vector4(0.9333333333333333, 0.9098039215686274, 0.6666666666666666, 1.0);

  /// A system-defined color with the following value RGBA(152, 251, 152, 255).
  static Vector4 get paleGreen => new Vector4(0.596078431372549, 0.984313725490196, 0.596078431372549, 1.0);

  /// A system-defined color with the following value RGBA(175, 238, 238, 255).
  static Vector4 get paleTurquoise => new Vector4(0.6862745098039216, 0.9333333333333333, 0.9333333333333333, 1.0);

  /// A system-defined color with the following value RGBA(219, 112, 147, 255).
  static Vector4 get paleVioletRed => new Vector4(0.8588235294117647, 0.4392156862745098, 0.5764705882352941, 1.0);

  /// A system-defined color with the following value RGBA(255, 239, 213, 255).
  static Vector4 get papayaWhip => new Vector4(1.0, 0.9372549019607843, 0.8352941176470589, 1.0);

  /// A system-defined color with the following value RGBA(255, 218, 185, 255).
  static Vector4 get peachPuff => new Vector4(1.0, 0.8549019607843137, 0.7254901960784313, 1.0);

  /// A system-defined color with the following value RGBA(205, 133, 63, 255).
  static Vector4 get peru => new Vector4(0.803921568627451, 0.5215686274509804, 0.24705882352941178, 1.0);

  /// A system-defined color with the following value RGBA(255, 192, 203, 255).
  static Vector4 get pink => new Vector4(1.0, 0.7529411764705882, 0.796078431372549, 1.0);

  /// A system-defined color with the following value RGBA(221, 160, 221, 255).
  static Vector4 get plum => new Vector4(0.8666666666666667, 0.6274509803921569, 0.8666666666666667, 1.0);

  /// A system-defined color with the following value RGBA(176, 224, 230, 255).
  static Vector4 get powderBlue => new Vector4(0.6901960784313725, 0.8784313725490196, 0.9019607843137255, 1.0);

  /// A system-defined color with the following value RGBA(128, 0, 128, 255).
  static Vector4 get purple => new Vector4(0.5019607843137255, 0.0, 0.5019607843137255, 1.0);

  /// A system-defined color with the following value RGBA(255, 0, 0, 255).
  static Vector4 get red => new Vector4(1.0, 0.0, 0.0, 1.0);

  /// A system-defined color with the following value RGBA(188, 143, 143, 255).
  static Vector4 get rosyBrown => new Vector4(0.7372549019607844, 0.5607843137254902, 0.5607843137254902, 1.0);

  /// A system-defined color with the following value RGBA(65, 105, 225, 255).
  static Vector4 get royalBlue => new Vector4(0.2549019607843137, 0.4117647058823529, 0.8823529411764706, 1.0);

  /// A system-defined color with the following value RGBA(139, 69, 19, 255).
  static Vector4 get saddleBrown => new Vector4(0.5450980392156862, 0.27058823529411763, 0.07450980392156863, 1.0);

  /// A system-defined color with the following value RGBA(250, 128, 114, 255).
  static Vector4 get salmon => new Vector4(0.9803921568627451, 0.5019607843137255, 0.4470588235294118, 1.0);

  /// A system-defined color with the following value RGBA(244, 164, 96, 255).
  static Vector4 get sandyBrown => new Vector4(0.9568627450980393, 0.6431372549019608, 0.3764705882352941, 1.0);

  /// A system-defined color with the following value RGBA(46, 139, 87, 255).
  static Vector4 get seaGreen => new Vector4(0.1803921568627451, 0.5450980392156862, 0.3411764705882353, 1.0);

  /// A system-defined color with the following value RGBA(255, 245, 238, 255).
  static Vector4 get seaShell => new Vector4(1.0, 0.9607843137254902, 0.9333333333333333, 1.0);

  /// A system-defined color with the following value RGBA(160, 82, 45, 255).
  static Vector4 get sienna => new Vector4(0.6274509803921569, 0.3215686274509804, 0.17647058823529413, 1.0);

  /// A system-defined color with the following value RGBA(192, 192, 192, 255).
  static Vector4 get silver => new Vector4(0.7529411764705882, 0.7529411764705882, 0.7529411764705882, 1.0);

  /// A system-defined color with the following value RGBA(135, 206, 235, 255).
  static Vector4 get skyBlue => new Vector4(0.5294117647058824, 0.807843137254902, 0.9215686274509803, 1.0);

  /// A system-defined color with the following value RGBA(106, 90, 205, 255).
  static Vector4 get slateBlue => new Vector4(0.41568627450980394, 0.35294117647058826, 0.803921568627451, 1.0);

  /// A system-defined color with the following value RGBA(112, 128, 144, 255).
  static Vector4 get slateGray => new Vector4(0.4392156862745098, 0.5019607843137255, 0.5647058823529412, 1.0);

  /// A system-defined color with the following value RGBA(255, 250, 250, 255).
  static Vector4 get snow => new Vector4(1.0, 0.9803921568627451, 0.9803921568627451, 1.0);

  /// A system-defined color with the following value RGBA(0, 255, 127, 255).
  static Vector4 get springGreen => new Vector4(0.0, 1.0, 0.4980392156862745, 1.0);

  /// A system-defined color with the following value RGBA(70, 130, 180, 255).
  static Vector4 get steelBlue => new Vector4(0.27450980392156865, 0.5098039215686274, 0.7058823529411765, 1.0);

  /// A system-defined color with the following value RGBA(210, 180, 140, 255).
  static Vector4 get tan => new Vector4(0.8235294117647058, 0.7058823529411765, 0.5490196078431373, 1.0);

  /// A system-defined color with the following value RGBA(0, 128, 128, 255).
  static Vector4 get teal => new Vector4(0.0, 0.5019607843137255, 0.5019607843137255, 1.0);

  /// A system-defined color with the following value RGBA(216, 191, 216, 255).
  static Vector4 get thistle => new Vector4(0.8470588235294118, 0.7490196078431373, 0.8470588235294118, 1.0);

  /// A system-defined color with the following value RGBA(255, 99, 71, 255).
  static Vector4 get tomato => new Vector4(1.0, 0.38823529411764707, 0.2784313725490196, 1.0);

  /// A system-defined color with the following value RGBA(64, 224, 208, 255).
  static Vector4 get turquoise => new Vector4(0.25098039215686274, 0.8784313725490196, 0.8156862745098039, 1.0);

  /// A system-defined color with the following value RGBA(238, 130, 238, 255).
  static Vector4 get violet => new Vector4(0.9333333333333333, 0.5098039215686274, 0.9333333333333333, 1.0);

  /// A system-defined color with the following value RGBA(245, 222, 179, 255).
  static Vector4 get wheat => new Vector4(0.9607843137254902, 0.8705882352941177, 0.7019607843137254, 1.0);

  /// A system-defined color with the following value RGBA(255, 255, 255, 255).
  static Vector4 get white => new Vector4(1.0, 1.0, 1.0, 1.0);

  /// A system-defined color with the following value RGBA(245, 245, 245, 255).
  static Vector4 get whiteSmoke => new Vector4(0.9607843137254902, 0.9607843137254902, 0.9607843137254902, 1.0);

  /// A system-defined color with the following value RGBA(255, 255, 0, 255).
  static Vector4 get yellow => new Vector4(1.0, 1.0, 0.0, 1.0);

  /// A system-defined color with the following value RGBA(154, 205, 50, 255).
  static Vector4 get yellowGreen => new Vector4(0.6039215686274509, 0.803921568627451, 0.19607843137254902, 1.0);
}
