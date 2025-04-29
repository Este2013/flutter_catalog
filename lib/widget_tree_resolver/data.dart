import 'package:flutter/material.dart';
import 'package:flutter_catalog/material/theme_explanations_utils.dart';

abstract class WidgetTreeNodeData {
  WidgetTreeNodeData(this.widgetName, {this.child, this.parameters});

  WidgetTreeNodeData? build();

  String widgetName;
  WidgetTreeNodeData? child;
  List<WidgetPropertyData>? parameters;
}

class WidgetPropertyData<T> {
  const WidgetPropertyData(this.propertyName, {required this.typeName, this.docsLink, this.subProperties, this.dataLink});

  final String propertyName, typeName;
  final String? docsLink;
  final List<WidgetPropertyData>? subProperties;

  final WidgetPropertyDataDirectLink? dataLink;
}

abstract class WidgetPropertyDataLink {
  const WidgetPropertyDataLink({
    required this.nameOfDestinationChildWidget,
    required this.nameOfDestinationChildProperties,
    this.order = 1,
    required this.beforePassingToChildren,
  });

  final String nameOfDestinationChildWidget;

  /// 1: first child widget of corresponding name
  /// 2: 2nd child widget of...
  final int order;
  final List<String> nameOfDestinationChildProperties;

  final List<WidgetPropertyModifications>? beforePassingToChildren;
}

class WidgetPropertyDataDirectLink extends WidgetPropertyDataLink {
  WidgetPropertyDataDirectLink({required super.nameOfDestinationChildWidget, required super.nameOfDestinationChildProperties, super.beforePassingToChildren});
}

abstract class WidgetPropertyModifications {
  Widget render(BuildContext context);
}

class WidgetPropertyDataFallback extends WidgetPropertyModifications {
  WidgetPropertyDataFallback({required this.fallbacks});

  // Fallback name, fallback docslink
  List<(String, String?)> fallbacks;

  @override
  Widget render(BuildContext context) => RichText(
        text: TextSpan(
          children: [
            TextSpan(text: 'If null, fallback on: '),
            for (var fallback in fallbacks) ...[
              WidgetSpan(alignment: PlaceholderAlignment.middle, child: LinkChip(fallback.$1, link: fallback.$2)),
              TextSpan(text: ', then '),
            ],
          ]..removeLast(),
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      );
}

class WidgetPropertyDataModification extends WidgetPropertyModifications {
  WidgetPropertyDataModification(this.renderSpans);

  final List<InlineSpan> Function(BuildContext context) renderSpans;

  @override
  Widget render(BuildContext context) => RichText(
        text: TextSpan(
          children: [...renderSpans(context)],
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      );
}
