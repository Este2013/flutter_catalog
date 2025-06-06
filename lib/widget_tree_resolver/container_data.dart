import 'package:flutter/material.dart';
import 'package:flutter_catalog/flutter_widgets/basics.dart';
import 'package:flutter_catalog/flutter_widgets/material/theme_explanations_utils.dart';
import 'package:flutter_catalog/utils/better_widget_span.dart';
import 'package:flutter_catalog/widget_tree_resolver/data.dart';

import 'basic_widgets_data.dart';

class ContainerNodeData extends WidgetTreeNodeData {
  ContainerNodeData({super.key}) //TODO everything here
      : super(
          'Container',
          child: null,
          parameters: [
            // alignment
            WidgetPropertyData(
              'alignment',
              typeName: 'AlignmentGeometry?',
              dataLink: WidgetPropertyDataDirectLink(
                nameOfDestinationChildWidget: 'Align',
                nameOfDestinationChildProperties: ['alignment'],
              ),
            ),
            // clipBehavior
            WidgetPropertyData(
              'clipBehavior',
              typeName: 'Clip',
              dataLinks: [
                WidgetPropertyDataLinkWithRenaming('clipper', nameOfDestinationChildWidget: 'ClipPath', nameOfDestinationChildProperties: [
                  'clipper'
                ], beforePassingToChildren: [
                  WidgetPropertyDataPackaging(
                    packageType: '_DecorationClipper',
                    packageName: 'clipper',
                    modifications: WidgetPropertyDataModification(
                      (context) => [
                        TextSpan(text: 'textDirection = Directionality.maybeOf(context)'),
                        TextSpan(text: '\ndecoration = decoration'),
                        TextSpan(text: '\nclipBehavior = clipBehavior'),
                      ],
                    ),
                  ),
                ]),
              ],
            ),
            // color
            WidgetPropertyData(
              'color',
              typeName: 'Color?',
              dataLink: WidgetPropertyDataDirectLink(
                nameOfDestinationChildWidget: 'ColoredBox',
                nameOfDestinationChildProperties: ['color'],
              ),
            ),
            // decoration
            WidgetPropertyData(
              'decoration',
              typeName: 'Decoration?',
              dataLinks: [
                // missing link into padding (effective padding)
                WidgetPropertyDataDirectLink(
                  destinationKey: 'decoration',
                  nameOfDestinationChildWidget: 'DecoratedBox',
                  nameOfDestinationChildProperties: ['decoration'],
                ),
                WidgetPropertyDataLinkWithRenaming('clipper', nameOfDestinationChildWidget: 'ClipPath', nameOfDestinationChildProperties: [
                  'clipper'
                ], beforePassingToChildren: [
                  WidgetPropertyDataPackaging(
                    packageType: '_DecorationClipper',
                    packageName: 'clipper',
                    modifications: WidgetPropertyDataModification(
                      (context) => [
                        TextSpan(text: 'textDirection = Directionality.maybeOf(context)'),
                        TextSpan(text: '\ndecoration = decoration'),
                        TextSpan(text: '\nclipBehavior = clipBehavior'),
                      ],
                    ),
                  ),
                ]),
                WidgetPropertyDataLinkWithRenaming('effectivePadding', nameOfDestinationChildWidget: 'Padding', nameOfDestinationChildProperties: [
                  'padding'
                ], beforePassingToChildren: [
                  WidgetPropertyDataPackaging(
                      packageName: 'effectivePadding',
                      packageType: 'EdgeInsetsGeometry?',
                      modifications: WidgetPropertyDataModification((context) => [TextSpan(text: 'effectivePadding is either padding or decoration.padding, or their sum (if both are provided)')]))
                ]),
              ],
            ),
            // foregroundDecoration
            WidgetPropertyData(
              'ForegroudDecoration',
              typeName: 'Decoration?',
              dataLink: WidgetPropertyDataDirectLink(
                destinationKey: 'foregroundDecoration',
                nameOfDestinationChildWidget: 'DecoratedBox',
                nameOfDestinationChildProperties: ['decoration'],
              ),
            ),
            // margin
            WidgetPropertyData(
              'margin',
              typeName: 'EdgeInsetsGeometry?',
              dataLink: WidgetPropertyDataDirectLink(
                destinationKey: 'margin',
                nameOfDestinationChildWidget: 'Padding',
                nameOfDestinationChildProperties: ['padding'],
              ),
            ),
            // padding
            WidgetPropertyData(
              'padding',
              typeName: 'EdgeInsetsGeometry?',
              dataLink: WidgetPropertyDataLinkWithRenaming('effectivePadding', nameOfDestinationChildWidget: 'Padding', nameOfDestinationChildProperties: [
                'padding'
              ], beforePassingToChildren: [
                WidgetPropertyDataPackaging(
                    packageName: 'effectivePadding',
                    packageType: 'EdgeInsetsGeometry?',
                    modifications: WidgetPropertyDataModification((context) => [TextSpan(text: 'effectivePadding is either padding or decoration.padding, or their sum (if both are provided)')]))
              ]),
            ),
            // transform
            WidgetPropertyData(
              'transform',
              typeName: 'Matrix4?',
              dataLink: WidgetPropertyDataDirectLink(
                nameOfDestinationChildWidget: 'Transform',
                nameOfDestinationChildProperties: ['transform'],
              ),
            ),
            // transformAlignment
            WidgetPropertyData(
              'transformAlignment',
              typeName: 'AlignmentGeometry?',
              dataLink: WidgetPropertyDataDirectLink(
                nameOfDestinationChildWidget: 'Transform',
                nameOfDestinationChildProperties: ['transformAlignment'],
              ),
            ),
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
              wrappingIfFalse: (child) => PaddingData(child: child, key: 'margin'),
              child: ConditionalWrappingTreeNodeData(
                  condition: [
                    CWidgetSpan(child: LinkChip.ofWidgetProperty('Container', 'constraints')),
                    TextSpan(text: ' is null'),
                  ],
                  wrappingIfFalse: (child) => ConstrainedBoxData(child: child),
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
                              wrappingIfFalse: (child) => ClipPathData(child: child),
                              child: ConditionalWrappingTreeNodeData(
                                  condition: [
                                    CWidgetSpan(child: LinkChip.ofWidgetProperty('Container', 'color')),
                                    TextSpan(text: ' is null'),
                                  ],
                                  wrappingIfFalse: (child) => ColoredBoxData(child: child),
                                  child: ConditionalWrappingTreeNodeData(
                                      condition: [
                                        TextSpan(text: 'Both '),
                                        CWidgetSpan(child: LinkChip.ofWidgetProperty('Container', 'padding')),
                                        TextSpan(text: ' and '),
                                        CWidgetSpan(child: LinkChip('decoration?.padding')),
                                        TextSpan(text: ' are null'),
                                      ],
                                      wrappingIfFalse: (child) => PaddingData(child: child, key: 'padding'),
                                      child: ConditionalTreeNodeData(
                                        condition: [
                                          CWidgetSpan(child: LinkChip.ofWidgetProperty('Container', 'child')),
                                          TextSpan(text: ' is null, and either: '),
                                          CWidgetSpan(child: LinkChip.ofWidgetProperty('Container', 'constraints')),
                                          TextSpan(text: ' is null, or not '),
                                          CWidgetSpan(child: LinkChip('constraints.isTight', link: 'https://api.flutter.dev/flutter/rendering/BoxConstraints/isTight.html')),
                                        ],
                                        defaultCondition: false,
                                        child: LimitedBoxData(child: ConstrainedBoxData()),
                                        ifFalse: ConditionalTreeNodeData(
                                          condition: [
                                            CWidgetSpan(child: LinkChip.ofWidgetProperty('Container', 'alignment')),
                                            TextSpan(text: ' is null'),
                                          ],
                                          ifFalse: AlignData(child: ChildTreeNodeData()),
                                          child: ChildTreeNodeData(),
                                        ),
                                      )))))))));
}
