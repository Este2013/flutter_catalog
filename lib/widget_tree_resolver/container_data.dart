import 'package:flutter/material.dart';
import 'package:flutter_catalog/material/theme_explanations_utils.dart';
import 'package:flutter_catalog/utils/better_widget_span.dart';
import 'package:flutter_catalog/widget_tree_resolver/data.dart';

import 'basic_widgets_data.dart';
import 'semantics_data.dart';

class ContainerNodeData extends WidgetTreeNodeData {
  ContainerNodeData({super.key}) //TODO everything here
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
            WidgetPropertyData(
              'Decoration',
              typeName: 'Decoration?',
              dataLink: WidgetPropertyDataDirectLink(
                destinationKey: 'decoration',
                nameOfDestinationChildWidget: 'DecoratedBox',
                nameOfDestinationChildProperties: ['decoration'],
              ),
            ),
            WidgetPropertyData(
              'ForegroudDecoration',
              typeName: 'Decoration?',
              dataLink: WidgetPropertyDataDirectLink(
                destinationKey: 'foregroundDecoration',
                nameOfDestinationChildWidget: 'DecoratedBox',
                nameOfDestinationChildProperties: ['decoration'],
              ),
            ),
            // TODO ALL PROPERTIES
          ],
        );

  // -------------------------------------------------------------------------
  //   BUILD:  produce the *widget tree* that an <Icon> ultimately expands to.
  // -------------------------------------------------------------------------
  @override
  TreeNodeData? build() => ConditionalWrappingTreeNodeData(
          condition: [
            CWidgetSpan(child: LinkChip.ofWidgetProperty('Container', 'transform')),
            TextSpan(text: ' is null'),
          ],
          wrappingIfFalse: (child) => NamedTreeNodeData('Transform', child: child),
          child: ConditionalWrappingTreeNodeData(
              condition: [
                CWidgetSpan(child: LinkChip.ofWidgetProperty('Container', 'margin')),
                TextSpan(text: ' is null'),
              ],
              wrappingIfFalse: (child) => NamedTreeNodeData('Padding', child: child),
              child: ConditionalWrappingTreeNodeData(
                  condition: [
                    CWidgetSpan(child: LinkChip.ofWidgetProperty('Container', 'constraints')),
                    TextSpan(text: ' is null'),
                  ],
                  wrappingIfFalse: (child) => NamedTreeNodeData('ConstrainedBox', child: child),
                  child: ConditionalWrappingTreeNodeData(
                      condition: [
                        CWidgetSpan(child: LinkChip.ofWidgetProperty('Container', 'foregroundDecoration')),
                        TextSpan(text: ' is null'),
                      ],
                      wrappingIfFalse: (child) => NamedTreeNodeData('DecoratedBox', child: child, key: 'foregroundDecoration'),
                      child: ConditionalWrappingTreeNodeData(
                          condition: [
                            CWidgetSpan(child: LinkChip.ofWidgetProperty('Container', 'decoration')),
                            TextSpan(text: ' is null'),
                          ],
                          wrappingIfFalse: (child) => NamedTreeNodeData('DecoratedBox', child: child, key: 'decoration'),
                          child: ConditionalWrappingTreeNodeData(
                              condition: [
                                CWidgetSpan(child: LinkChip.ofWidgetProperty('Container', 'clipBehavior')),
                                TextSpan(text: ' is '),
                                CWidgetSpan(child: LinkChip('Clip.none', link: 'https://api.flutter.dev/flutter/dart-ui/Clip.html')),
                              ],
                              wrappingIfFalse: (child) => NamedTreeNodeData('ClipPath', child: child),
                              child: ConditionalWrappingTreeNodeData(
                                  condition: [
                                    CWidgetSpan(child: LinkChip.ofWidgetProperty('Container', 'color')),
                                    TextSpan(text: ' is null'),
                                  ],
                                  wrappingIfFalse: (child) => NamedTreeNodeData('ColoredBox', child: child),
                                  child: ConditionalWrappingTreeNodeData(
                                      condition: [
                                        TextSpan(text: 'Both '),
                                        CWidgetSpan(child: LinkChip.ofWidgetProperty('Container', 'padding')),
                                        TextSpan(text: ' and '),
                                        CWidgetSpan(child: LinkChip('decoration?.padding')),
                                        TextSpan(text: ' are null'),
                                      ],
                                      wrappingIfFalse: (child) => NamedTreeNodeData('Padding', child: child),
                                      child: ConditionalTreeNodeData(
                                        condition: [
                                          CWidgetSpan(child: LinkChip.ofWidgetProperty('Container', 'child')),
                                          TextSpan(text: ' is null, and either: '),
                                          CWidgetSpan(child: LinkChip.ofWidgetProperty('Container', 'constraints')),
                                          TextSpan(text: ' is null, or not '),
                                          CWidgetSpan(child: LinkChip('constraints.isTight', link: 'https://api.flutter.dev/flutter/rendering/BoxConstraints/isTight.html')),
                                        ],
                                        defaultCondition: false,
                                        child: NamedTreeNodeData('LimitedBox', child: NamedTreeNodeData('ConstrainedBox')),
                                        ifFalse: ConditionalTreeNodeData(
                                          condition: [
                                            CWidgetSpan(child: LinkChip.ofWidgetProperty('Container', 'alignment')),
                                            TextSpan(text: ' is null'),
                                          ],
                                          ifFalse: NamedTreeNodeData('Align', child: ChildTreeNodeData()),
                                          child: ChildTreeNodeData(),
                                        ),
                                      )))))))));
}
