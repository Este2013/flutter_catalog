import 'data.dart';

class NamedTreeNodeData extends WidgetTreeNodeData {
  NamedTreeNodeData(super.widgetName, {super.child, super.key}) : super(parameters: null);

  @override
  TreeNodeData? build() => child;
}

class ChildTreeNodeData extends WidgetTreeNodeData {
  ChildTreeNodeData({super.child}) : super('child', parameters: null);

  @override
  TreeNodeData? build() => child;
}
