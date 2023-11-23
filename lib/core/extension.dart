import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';

extension TextSpanCommit on TextSpan {
  TextSpan copyWith({
    String? text,
    TextStyle? style,
    List<InlineSpan>? children,
    GestureRecognizer? recognizer,
    String? semanticsLabel,
    Locale? locale,
    bool? spellOut,
    PointerEnterEventListener? onEnter,
    PointerExitEventListener? onExit,
    MouseCursor? mouseCursor,
  }) {
    return TextSpan(
      text: text ?? this.text,
      children: children ?? this.children,
      style: style ?? this.style,
      recognizer: recognizer ?? this.recognizer,
      mouseCursor: mouseCursor ?? this.mouseCursor,
      onEnter: onEnter ?? this.onEnter,
      onExit: onExit ?? this.onExit,
      semanticsLabel: semanticsLabel ?? this.semanticsLabel,
      locale: locale ?? this.locale,
      spellOut: spellOut ?? this.spellOut,
    );
  }
}
