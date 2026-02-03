import 'package:flutter/material.dart';
import 'package:test_doodle/core_ui/theme/theme_context.dart';

enum TextStyleType { heading, body, caption }

class AppTextModel {
  const AppTextModel({
    required this.heading,
    required this.body,
    required this.caption,
  });

  final TextStyle heading;
  final TextStyle body;
  final TextStyle caption;
}

class AppText extends StatelessWidget {
  const AppText.heading(
    this.text, {
    super.key,
    this.color,
    this.maxLines,
    this.fontWeight,
    this.fontSize,
    this.fontFamily,
    this.align,
    this.textDecoration,
    this.overflow,
    this.fontStyle,
  }) : styleType = TextStyleType.heading;

  const AppText.body(
    this.text, {
    super.key,
    this.color,
    this.maxLines,
    this.fontWeight,
    this.fontSize,
    this.fontFamily,
    this.align,
    this.textDecoration,
    this.overflow,
    this.fontStyle,
  }) : styleType = TextStyleType.body;

  const AppText.caption(
    this.text, {
    super.key,
    this.color,
    this.maxLines,
    this.fontWeight,
    this.fontSize,
    this.fontFamily,
    this.align,
    this.textDecoration,
    this.overflow,
    this.fontStyle,
  }) : styleType = TextStyleType.caption;

  @override
  Widget build(BuildContext context) {
    final colors = ThemeContext.of(context).colors;
    TextStyle? getStyle() {
      switch (styleType) {
        case TextStyleType.heading:
          return TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: colors.textColor,
          );
        case TextStyleType.body:
          return TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.normal,
            color: colors.textColor,
          );
        case TextStyleType.caption:
          return TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w300,
            color: colors.textColor,
          );
      }
    }

    final style = getStyle()!.copyWith(
      color: color ?? getStyle()!.color,
      fontWeight: fontWeight ?? getStyle()!.fontWeight,
      fontSize: fontSize ?? getStyle()!.fontSize,
      fontFamily: fontFamily ?? getStyle()!.fontFamily,
      decoration: textDecoration ?? getStyle()!.decoration,
      fontStyle: fontStyle ?? getStyle()!.fontStyle,
    );

    final textAlign = align ?? TextAlign.left;

    return Text(
      text,
      overflow: overflow,
      maxLines: maxLines,
      textAlign: textAlign,
      style: style,
    );
  }

  final String text;
  final TextStyleType styleType;
  final Color? color;
  final FontWeight? fontWeight;
  final String? fontFamily;
  final double? fontSize;
  final TextAlign? align;
  final int? maxLines;
  final TextDecoration? textDecoration;
  final FontStyle? fontStyle;
  final TextOverflow? overflow;
}
