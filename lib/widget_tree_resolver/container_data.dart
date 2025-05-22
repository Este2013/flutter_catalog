import 'package:flutter/material.dart';
import 'package:flutter_catalog/material/theme_explanations_utils.dart';
import 'package:flutter_catalog/utils/better_widget_span.dart';
import 'package:flutter_catalog/widget_tree_resolver/data.dart';

import 'basic_widgets_data.dart';
import 'semantics_data.dart';

class ContainerNodeData extends WidgetTreeNodeData {
  ContainerNodeData() //TODO everything here
      : super(
          'Container',
          child: null,
          parameters: [
            WidgetPropertyData(
              'Alignment',
              typeName: 'AlignmentGeometry?',
              dataLink: WidgetPropertyDataDirectLink(
                nameOfDestinationChildWidget: 'Align',
                nameOfDestinationChildProperties: ['alignment'],
              ),
            ),
          ],
        );

  // -------------------------------------------------------------------------
  //   BUILD:  produce the *widget tree* that an <Icon> ultimately expands to.
  // -------------------------------------------------------------------------
  @override
  TreeNodeData? build() => ConditionalTreeNodeData(
        condition: [
          CWidgetSpan(child: LinkChip.ofWidgetProperty('Container', 'child')),
          TextSpan(text: ' is null, and either: '),
          CWidgetSpan(child: LinkChip.ofWidgetProperty('Container', 'constraints')),
          TextSpan(text: ' is null, or not '),
          CWidgetSpan(child: LinkChip('constraints.isTight', link: 'https://api.flutter.dev/flutter/rendering/BoxConstraints/isTight.html')),
        ],
        child: NamedTreeNodeData('LimitedBox', child: NamedTreeNodeData('ConstrainedBox')),
        ifFalse: NamedTreeNodeData('Align', child: ChildTreeNodeData()),
      );
}
