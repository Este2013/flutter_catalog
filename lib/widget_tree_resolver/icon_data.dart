import 'package:flutter_catalog/widget_tree_resolver/richtext_data.dart';
import 'package:flutter_catalog/widget_tree_resolver/semantics_data.dart';

import 'data.dart';

class IconNodeData extends WidgetTreeNodeData {
  IconNodeData(WidgetParametersData? params) : super('Icon', child: null, parameters: params);

  @override
  WidgetTreeNodeData? build() => SemanticsData(
        child: ExcludeSemanticsData(child: RichTextData(null)),
        parameters: parameters,
      );
}
