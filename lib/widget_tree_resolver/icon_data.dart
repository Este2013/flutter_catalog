import 'package:flutter/material.dart';
import 'package:flutter_catalog/material/theme_explanations_utils.dart';
import 'package:flutter_catalog/utils/better_widget_span.dart';
import 'package:flutter_catalog/widget_tree_resolver/basic_widgets_data.dart';
import 'package:flutter_catalog/widget_tree_resolver/semantics_data.dart';

import 'data.dart';

// // TODO: This is gpt-completed, need to double-check
/// An explicit, fully‑annotated representation of the widget tree that a
/// Material [Icon] builds at runtime, together with a mapping between the
/// public properties of [Icon] and the *exact* properties/fields that are fed
/// into its descendants.
///
/// Every entry in [parameters] describes **where** the value eventually lands,
/// and contains a *mini transformation pipeline* (`beforePassingToChildren`) so
/// you can quickly see how Flutter massages the developer‑supplied value before
/// it reaches the descendent render objects.
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
                    (
                      'IconTheme.of(context).size',
                      'https://api.flutter.dev/flutter/widgets/IconThemeData/size.html',
                    ),
                    (
                      'kDefaultFontSize',
                      'https://api.flutter.dev/flutter/painting/kDefaultFontSize-constant.html',
                    ),
                  ]),
                  WidgetPropertyDataConditionalModification(
                    renderConditionSpans: (_) => [
                      CWidgetSpan(child: LinkChip('applyTextScaling')),
                      TextSpan(text: ' is true'),
                    ],
                    ifTrue: WidgetPropertyDataModification(
                      (context) => [
                        TextSpan(text: 'Replace with '),
                        CWidgetSpan(
                          child: LinkChip(
                            'MediaQuery.textScalerOf(context).scale(size)',
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // ──────────────────────────────────────────────────────
            //   REQUIRED DATA (ICON GLYPH)
            // ──────────────────────────────────────────────────────
            // TODO Modify to show distribution to textstyle
            WidgetPropertyData(
              'icon',
              typeName: 'IconData?',
              dataLink: WidgetPropertyDataDirectLink(
                nameOfDestinationChildWidget: 'RichText',
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
                      CWidgetSpan(
                        child: LinkChip('String.fromCharCode(icon.codePoint)'),
                      ),
                      TextSpan(text: ' and distributed into TextStyle.'),
                    ],
                  ),
                ],
              ),
            ),

            // ──────────────────────────────────────────────────────
            //   COLOR & PAINT
            // ──────────────────────────────────────────────────────

            // COLOR
            WidgetPropertyData(
              'color',
              typeName: 'Color?',
              dataLink: WidgetPropertyDataLinkWithRenaming(
                'fontStyle',
                nameOfDestinationChildWidget: 'RichText',
                nameOfDestinationChildProperties: ['style'],
                beforePassingToChildren: [
                  // default/fallback value
                  WidgetPropertyDataFallback(fallbacks: [
                    (
                      'IconTheme.of(context).color',
                      'https://api.flutter.dev/flutter/widgets/IconThemeData/color.html',
                    ),
                  ]),

                  // multiply by theme opacity
                  WidgetPropertyDataModification(
                    (context) => [
                      TextSpan(text: 'Multiplied by '),
                      CWidgetSpan(
                        child: LinkChip('iconTheme.opacity'),
                      ),
                    ],
                  ),

                  // pack into TextStyle / foreground if blendMode supplied
                  WidgetPropertyDataPackaging(
                    packageType: 'TextStyle',
                    packageName: 'fontStyle',
                    packageDocsLink: null,
                    modifications: WidgetPropertyDataConditionalModification(
                      renderConditionSpans: (context) => [
                        CWidgetSpan(
                          child: LinkChip(
                            'blendMode',
                            link: 'https://api.flutter.dev/flutter/widgets/Icon/blendMode.html',
                          ),
                        ),
                        TextSpan(text: ' is not null'),
                      ],
                      ifTrue: WidgetPropertyDataModification(
                        (context) => [
                          TextSpan(text: 'foreground = Paint()'),
                          TextSpan(text: '\n  ..blendMode = blendMode!'),
                          TextSpan(text: '\n  ..color = iconColor;'),
                        ],
                      ),
                      ifFalse: WidgetPropertyDataModification(
                        (context) => [
                          TextSpan(text: 'color = iconColor'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // BLEND‑MODE (affects paint pipeline)
            WidgetPropertyData(
              'blendMode',
              typeName: 'BlendMode?',
              dataLink: WidgetPropertyDataLinkWithRenaming('fontStyle', nameOfDestinationChildWidget: 'RichText', nameOfDestinationChildProperties: [
                'style'
              ], beforePassingToChildren: [
                WidgetPropertyDataPackaging(
                    packageType: 'TextStyle',
                    packageName: 'fontStyle',
                    packageDocsLink: null,
                    modifications: WidgetPropertyDataConditionalModification(
                      renderConditionSpans: (_) => [TextSpan(text: 'blendMode is not null')],
                      ifTrue: WidgetPropertyDataModification(
                        (context) => [
                          TextSpan(text: 'foreground = Paint()'),
                          TextSpan(text: '\n  ..blendMode = blendMode'),
                          TextSpan(text: '\n  ..color = iconColor'),
                        ],
                      ),
                    ))
              ]),
            ),

            // TODO Change all to reflect addition to style
            // VARIABLE‑FONT AXES (FILL / WEIGHT / GRADE / OPTICAL‑SIZE)
            _fontVariations('fill', 'FILL'),
            _fontVariations('weight', 'wght'),
            _fontVariations('grade', 'GRAD'),
            _fontVariations('opticalSize', 'opsz'),

            // EFFECTS
            _themeFallbackAndStyle('shadows', 'List<Shadow>?', 'shadows'),

            // LAYOUT / DIRECTIONALITY
            WidgetPropertyData(
              'textDirection',
              typeName: 'TextDirection?',
              dataLink: WidgetPropertyDataDirectLink(
                nameOfDestinationChildWidget: 'RichText',
                nameOfDestinationChildProperties: ['textDirection'],
                beforePassingToChildren: [
                  WidgetPropertyDataFallback(fallbacks: [
                    (
                      'Directionality.of(context)',
                      'https://api.flutter.dev/flutter/widgets/Directionality/of.html',
                    ),
                  ]),
                ],
              ),
            ),

            // MEDIA‑QUERY‑AWARE
            WidgetPropertyData(
              'applyTextScaling',
              typeName: 'bool?',
              dataLink: WidgetPropertyDataDirectLink(
                nameOfDestinationChildWidget: 'SizedBox',
                nameOfDestinationChildProperties: ['height', 'width'],
                beforePassingToChildren: [
                  WidgetPropertyDataFallback(fallbacks: [
                    (
                      'IconTheme.of(context).applyTextScaling',
                      'https://api.flutter.dev/flutter/widgets/IconThemeData/applyTextScaling.html',
                    ),
                    ('false', null),
                  ]),
                  WidgetPropertyDataModification(
                    (context) => [
                      TextSpan(text: 'When true, final size is scaled by '),
                      CWidgetSpan(
                        child: LinkChip(
                          'MediaQuery.textScalerOf(context)',
                          link: 'https://api.flutter.dev/flutter/widgets/MediaQuery/textScalerOf.html',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );

  // -------------------------------------------------------------------------
  //   BUILD:  produce the *widget tree* that an <Icon> ultimately expands to.
  // -------------------------------------------------------------------------
  @override
  WidgetTreeNodeData? build() => SemanticsData(
        child: ExcludeSemanticsData(
          child: SizedBoxData(
            child: CenterData(
                child: ConditionalWidgetTreeNodeData(
              condition: [
                CWidgetSpan(child: LinkChip.ofWidgetProperty('IconData', 'matchTextDirection', customDisplay: 'icon.matchTextDirection')),
                TextSpan(text: ' and '),
                CWidgetSpan(child: LinkChip.ofWidgetProperty('Icon', 'textDirection')),
                TextSpan(text: ' ?? '),
                CWidgetSpan(child: LinkChip('Directionality.of(context)')),
                TextSpan(text: ' equals '),
                CWidgetSpan(child: LinkChip('TextDirection.rtl')),
              ],
              defaultCondition: false,
              child: TransformData(child: RichTextData()),
              ifFalse: RichTextData(),
            )),
          ),
        ),
      );
}

WidgetPropertyData _fontVariations(String propertyName, String addedValue) => WidgetPropertyData(
      propertyName,
      typeName: 'double?',
      dataLink: WidgetPropertyDataLinkWithRenaming(
        'fontStyle',
        nameOfDestinationChildWidget: 'RichText',
        nameOfDestinationChildProperties: ['style'],
        beforePassingToChildren: [
          WidgetPropertyDataFallback(fallbacks: [
            (
              'IconTheme.of(context).$propertyName',
              'https://api.flutter.dev/flutter/widgets/IconThemeData/$propertyName.html',
            ),
          ]),
          _addIntoTextStylesFontVariations(propertyName, addedValue),
        ],
      ),
    );

/// For FILL, wght, GRAD, and opsz
WidgetPropertyDataPackaging _addIntoTextStylesFontVariations(String propertyName, String addedValue) => WidgetPropertyDataPackaging(
      packageType: 'TextStyle',
      packageName: 'fontStyle',
      packageDocsLink: null,
      modifications: WidgetPropertyDataConditionalModification(
        renderConditionSpans: (context) => [
          CWidgetSpan(
            child: LinkChip(
              propertyName,
              link: 'https://api.flutter.dev/flutter/widgets/Icon/$propertyName.html',
            ),
          ),
          TextSpan(text: ' is not null'),
        ],
        ifTrue: WidgetPropertyDataModification((context) => [TextSpan(text: "Add FontVariation('$addedValue', $propertyName) to fontVariations")]),
      ),
    );

WidgetPropertyData _themeFallbackAndStyle(String propertyName, String propertyType, String target) => WidgetPropertyData(
      propertyName,
      typeName: propertyType,
      dataLink: WidgetPropertyDataLinkWithRenaming(
        'fontStyle',
        nameOfDestinationChildWidget: 'RichText',
        nameOfDestinationChildProperties: ['style'],
        beforePassingToChildren: [
          WidgetPropertyDataFallback(fallbacks: [
            (
              'IconTheme.of(context).$propertyName',
              'https://api.flutter.dev/flutter/widgets/IconThemeData/$propertyName.html',
            ),
          ]),
          _addIntoTextStyle(propertyName, target),
        ],
      ),
    );

WidgetPropertyDataPackaging _addIntoTextStyle(String propertyName, String target) => WidgetPropertyDataPackaging(
      packageType: 'TextStyle',
      packageName: 'fontStyle',
      packageDocsLink: null,
      modifications: WidgetPropertyDataModification(
        (context) => [
          TextSpan(text: '$target = '),
          CWidgetSpan(
            child: LinkChip.ofWidgetProperty('Icon', propertyName),
          )
        ],
      ),
    );
