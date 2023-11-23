import 'package:flutter/material.dart';

class FitLayout {
  FitLayout(
    this._textPainter, {
    double minScale = 0.01,
    double maxScale = 1.0,
    double stepGranularity = 0.01,
    bool softWrap = true,
    TextOverflow overflow = TextOverflow.clip,
  })  : assert(minScale > 0),
        assert(maxScale > minScale),
        assert(stepGranularity > 0),
        _minScale = minScale,
        _maxScale = maxScale,
        _stepGranularity = stepGranularity,
        _softWrap = softWrap,
        _overflow = overflow;

  final TextPainter _textPainter;
  bool _softWrap;

  TextOverflow _overflow;

  double get minScale => _minScale;
  double _minScale;

  double get maxScale => _maxScale;
  double _maxScale;

  double get stepGranularity => _stepGranularity;
  double _stepGranularity;

  void upset({double? minScale, double? maxScale, double? stepGranularity, bool? softWrap, TextOverflow? overflow}) {
    if (minScale != null) {
      _minScale = minScale;
    }
    if (maxScale != null) {
      _maxScale = maxScale;
    }
    if (stepGranularity != null) {
      _stepGranularity = stepGranularity;
    }
    if (softWrap != null) {
      _softWrap = softWrap;
    }
    if (overflow != null) {
      _overflow = overflow;
    }
  }

  void layoutText({double minWidth = 0.0, double maxWidth = double.infinity}) {
    final bool widthMatters = _softWrap || _overflow == TextOverflow.ellipsis;
    final double layoutMaxWidth = widthMatters ? maxWidth : double.infinity;
    final text = _textPainter.text;
    if (text == null) {
      _textPainter.layout(minWidth: minWidth, maxWidth: layoutMaxWidth);
      return;
    }

    bool reachedMax() {
      return _textPainter.didExceedMaxLines || _textPainter.width > maxWidth;
    }

    double left = _minScale;
    double right = _maxScale;
    while (left <= right) {
      double mid = (left + right) / 2.0;
      _textPainter.textScaler = TextScaler.linear(mid);
      _textPainter.layout(minWidth: minWidth, maxWidth: layoutMaxWidth);
      if (reachedMax()) {
        right = mid - stepGranularity;
      } else {
        left = mid + stepGranularity;
      }
    }
  }
}
