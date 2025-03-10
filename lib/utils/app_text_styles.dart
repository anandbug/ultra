import 'package:flutter/material.dart';
import 'package:ultra/gen/fonts.gen.dart';

class AppTextStyles {
  static TextStyle get medium3 => TextStyle(
    fontSize: 15,
    height: 1.5,
    fontFamily: FontFamily.inter,
    fontVariations: [FontVariation.weight(500)],
  );

  static TextStyle get medium2 => TextStyle(
    fontSize: 12,
    height: 1.5,
    fontFamily: FontFamily.inter,
    fontVariations: [FontVariation.weight(500)],
  );

  static TextStyle get header => TextStyle(
    fontSize: 26,
    height: 1.5,
    letterSpacing: -0.3,
    fontFamily: FontFamily.inter,
    fontVariations: [FontVariation.weight(600)],
  );

  static TextStyle get companyTitle => TextStyle(
    fontSize: 16,
    height: 1.5,
    letterSpacing: -0.1,
    fontFamily: FontFamily.inter,
    fontVariations: [FontVariation.weight(600)],
  );

  static TextStyle get textField => TextStyle(
    fontSize: 12,
    height: 1.5,
    fontFamily: FontFamily.inter,
    fontVariations: [FontVariation.weight(400)],
  );

  static TextStyle get sectionHeader => TextStyle(
    fontSize: 10,
    height: 1.5,
    letterSpacing: 0.8,
    fontFamily: FontFamily.inter,
    fontVariations: [FontVariation.weight(600)],
  );

  static TextStyle get body => TextStyle(
    fontSize: 10,
    height: 1.5,
    fontFamily: FontFamily.inter,
    fontVariations: [FontVariation.weight(400)],
  );

  static TextStyle get medium1 => TextStyle(
    fontSize: 10,
    height: 1.5,
    fontFamily: FontFamily.inter,
    fontVariations: [FontVariation.weight(500)],
  );

  static TextStyle get body1 => TextStyle(
    fontSize: 8,
    height: 1.5,
    letterSpacing: 0.8,
    fontFamily: FontFamily.inter,
    fontVariations: [FontVariation.weight(600)],
  );

  static TextStyle get titleSmall => TextStyle(
    fontSize: 12,
    height: 1.5,
    fontFamily: FontFamily.inter,
    fontVariations: [FontVariation.weight(500)],
  );

  static TextStyle get titleBig => TextStyle(
    fontSize: 14,
    height: 1.5,
    letterSpacing: 0.5,
    fontFamily: FontFamily.inter,
    fontVariations: [FontVariation.weight(500)],
  );

  static TextStyle get pillsText => TextStyle(
    fontSize: 10,
    height: 1.5,
    letterSpacing: 0.8,
    fontFamily: FontFamily.inter,
    fontVariations: [FontVariation.weight(600)],
  );
}
