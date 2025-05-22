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

//////////////////

class CenterData extends WidgetTreeNodeData {
  CenterData({super.child, super.key}) : super('Center', parameters: null);

  @override
  TreeNodeData? build() => child;
}

class SizedBoxData extends WidgetTreeNodeData {
  SizedBoxData({super.child, super.key})
      : super(
          'SizedBox',
          parameters: null,
        );

  @override
  TreeNodeData? build() => child;
}

class RichTextData extends WidgetTreeNodeData {
  RichTextData({super.key})
      : super(
          'RichText',
          child: null,
          parameters: null,
        );

  @override
  TreeNodeData? build() {/*TODO*/}
}

class TransformData extends WidgetTreeNodeData {
  TransformData({super.child, super.key})
      : super(
          'Transform',
          parameters: null,
        );

  @override
  TreeNodeData? build() => child;
}

class LimitedBoxData extends WidgetTreeNodeData {
  LimitedBoxData({super.child, super.key})
      : super(
          'LimitedBox',
          parameters: null,
        );

  @override
  TreeNodeData? build() => child;
}
