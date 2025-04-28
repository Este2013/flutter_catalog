class WidgetParametersData {}

abstract class WidgetTreeNodeData {
  WidgetTreeNodeData(this.widgetName, {this.child, this.parameters});

  WidgetTreeNodeData? build();

  String widgetName;
  WidgetTreeNodeData? child;
  WidgetParametersData? parameters;
}
