import 'dart:ui' as ui;

import 'package:auto_fit_text/core/extension.dart';

import 'raw_text.dart';
import 'package:flutter/material.dart';

class AutoFitText extends StatelessWidget {
  AutoFitText(
    String text, {
    super.key,
    TextStyle? style,
    this.textAlign = TextAlign.start,
    this.textDirection,
    this.softWrap = true,
    this.overflow = TextOverflow.clip,
    this.textScaler,
    this.maxLines,
    this.locale,
    this.strutStyle,
    this.textWidthBasis = TextWidthBasis.parent,
    this.textHeightBehavior,
    this.minScale = 0.01,
    this.maxScale = 1.0,
    this.stepGranularity = 0.01,
  })  : assert(maxLines == null || maxLines > 0),
        assert(minScale > 0),
        assert(maxScale > minScale),
        text = _createTextSpan(text, style);

  const AutoFitText.rich(
    this.text, {
    super.key,
    this.textAlign = TextAlign.start,
    this.textDirection,
    this.softWrap = true,
    this.overflow = TextOverflow.clip,
    this.textScaler,
    this.maxLines,
    this.locale,
    this.strutStyle,
    this.textWidthBasis = TextWidthBasis.parent,
    this.textHeightBehavior,
    this.minScale = 0.01,
    this.maxScale = 1.0,
    this.stepGranularity = 0.01,
  })  : assert(maxLines == null || maxLines > 0),
        assert(minScale > 0),
        assert(maxScale < 1000),
        assert(maxScale > minScale),
        assert(stepGranularity > 0 && stepGranularity < 1);

  final InlineSpan text;
  final TextAlign textAlign;
  final TextDirection? textDirection;
  final bool softWrap;
  final TextOverflow overflow;
  final TextScaler? textScaler;
  final int? maxLines;
  final Locale? locale;
  final StrutStyle? strutStyle;
  final TextWidthBasis textWidthBasis;
  final ui.TextHeightBehavior? textHeightBehavior;
  final double minScale;
  final double maxScale;
  final double stepGranularity;

  static TextSpan _createTextSpan(String text, TextStyle? style) {
    return TextSpan(text: text, style: style);
  }

  InlineSpan _setStyleForTextSpan(BuildContext context, InlineSpan span) {
    if (span is TextSpan) {
      return span.copyWith(
        style: DefaultTextStyle.of(context).style.merge(span.style),
        children: span.children?.map((e) => _setStyleForTextSpan(context, e)).toList(),
      );
    } else {
      return span;
    }
  }

  @override
  Widget build(BuildContext context) {
    assert(() {
      final span = text;
      if (span is! TextSpan) {
        return true;
      }
      final defaultStyle = DefaultTextStyle.of(context).style;
      if (span.style?.fontSize == null && defaultStyle.fontSize == null) {
        throw 'fontSize is null';
      }
      return true;
    }());

    final TextScaler textScaler = this.textScaler ?? MediaQuery.of(context).textScaler;
    InlineSpan span = _setStyleForTextSpan(context, text);

    return RawAutoFitText(
      span,
      textAlign: textAlign,
      textDirection: textDirection ?? Directionality.of(context),
      softWrap: softWrap,
      overflow: overflow,
      textScaler: textScaler,
      maxLines: maxLines,
      strutStyle: strutStyle,
      textWidthBasis: textWidthBasis,
      textHeightBehavior: textHeightBehavior,
      locale: locale ?? Localizations.maybeLocaleOf(context),
      maxScale: maxScale,
      minScale: minScale,
      stepGranularity: stepGranularity,
    );
  }
}
