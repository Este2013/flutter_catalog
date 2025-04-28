import 'data.dart';

class SemanticsData extends WidgetTreeNodeData {
  SemanticsData({super.child, super.parameters}) : super('Semantics');

  @override
  WidgetTreeNodeData? build() => child;
}

class ExcludeSemanticsData extends WidgetTreeNodeData {
  ExcludeSemanticsData({super.child}) : super('ExcludeSemantics', parameters: null);

  @override
  WidgetTreeNodeData? build() => child;
}
