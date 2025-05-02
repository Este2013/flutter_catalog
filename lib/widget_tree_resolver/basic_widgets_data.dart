import 'data.dart';

class CenterData extends WidgetTreeNodeData {
  CenterData({super.child}) : super('Center', parameters: null);

  @override
  TreeNodeData? build() => child;
}

class SizedBoxData extends WidgetTreeNodeData {
  SizedBoxData({super.child})
      : super(
          'SizedBox',
          parameters: null,
        );

  @override
  TreeNodeData? build() => child;
}

class RichTextData extends WidgetTreeNodeData {
  RichTextData()
      : super(
          'RichText',
          child: null,
          parameters: null,
        );

  @override
  TreeNodeData? build() {/*TODO*/}
}

class TransformData extends WidgetTreeNodeData {
  TransformData({super.child})
      : super(
          'Transform',
          parameters: null,
        );

  @override
  TreeNodeData? build() => child;
}
