import 'data.dart';

class CenterData extends WidgetTreeNodeData {
  CenterData({super.child}) : super('Center', parameters: null);

  @override
  WidgetTreeNodeData? build() => child;
}

class SizedBoxData extends WidgetTreeNodeData {
  SizedBoxData({super.child})
      : super(
          'SizedBox',
          parameters: null,
        );

  @override
  WidgetTreeNodeData? build() => child;
}

class RichTextData extends WidgetTreeNodeData {
  RichTextData()
      : super(
          'RichText',
          child: null,
          parameters: null,
        );

  @override
  WidgetTreeNodeData? build() {/*TODO*/}
}
