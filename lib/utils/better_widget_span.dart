import 'package:flutter/material.dart';

class CRichText extends RichText {
  CRichText(BuildContext context,
      {super.key,
      required List<InlineSpan> children,
      super.textAlign,
      super.textDirection,
      super.softWrap,
      super.overflow,
      super.textScaleFactor,
      super.textScaler,
      super.maxLines,
      super.locale,
      super.strutStyle,
      super.textWidthBasis = TextWidthBasis.parent,
      super.textHeightBehavior,
      super.selectionRegistrar,
      super.selectionColor})
      : super(
          text: TextSpan(
            style: Theme.of(context).textTheme.bodyMedium,
            children: children,
          ),
        );
}

/// A centered WidgetSpan
class CWidgetSpan extends WidgetSpan {
  const CWidgetSpan({required super.child, super.baseline, super.style}) : super(alignment: PlaceholderAlignment.middle);
}
