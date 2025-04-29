import 'package:flutter/material.dart';
import 'package:flutter_catalog/material/theme_explanations_utils.dart';
import 'package:flutter_catalog/widget_tree_resolver/basic_widgets_data.dart';
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
              dataLink: WidgetPropertyDataDirectLink(
                nameOfDestinationChildWidget: 'Semantics',
                nameOfDestinationChildProperties: ['semanticLabel'],
              ),
            ),
            WidgetPropertyData(
              'size',
              typeName: 'double?',
              dataLink: WidgetPropertyDataDirectLink(
                nameOfDestinationChildWidget: 'SizedBox',
                nameOfDestinationChildProperties: ['height', 'width'],
                beforePassingToChildren: [
                  WidgetPropertyDataFallback(fallbacks: [('IconTheme.of(context).size', null), ('kDefaultFontSize', null)]),
                  WidgetPropertyDataModification(
                    (context) => [
                      TextSpan(text: 'If '),
                      WidgetSpan(alignment: PlaceholderAlignment.middle, child: LinkChip('applyTextScaling', link: null)),
                      TextSpan(text: ' is true, use: '),
                      WidgetSpan(alignment: PlaceholderAlignment.middle, child: LinkChip('MediaQuery.textScalerOf(context).scale(size)', link: null)),
                    ],
                  )
                ],
              ),
            ),
          ],
        );

  @override
  WidgetTreeNodeData? build() => SemanticsData(
        child: ExcludeSemanticsData(child: SizedBoxData(child: CenterData(child: RichTextData()))),
      );
}
