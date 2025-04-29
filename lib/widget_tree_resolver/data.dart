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
    required this.nameOfDestinationChildProperty,
    this.order = 1,
  });

  final String nameOfDestinationChildWidget;

  /// 1: first child widget of correcponding name
  /// 2: 2nd child widget of...
  final int order;
  final String nameOfDestinationChildProperty;
}

class WidgetPropertyDataDirectLink extends WidgetPropertyDataLink {
  WidgetPropertyDataDirectLink({required super.nameOfDestinationChildWidget, required super.nameOfDestinationChildProperty});
}
