import 'data.dart';

class SemanticsData extends WidgetTreeNodeData {
  SemanticsData({super.child})
      : super(
          'Semantics',
          parameters: [
            WidgetPropertyData('semanticLabel', typeName: 'String?'),
          ],
        );

  @override
  WidgetTreeNodeData? build() => child;
}

class ExcludeSemanticsData extends WidgetTreeNodeData {
  ExcludeSemanticsData({super.child, super.parameters}) : super('ExcludeSemantics');

  @override
  WidgetTreeNodeData? build() => child;
}
