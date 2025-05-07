import 'package:flutter/material.dart';

bool doesTextExceedMaxLines({
  required int maxLines,
  required String? text,
  required TextStyle style,
  required double maxWidth,
  required TextScaler textScaler,
}) {
  final TextPainter textPainter = TextPainter(
    text: TextSpan(text: text, style: style),
    textScaler: textScaler,
    maxLines: maxLines,
    textDirection: TextDirection.ltr,
  )..layout(maxWidth: maxWidth);

  return textPainter.didExceedMaxLines;
}

double getRequiredWidth({
  required String text,
  required TextStyle style,
  required TextScaler textScaler,
  double horizontalPadding = 0,
}) {
  final scaledStyle = style.copyWith(
    fontSize: textScaler.scale(style.fontSize ?? 0),
  );
  final textPainter = TextPainter(
    text: TextSpan(text: text, style: scaledStyle),
    maxLines: 1,
    textDirection: TextDirection.ltr,
  )..layout();
  return textPainter.width + horizontalPadding;
}
