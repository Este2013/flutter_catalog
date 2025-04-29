import 'package:flutter/material.dart';
import 'package:flutter_catalog/material/theme_explanations_utils.dart';
import 'package:flutter_catalog/widget_tree_resolver/basic_widgets_data.dart';
import 'package:flutter_catalog/widget_tree_resolver/semantics_data.dart';

import 'data.dart';

// class IconNodeData extends WidgetTreeNodeData {
//   IconNodeData()
//       : super(
//           'Icon',
//           child: null,
//           parameters: [
//             WidgetPropertyData(
//               'semanticLabel',
//               typeName: 'String?',
//               dataLink: WidgetPropertyDataDirectLink(
//                 nameOfDestinationChildWidget: 'Semantics',
//                 nameOfDestinationChildProperties: ['semanticLabel'],
//               ),
//             ),
//             WidgetPropertyData(
//               'size',
//               typeName: 'double?',
//               dataLink: WidgetPropertyDataDirectLink(
//                 nameOfDestinationChildWidget: 'SizedBox',
//                 nameOfDestinationChildProperties: ['height', 'width'],
//                 beforePassingToChildren: [
//                   WidgetPropertyDataFallback(fallbacks: [('IconTheme.of(context).size', 'https://api.flutter.dev/flutter/widgets/IconThemeData/size.html'), ('kDefaultFontSize', 'https://api.flutter.dev/flutter/painting/kDefaultFontSize-constant.html')]),
//                   WidgetPropertyDataModification(
//                     (context) => [
//                       TextSpan(text: 'If '),
//                       WidgetSpan(alignment: PlaceholderAlignment.middle, child: LinkChip('applyTextScaling', link: null)),
//                       TextSpan(text: ' is true, use: '),
//                       WidgetSpan(alignment: PlaceholderAlignment.middle, child: LinkChip('MediaQuery.textScalerOf(context).scale(size)', link: null)),
//                     ],
//                   )
//                 ],
//               ),
//             ),
//           ],
//         );

//   @override
//   WidgetTreeNodeData? build() => SemanticsData(
//         child: ExcludeSemanticsData(child: SizedBoxData(child: CenterData(child: RichTextData()))),
//       );
// }

class IconNodeData extends WidgetTreeNodeData {
  IconNodeData()
      : super(
          'Icon',
          child: null,
          parameters: [
            // ──────────────────────────────────────────────────────
            //   ACCESSIBILITY
            // ──────────────────────────────────────────────────────
            WidgetPropertyData(
              'semanticLabel',
              typeName: 'String?',
              dataLink: WidgetPropertyDataDirectLink(
                nameOfDestinationChildWidget: 'Semantics',
                nameOfDestinationChildProperties: ['semanticLabel'],
              ),
            ),

            // ──────────────────────────────────────────────────────
            //   GEOMETRY
            // ──────────────────────────────────────────────────────
            WidgetPropertyData(
              'size',
              typeName: 'double?',
              dataLink: WidgetPropertyDataDirectLink(
                nameOfDestinationChildWidget: 'SizedBox',
                nameOfDestinationChildProperties: ['height', 'width'],
                beforePassingToChildren: [
                  WidgetPropertyDataFallback(fallbacks: [
                    ('IconTheme.of(context).size', 'https://api.flutter.dev/flutter/widgets/IconThemeData/size.html'),
                    ('kDefaultFontSize', 'https://api.flutter.dev/flutter/painting/kDefaultFontSize-constant.html'),
                  ]),
                  WidgetPropertyDataModification(
                    (context) => [
                      TextSpan(text: 'If '),
                      WidgetSpan(
                        alignment: PlaceholderAlignment.middle,
                        child: LinkChip('applyTextScaling'),
                      ),
                      TextSpan(text: ' is true, use: '),
                      WidgetSpan(
                        alignment: PlaceholderAlignment.middle,
                        child: LinkChip(
                          'MediaQuery.textScalerOf(context).scale(size)',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // ──────────────────────────────────────────────────────
            //   REQUIRED DATA
            // ──────────────────────────────────────────────────────
            WidgetPropertyData(
              'icon',
              typeName: 'IconData?',
              dataLink: WidgetPropertyDataDirectLink(
                nameOfDestinationChildWidget: 'TextSpan',
                nameOfDestinationChildProperties: [
                  'text',
                  'style.fontFamily',
                  'style.fontPackage',
                  'style.fontFamilyFallback',
                ],
                beforePassingToChildren: [
                  WidgetPropertyDataModification(
                    (context) => [
                      TextSpan(text: 'Converted with '),
                      WidgetSpan(
                        alignment: PlaceholderAlignment.middle,
                        child: LinkChip('String.fromCharCode(icon.codePoint)'),
                      ),
                      TextSpan(text: ' and distributed to TextStyle.'),
                    ],
                  ),
                ],
              ),
            ),

            // ──────────────────────────────────────────────────────
            //   COLOR & PAINT
            // ──────────────────────────────────────────────────────
            WidgetPropertyData(
              'color',
              typeName: 'Color?',
              dataLink: WidgetPropertyDataDirectLink(
                nameOfDestinationChildWidget: 'TextStyle',
                nameOfDestinationChildProperties: ['color'],
                beforePassingToChildren: [
                  WidgetPropertyDataFallback(fallbacks: [
                    ('IconTheme.of(context).color', 'https://api.flutter.dev/flutter/widgets/IconThemeData/color.html'),
                  ]),
                  WidgetPropertyDataModification(
                    (context) => [
                      TextSpan(text: 'Multiplied by '),
                      WidgetSpan(
                        alignment: PlaceholderAlignment.middle,
                        child: LinkChip('iconTheme.opacity'),
                      ),
                      TextSpan(text: ' then cleared if '),
                      WidgetSpan(
                        alignment: PlaceholderAlignment.middle,
                        child: LinkChip('blendMode'),
                      ),
                      TextSpan(text: ' is supplied (moved to Paint.foreground).'),
                    ],
                  ),
                ],
              ),
            ),
            WidgetPropertyData(
              'blendMode',
              typeName: 'BlendMode?',
              dataLink: WidgetPropertyDataDirectLink(
                nameOfDestinationChildWidget: 'TextStyle',
                nameOfDestinationChildProperties: ['foreground'],
                beforePassingToChildren: [
                  WidgetPropertyDataModification(
                    (context) => [
                      TextSpan(text: 'Creates a '),
                      WidgetSpan(
                        alignment: PlaceholderAlignment.middle,
                        child: LinkChip('Paint'),
                      ),
                      TextSpan(text: ' using this mode and the current '),
                      WidgetSpan(
                        alignment: PlaceholderAlignment.middle,
                        child: LinkChip('color'),
                      ),
                      TextSpan(text: '.'),
                    ],
                  ),
                ],
              ),
            ),

            // ──────────────────────────────────────────────────────
            //   VARIABLE-FONT AXES
            // ──────────────────────────────────────────────────────
            WidgetPropertyData(
              'fill',
              typeName: 'double?',
              dataLink: WidgetPropertyDataDirectLink(
                nameOfDestinationChildWidget: 'TextStyle',
                nameOfDestinationChildProperties: ['fontVariations'],
                beforePassingToChildren: [
                  WidgetPropertyDataFallback(fallbacks: [
                    ('IconTheme.of(context).fill', 'https://api.flutter.dev/flutter/widgets/IconThemeData/fill.html'),
                  ]),
                  WidgetPropertyDataModification(
                    (context) => [
                      TextSpan(text: 'Adds FontVariation(\'FILL\', value).'),
                    ],
                  ),
                ],
              ),
            ),
            WidgetPropertyData(
              'weight',
              typeName: 'double?',
              dataLink: WidgetPropertyDataDirectLink(
                nameOfDestinationChildWidget: 'TextStyle',
                nameOfDestinationChildProperties: ['fontVariations'],
                beforePassingToChildren: [
                  WidgetPropertyDataFallback(fallbacks: [
                    ('IconTheme.of(context).weight', 'https://api.flutter.dev/flutter/widgets/IconThemeData/weight.html'),
                  ]),
                  WidgetPropertyDataModification(
                    (context) => [
                      TextSpan(text: 'Adds FontVariation(\'wght\', value).'),
                    ],
                  ),
                ],
              ),
            ),
            WidgetPropertyData(
              'grade',
              typeName: 'double?',
              dataLink: WidgetPropertyDataDirectLink(
                nameOfDestinationChildWidget: 'TextStyle',
                nameOfDestinationChildProperties: ['fontVariations'],
                beforePassingToChildren: [
                  WidgetPropertyDataFallback(fallbacks: [
                    ('IconTheme.of(context).grade', 'https://api.flutter.dev/flutter/widgets/IconThemeData/grade.html'),
                  ]),
                  WidgetPropertyDataModification(
                    (context) => [
                      TextSpan(text: 'Adds FontVariation(\'GRAD\', value).'),
                    ],
                  ),
                ],
              ),
            ),
            WidgetPropertyData(
              'opticalSize',
              typeName: 'double?',
              dataLink: WidgetPropertyDataDirectLink(
                nameOfDestinationChildWidget: 'TextStyle',
                nameOfDestinationChildProperties: ['fontVariations'],
                beforePassingToChildren: [
                  WidgetPropertyDataFallback(fallbacks: [
                    ('IconTheme.of(context).opticalSize', 'https://api.flutter.dev/flutter/widgets/IconThemeData/opticalSize.html'),
                  ]),
                  WidgetPropertyDataModification(
                    (context) => [
                      TextSpan(text: 'Adds FontVariation(\'opsz\', value).'),
                    ],
                  ),
                ],
              ),
            ),

            // ──────────────────────────────────────────────────────
            //   EFFECTS
            // ──────────────────────────────────────────────────────
            WidgetPropertyData(
              'shadows',
              typeName: 'List<Shadow>?',
              dataLink: WidgetPropertyDataDirectLink(
                nameOfDestinationChildWidget: 'TextStyle',
                nameOfDestinationChildProperties: ['shadows'],
                beforePassingToChildren: [
                  WidgetPropertyDataFallback(fallbacks: [
                    ('IconTheme.of(context).shadows', 'https://api.flutter.dev/flutter/widgets/IconThemeData/shadows.html'),
                  ]),
                ],
              ),
            ),

            // ──────────────────────────────────────────────────────
            //   LAYOUT / DIRECTIONALITY
            // ──────────────────────────────────────────────────────
            WidgetPropertyData(
              'textDirection',
              typeName: 'TextDirection?',
              dataLink: WidgetPropertyDataDirectLink(
                nameOfDestinationChildWidget: 'RichText',
                nameOfDestinationChildProperties: ['textDirection'],
                beforePassingToChildren: [
                  WidgetPropertyDataFallback(fallbacks: [
                    ('Directionality.of(context)', 'https://api.flutter.dev/flutter/widgets/Directionality/of.html'),
                  ]),
                ],
              ),
            ),

            // ──────────────────────────────────────────────────────
            //   MEDIA-QUERY-AWARE
            // ──────────────────────────────────────────────────────
            WidgetPropertyData(
              'applyTextScaling',
              typeName: 'bool?',
              dataLink: WidgetPropertyDataDirectLink(
                nameOfDestinationChildWidget: 'SizedBox',
                nameOfDestinationChildProperties: ['height', 'width'],
                beforePassingToChildren: [
                  WidgetPropertyDataFallback(fallbacks: [
                    ('IconTheme.of(context).applyTextScaling', 'https://api.flutter.dev/flutter/widgets/IconThemeData/applyTextScaling.html'),
                    ('false', null),
                  ]),
                  WidgetPropertyDataModification(
                    (context) => [
                      TextSpan(text: 'When true, the final size is scaled by '),
                      WidgetSpan(
                        alignment: PlaceholderAlignment.middle,
                        child: LinkChip(
                          'MediaQuery.textScalerOf(context)',
                          link: 'https://api.flutter.dev/flutter/widgets/MediaQuery/textScalerOf.html',
                        ),
                      ),
                      TextSpan(text: '.'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );

  @override
  WidgetTreeNodeData? build() => SemanticsData(
        child: ExcludeSemanticsData(
          child: SizedBoxData(
            child: CenterData(
              child: RichTextData(),
            ),
          ),
        ),
      );
}
