import 'package:flutter/material.dart';
import 'package:flutter_catalog/material/theme_explanations_utils.dart';
import 'package:flutter_catalog/utils/better_widget_span.dart';

abstract class TreeNodeData {
  TreeNodeData({this.child, this.key});

  // optional value to determine which widget should recieve a property link
  String? key;
  TreeNodeData? child;
  TreeNodeData? build();
}

abstract class WidgetTreeNodeData extends TreeNodeData {
  WidgetTreeNodeData(this.widgetName, {super.child, this.parameters, super.key});

  String widgetName;
  List<WidgetPropertyData>? parameters;
}

class ConditionalTreeNodeData extends TreeNodeData {
  ConditionalTreeNodeData({
    required this.condition,
    super.child,
    this.ifFalse,
    bool defaultCondition = true,
  }) {
    conditionFulfilment = ValueNotifier(defaultCondition);
  }

  late ValueNotifier<bool> conditionFulfilment;
  List<InlineSpan> condition;
  TreeNodeData? ifFalse;

  @override
  TreeNodeData? build() {
    if (conditionFulfilment.value) return child;
    return ifFalse;
  }
}

class ConditionalWrappingTreeNodeData extends TreeNodeData {
  ConditionalWrappingTreeNodeData({
    required this.condition,
    super.child,
    this.wrappingIfTrue,
    this.wrappingIfFalse,
    bool defaultCondition = true,
  }) {
    conditionFulfilment = ValueNotifier(defaultCondition);
  }

  late ValueNotifier<bool> conditionFulfilment;
  List<InlineSpan> condition;
  TreeNodeData Function(TreeNodeData? child)? wrappingIfTrue, wrappingIfFalse;

  @override
  TreeNodeData? build() {
    if (conditionFulfilment.value) {
      if (wrappingIfTrue != null) return wrappingIfTrue!(child);
      return child;
    }
    if (wrappingIfFalse != null) return wrappingIfFalse!(child);
    return child;
  }
}

// properties

class WidgetPropertyData<T> {
  WidgetPropertyData(
    this.propertyName, {
    required this.typeName,
    this.docsLink,
    this.subProperties,
    WidgetPropertyDataLink? dataLink,
    List<WidgetPropertyDataLink>? dataLinks,
  }) : dataLinks = dataLinks ?? (dataLink == null ? null : [dataLink]);

  final String propertyName, typeName;
  final String? docsLink;
  final List<WidgetPropertyData>? subProperties;

  final List<WidgetPropertyDataLink>? dataLinks;

  /// Helper for legacy code that still expects “the” link.
  WidgetPropertyDataLink? get dataLink => (dataLinks == null || dataLinks!.isEmpty) ? null : dataLinks!.first;
}
//// data links

abstract class WidgetPropertyDataLink {
  const WidgetPropertyDataLink({
    required this.nameOfDestinationChildWidget,
    required this.nameOfDestinationChildProperties,
    this.order = 1,
    this.destinationKey,
    required this.beforePassingToChildren,
  });

  final String nameOfDestinationChildWidget;
  final String? destinationKey;

  /// 1: first child widget of corresponding name
  /// 2: 2nd child widget of...
  final int order;
  final List<String> nameOfDestinationChildProperties;

  final List<WidgetPropertyModifications>? beforePassingToChildren;
}

class WidgetPropertyDataDirectLink extends WidgetPropertyDataLink {
  WidgetPropertyDataDirectLink({required super.nameOfDestinationChildWidget, required super.nameOfDestinationChildProperties, super.beforePassingToChildren, super.destinationKey});
}

class WidgetPropertyDataLinkWithRenaming extends WidgetPropertyDataLink {
  WidgetPropertyDataLinkWithRenaming(this.newName, {required super.nameOfDestinationChildWidget, required super.nameOfDestinationChildProperties, super.beforePassingToChildren, super.destinationKey});

  final String newName;
}

//// modifying data before passing it down

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
              CWidgetSpan(child: LinkChip(fallback.$1, link: fallback.$2)),
              TextSpan(text: ', then '),
            ],
          ]..removeLast(),
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      );
}

class WidgetPropertyDataConditionalModification extends WidgetPropertyModifications {
  WidgetPropertyDataConditionalModification({
    required this.renderConditionSpans,
    required this.ifTrue,
    this.ifFalse,
  });

  // exemple "[variable](link) is null"
  final List<InlineSpan> Function(BuildContext context) renderConditionSpans;
  final WidgetPropertyModifications ifTrue;
  final WidgetPropertyModifications? ifFalse;

  @override
  Widget render(BuildContext context) => RichText(
        text: TextSpan(
          children: [
            TextSpan(text: 'If '),
            ...renderConditionSpans(context),
            TextSpan(text: ':\n'),
            WidgetSpan(child: InsetDisplay(content: ifTrue.render(context))),
            if (ifFalse != null) ...[
              TextSpan(text: '\n'),
              TextSpan(text: 'Otherwise:'),
              WidgetSpan(child: InsetDisplay(content: ifFalse!.render(context))),
            ],
          ],
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

class WidgetPropertyDataPackaging extends WidgetPropertyModifications {
  final String packageType, packageName;
  final String? packageDocsLink;

  final WidgetPropertyModifications? modifications;

  WidgetPropertyDataPackaging({required this.packageType, required this.packageName, this.packageDocsLink, required this.modifications});

  @override
  Widget render(BuildContext context) => RichText(
        text: TextSpan(
          children: [
            TextSpan(text: 'Define '),
            CWidgetSpan(child: LinkChip('$packageType $packageName', link: packageDocsLink)),
            TextSpan(text: ' where: \n'),
            WidgetSpan(
              child: InsetDisplay(
                content: Column(
                  children: [if (modifications != null) modifications!.render(context)],
                ),
              ),
            ),
          ],
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      );
}
