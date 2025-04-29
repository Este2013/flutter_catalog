import 'package:flutter_catalog/widget_tree_resolver/richtext_data.dart';
import 'package:flutter_catalog/widget_tree_resolver/semantics_data.dart';

import 'data.dart';

class IconNodeData extends WidgetTreeNodeData {
  IconNodeData()
      : super(
          'Icon',
          child: null,
          parameters: [
            WidgetPropertyData(
              'semanticLabel',
              typeName: 'String?',
              dataLink: WidgetPropertyDataDirectLink(nameOfDestinationChildWidget: 'Semantics', nameOfDestinationChildProperty: 'semanticLabel'),
            ),
          ],
        );

  @override
  WidgetTreeNodeData? build() => SemanticsData(
        child: ExcludeSemanticsData(child: RichTextData()),
      );
}
