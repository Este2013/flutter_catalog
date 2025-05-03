import 'package:flutter/material.dart';
import 'package:flutter_catalog/utils/better_widget_span.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../theme_explanations_utils.dart';

class IconButtonThemeExplanation extends StatefulWidget {
  const IconButtonThemeExplanation({
    super.key,
  });

  @override
  State<IconButtonThemeExplanation> createState() => _IconButtonThemeExplanationState();
}

class _IconButtonThemeExplanationState extends State<IconButtonThemeExplanation> with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 10, vsync: this);
  }

  @override
  Widget build(BuildContext context) => Navigator(
        onGenerateRoute: (settings) => MaterialPageRoute(
            builder: (context) => ClassThemingExplanationView(
                className: 'IconButton',
                baseDocsUrl: 'https://api.flutter.dev/flutter/material/IconButton',
                propertiesData: PropertyGroupData(
                  content: {
                    'Alignment': PropertyData(
                      'alignment',
                      icon: Icon(Symbols.align_horizontal_left),
                      shortExplanation: "Positions the icon within the IconButton's padded area.",
                      children: [
                        RichText(
                          text: TextSpan(
                            style: Theme.of(context).textTheme.bodyMedium,
                            children: [
                              TextSpan(text: 'Use provided '),
                              LinkChip.ofMaterialProperty('IconButton', 'alignment').asSpan(),
                              TextSpan(text: ';'),
                            ],
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            style: Theme.of(context).textTheme.bodyMedium,
                            children: [
                              TextSpan(text: 'If not provided, use '),
                              LinkChip('Alignment.center', link: 'https://api.flutter.dev/flutter/painting/Alignment/center-constant.html').asSpan(),
                              TextSpan(text: '.'),
                            ],
                          ),
                        ),
                      ],
                    ),
                    'Autofocus': PropertyData(
                      'autofocus',
                      icon: Icon(Symbols.center_focus_strong),
                      shortExplanation: "True if this widget will be selected as the initial focus when no other node in its scope is currently focused.",
                      children: [
                        RichText(
                          text: TextSpan(
                            style: Theme.of(context).textTheme.bodyMedium,
                            children: [
                              TextSpan(text: 'Use provided '),
                              LinkChip.ofMaterialProperty('IconButton', 'autofocus').asSpan(),
                              TextSpan(text: ';'),
                            ],
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            style: Theme.of(context).textTheme.bodyMedium,
                            children: [
                              TextSpan(text: 'If not provided, defaults to false.'),
                            ],
                          ),
                        ),
                      ],
                    ),
                    'Constraints': PropertyData(
                      'constraints',
                      icon: Icon(Symbols.resize),
                      shortExplanation: "Optional size constraints for the button.",
                      children: [
                        RichText(
                          text: TextSpan(
                            style: Theme.of(context).textTheme.bodyMedium,
                            children: [
                              TextSpan(text: 'Use provided '),
                              LinkChip.ofMaterialProperty('IconButton', 'constraints').asSpan(),
                              TextSpan(text: ';'),
                            ],
                          ),
                        ),
                        Text('If not provided, defaults to:'),
                        InsetDisplay(
                          icon: Icon(Icons.code),
                          content: Text(
                            '''const BoxConstraints(
  minWidth: kMinInteractiveDimension,
  minHeight: kMinInteractiveDimension,
)''',
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            style: Theme.of(context).textTheme.bodyMedium,
                            children: [
                              TextSpan(text: 'Where '),
                              CWidgetSpan(
                                child: LinkChip(
                                  'kMinInteractiveDimension',
                                  link: 'https://api.flutter.dev/flutter/material/kMinInteractiveDimension-constant.html',
                                ),
                              ),
                              TextSpan(
                                text: ' is $kMinInteractiveDimension, and then with visual density applied.',
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    'Colors': PropertyGroupData(
                      groupName: 'Colors',
                      icon: Icon(Symbols.colorize),
                      content: {
                        'Color': PropertyData(
                          'color',
                          icon: Icon(Symbols.colorize),
                          shortExplanation: "The color to use for the icon inside the button, if the icon is enabled.",
                          children: [
                            ThemeUsesMaterial3ConditionStatement(),
                            InsetDisplayColumn(
                              children: [
                                CRichText(
                                  context,
                                  children: [
                                    TextSpan(text: 'Use provided '),
                                    LinkChip('style.foregroundColor').asSpan(),
                                  ],
                                ),
                                CRichText(
                                  context,
                                  children: [
                                    TextSpan(text: 'If not provided, use given '),
                                    CWidgetSpan(
                                      child: LinkChip(
                                        'color',
                                        link: 'https://api.flutter.dev/flutter/material/IconButton/color.html',
                                      ),
                                    ),
                                  ],
                                ),
                                const Text('Otherwise, Icon widget will decide.'),
                              ],
                            ),
                            CRichText(
                              context,
                              children: [
                                TextSpan(text: 'If not provided, use given '),
                                LinkChip.ofMaterialProperty('IconButton', 'color').asSpan(),
                              ],
                            ),
                            const Text('Otherwise, Icon widget will decide.'),
                          ],
                        ),
                        'Disabled color': PropertyData(
                          'disabledColor',
                          icon: Icon(Symbols.disabled_by_default),
                          shortExplanation: "The color to use for the icon inside the button, if the icon is disabled.",
                          children: [
                            ThemeUsesMaterial3ConditionStatement(),
                            InsetDisplayColumn(
                              children: [
                                CRichText(
                                  context,
                                  children: [
                                    TextSpan(text: 'Use provided '),
                                    CWidgetSpan(
                                      child: LinkChip('style.disabledForegroundColor'),
                                    ),
                                  ],
                                ),
                                CRichText(
                                  context,
                                  children: [
                                    TextSpan(text: 'If not provided, use given '),
                                    CWidgetSpan(
                                      child: LinkChip(
                                        'disabledColor',
                                        link: 'https://api.flutter.dev/flutter/material/IconButton/disabledColor.html',
                                      ),
                                    ),
                                  ],
                                ),
                                CRichText(
                                  context,
                                  children: [
                                    TextSpan(text: 'Otherwise, default to '),
                                    CWidgetSpan(
                                      child: LinkChip(
                                        'ThemeData.disabledColor',
                                        link: 'https://api.flutter.dev/flutter/material/ThemeData/disabledColor.html',
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            CRichText(
                              context,
                              children: [
                                TextSpan(text: 'Else, use given '),
                                CWidgetSpan(
                                  child: LinkChip(
                                    'disabledColor',
                                    link: 'https://api.flutter.dev/flutter/material/IconButton/disabledColor.html',
                                  ),
                                ),
                              ],
                            ),
                            CRichText(
                              context,
                              children: [
                                TextSpan(text: 'Otherwise, default to '),
                                CWidgetSpan(
                                  child: LinkChip(
                                    'ThemeData.disabledColor',
                                    link: 'https://api.flutter.dev/flutter/material/ThemeData/disabledColor.html',
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        'FocusColor': PropertyData(
                          'focusColor',
                          icon: Icon(Symbols.center_focus_strong),
                          shortExplanation: 'The color for the button when it has the input focus.',
                          children: [
                            ThemeUsesMaterial3ConditionStatement(),
                            InsetDisplayColumn(
                              children: [
                                RichText(
                                  text: TextSpan(
                                    style: Theme.of(context).textTheme.bodyMedium,
                                    children: [
                                      TextSpan(text: 'Use provided '),
                                      CWidgetSpan(
                                        child: LinkChip('style.focusColor'),
                                      ),
                                    ],
                                  ),
                                ),
                                RichText(
                                  text: TextSpan(
                                    style: Theme.of(context).textTheme.bodyMedium,
                                    children: [
                                      TextSpan(text: 'If not provided, use given '),
                                      CWidgetSpan(
                                        child: LinkChip(
                                          'focusColor',
                                          link: 'https://api.flutter.dev/flutter/material/IconButton/focusColor.html',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                RichText(
                                  text: TextSpan(
                                    style: Theme.of(context).textTheme.bodyMedium,
                                    children: [
                                      TextSpan(text: 'Otherwise, default to '),
                                      CWidgetSpan(
                                        child: LinkChip(
                                          'ThemeData.focusColor',
                                          link: 'https://api.flutter.dev/flutter/material/ThemeData/focusColor.html',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            RichText(
                              text: TextSpan(
                                style: Theme.of(context).textTheme.bodyMedium,
                                children: [
                                  TextSpan(text: 'If not provided, use given '),
                                  CWidgetSpan(
                                    child: LinkChip(
                                      'focusColor',
                                      link: 'https://api.flutter.dev/flutter/material/IconButton/focusColor.html',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                style: Theme.of(context).textTheme.bodyMedium,
                                children: [
                                  TextSpan(text: 'Otherwise, default to '),
                                  CWidgetSpan(
                                    child: LinkChip(
                                      'ThemeData.focusColor',
                                      link: 'https://api.flutter.dev/flutter/material/ThemeData/focusColor.html',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        'HighlightColor': PropertyData(
                          'highlightColor',
                          icon: Icon(Symbols.ink_highlighter),
                          shortExplanation: 'Color of the button when in the down (pressed) state.',
                          children: [
                            ThemeUsesMaterial3ConditionStatement(),
                            InsetDisplayColumn(
                              children: [
                                RichText(
                                  text: TextSpan(
                                    style: Theme.of(context).textTheme.bodyMedium,
                                    children: [
                                      TextSpan(text: 'Use provided '),
                                      CWidgetSpan(
                                        child: LinkChip('style.highlightColor'),
                                      ),
                                    ],
                                  ),
                                ),
                                RichText(
                                  text: TextSpan(
                                    style: Theme.of(context).textTheme.bodyMedium,
                                    children: [
                                      TextSpan(text: 'If not provided, use given '),
                                      CWidgetSpan(
                                        child: LinkChip(
                                          'highlightColor',
                                          link: 'https://api.flutter.dev/flutter/material/IconButton/highlightColor.html',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                RichText(
                                  text: TextSpan(
                                    style: Theme.of(context).textTheme.bodyMedium,
                                    children: [
                                      TextSpan(text: 'Otherwise, default to '),
                                      CWidgetSpan(
                                        child: LinkChip(
                                          'ThemeData.highlightColor',
                                          link: 'https://api.flutter.dev/flutter/material/ThemeData/highlightColor.html',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            RichText(
                              text: TextSpan(
                                style: Theme.of(context).textTheme.bodyMedium,
                                children: [
                                  TextSpan(text: 'If not provided, use given '),
                                  CWidgetSpan(
                                    child: LinkChip(
                                      'highlightColor',
                                      link: 'https://api.flutter.dev/flutter/material/IconButton/highlightColor.html',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                style: Theme.of(context).textTheme.bodyMedium,
                                children: [
                                  TextSpan(text: 'Otherwise, default to '),
                                  CWidgetSpan(
                                    child: LinkChip(
                                      'ThemeData.highlightColor',
                                      link: 'https://api.flutter.dev/flutter/material/ThemeData/highlightColor.html',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        'HoverColor': PropertyData(
                          'hoverColor',
                          icon: Icon(Symbols.highlight_mouse_cursor),
                          shortExplanation: 'Color of the button when a pointer is hovering it.',
                          children: [
                            ThemeUsesMaterial3ConditionStatement(),
                            InsetDisplayColumn(
                              children: [
                                CRichText(
                                  context,
                                  children: [
                                    TextSpan(text: 'Use provided '),
                                    CWidgetSpan(
                                      child: LinkChip('style.hoverColor'),
                                    ),
                                  ],
                                ),
                                CRichText(
                                  context,
                                  children: [
                                    TextSpan(text: 'If not provided, use given '),
                                    CWidgetSpan(
                                      child: LinkChip(
                                        'hoverColor',
                                        link: 'https://api.flutter.dev/flutter/material/IconButton/hoverColor.html',
                                      ),
                                    ),
                                  ],
                                ),
                                CRichText(
                                  context,
                                  children: [
                                    TextSpan(text: 'Otherwise, default to '),
                                    CWidgetSpan(
                                      child: LinkChip(
                                        'ThemeData.hoverColor',
                                        link: 'https://api.flutter.dev/flutter/material/ThemeData/hoverColor.html',
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            CRichText(
                              context,
                              children: [
                                TextSpan(text: 'If not provided, use given '),
                                CWidgetSpan(
                                  child: LinkChip(
                                    'hoverColor',
                                    link: 'https://api.flutter.dev/flutter/material/IconButton/hoverColor.html',
                                  ),
                                ),
                              ],
                            ),
                            CRichText(
                              context,
                              children: [
                                TextSpan(text: 'Otherwise, default to '),
                                CWidgetSpan(
                                  child: LinkChip(
                                    'ThemeData.hoverColor',
                                    link: 'https://api.flutter.dev/flutter/material/ThemeData/hoverColor.html',
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        'SplashColor': PropertyData(
                          'splashColor',
                          icon: Icon(Symbols.water_drop),
                          onlyUsedWithMaterial3Warning: false,
                          children: [
                            CRichText(
                              context,
                              children: [
                                TextSpan(text: 'Use provided '),
                                CWidgetSpan(
                                  child: LinkChip(
                                    'splashColor',
                                    link: 'https://api.flutter.dev/flutter/material/IconButton/splashColor.html',
                                  ),
                                ),
                                TextSpan(text: ';'),
                              ],
                            ),
                            CRichText(
                              context,
                              children: [
                                TextSpan(text: 'If not provided, use '),
                                CWidgetSpan(
                                  child: LinkChip(
                                    'Theme.of(context).splashColor',
                                    link: 'https://api.flutter.dev/flutter/material/ThemeData/splashColor.html',
                                  ),
                                ),
                              ],
                            ),
                            InsetDisplay(
                              content: RichText(
                                text: TextSpan(
                                  style: Theme.of(context).textTheme.bodyMedium,
                                  children: [
                                    TextSpan(text: 'Defaults to '),
                                    CWidgetSpan(
                                      child: ColorDisplayChip(Color(0x40CCCCCC)),
                                    ),
                                    TextSpan(text: ' in dark theme, and '),
                                    CWidgetSpan(
                                      child: ColorDisplayChip(Color(0x66C8C8C8)),
                                    ),
                                    TextSpan(text: ' in light theme.'),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      },
                    ),
                    'EnableFeedback': PropertyData(
                      'enableFeedback',
                      icon: Icon(Symbols.feedback),
                      shortExplanation: "Whether detected gestures should provide acoustic and/or haptic feedback.",
                      children: [
                        ThemeUsesMaterial3ConditionStatement(),
                        ButtonStyleButtonPropertyExplanation(
                          propertyName: 'enableFeedback',
                          defaultsM3Value: 'true',
                          finalDefault: 'true',
                        ),
                        CRichText(
                          context,
                          children: [
                            TextSpan(text: 'Otherwise, use provided '),
                            CWidgetSpan(
                              child: LinkChip(
                                'enableFeedback',
                                link: 'https://api.flutter.dev/flutter/material/IconButton/enableFeedback.html',
                              ),
                            ),
                          ],
                        ),
                        Text('If not provided: use true.'),
                      ],
                    ),
                    'IconSize': PropertyData(
                      'iconSize',
                      icon: Icon(Symbols.photo_size_select_large),
                      shortExplanation: "The size of the icon inside the button.",
                      children: [
                        ThemeUsesMaterial3ConditionStatement(),
                        ButtonStyleButtonPropertyExplanation(
                          propertyName: 'iconSize',
                          defaultsM3Value: '24.0',
                          finalDefault: '24.0',
                        ),
                        CRichText(
                          context,
                          children: [
                            TextSpan(text: 'Otherwise, use provided '),
                            CWidgetSpan(
                              child: LinkChip(
                                'iconSize',
                                link: 'https://api.flutter.dev/flutter/material/IconButton/iconSize.html',
                              ),
                            ),
                          ],
                        ),
                        CRichText(
                          context,
                          children: [
                            TextSpan(text: 'If not provided, use '),
                            CWidgetSpan(
                              child: LinkChip('IconTheme.of(context).size'),
                            ),
                          ],
                        ),
                        Text('Otherwise, use 24.'),
                      ],
                    ),
                    'MouseCursor': PropertyData(
                      'mouseCursor',
                      icon: Icon(Symbols.mouse),
                      shortExplanation: "The cursor for a mouse pointer when it enters or is hovering over the button.",
                      children: [
                        ThemeUsesMaterial3ConditionStatement(),
                        ButtonStyleButtonPropertyExplanation(
                          propertyName: 'mouseCursor',
                          defaultM3ValueWidgets: [
                            InsetDisplay(
                              content: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: 8,
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      style: Theme.of(context).textTheme.bodyMedium,
                                      children: [
                                        TextSpan(text: 'If widget has state '),
                                        CWidgetSpan(
                                          child: LinkChip('MaterialState.disabled'),
                                        ),
                                        TextSpan(text: ', use '),
                                        CWidgetSpan(
                                          child: LinkChip('SystemMouseCursors.basic'),
                                        ),
                                      ],
                                    ),
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      style: Theme.of(context).textTheme.bodyMedium,
                                      children: [
                                        TextSpan(text: 'Otherwise, use '),
                                        CWidgetSpan(
                                          child: LinkChip('SystemMouseCursors.click'),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        CRichText(
                          context,
                          children: [
                            TextSpan(text: 'Otherwise, use provided '),
                            CWidgetSpan(
                              child: LinkChip(
                                'mouseCursor',
                                link: 'https://api.flutter.dev/flutter/material/IconButton/mouseCursor.html',
                              ),
                            ),
                          ],
                        ),
                        const Text('If not provided, use:'),
                        InsetDisplay(
                          content: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: 8,
                            children: [
                              CRichText(
                                context,
                                children: [
                                  TextSpan(text: 'If onPressed is null: '),
                                  CWidgetSpan(
                                    child: LinkChip('SystemMouseCursors.basic'),
                                  ),
                                ],
                              ),
                              CRichText(
                                context,
                                children: [
                                  TextSpan(text: 'Otherwise: '),
                                  CWidgetSpan(
                                    child: LinkChip('SystemMouseCursors.click'),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    'Padding': PropertyData(
                      'padding',
                      icon: Icon(Symbols.padding),
                      shortExplanation: "The padding around the button's icon. The entire padded icon will react to input gestures.",
                      children: [
                        ThemeUsesMaterial3ConditionStatement(),
                        ButtonStyleButtonPropertyExplanation(
                          propertyName: 'padding',
                          defaultsM3Value: 'EdgeInsets.all(8.0)',
                        ),
                        CRichText(
                          context,
                          children: [
                            TextSpan(text: 'Otherwise, use provided '),
                            CWidgetSpan(
                              child: LinkChip(
                                'padding',
                                link: 'https://api.flutter.dev/flutter/material/IconButton/padding.html',
                              ),
                            ),
                          ],
                        ),
                        CRichText(
                          context,
                          children: [
                            TextSpan(text: 'If not provided, use '),
                            CWidgetSpan(
                              child: LinkChip('EdgeInsets.all(8.0)'),
                            ),
                          ],
                        ),
                      ],
                    ),
                    'SplashRadius': PropertyData(
                      'splashRadius',
                      icon: Icon(Symbols.radio_button_checked),
                      onlyUsedWithMaterial3Warning: false,
                      children: [
                        CRichText(
                          context,
                          children: [
                            TextSpan(text: 'Use provided '),
                            CWidgetSpan(
                              child: LinkChip(
                                'splashRadius',
                                link: 'https://api.flutter.dev/flutter/material/IconButton/splashRadius.html',
                              ),
                            ),
                            TextSpan(text: ';'),
                          ],
                        ),
                        const Text('If not provided, use the bigger option between:'),
                        InsetDisplay(
                          icon: Icon(Symbols.keyboard_double_arrow_up),
                          content: Row(
                            children: [
                              Expanded(
                                child: LinkChip(
                                  'Material.defaultSplashRadius (${Material.defaultSplashRadius})',
                                  link: 'https://api.flutter.dev/flutter/material/Material/defaultSplashRadius-constant.html',
                                ),
                              ),
                              const Text(' or '),
                              Expanded(
                                child: Text(
                                  '(effectiveIconSize + math.min(effectivePadding.horizontal, '
                                  'effectivePadding.vertical)) * 0.7',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    'VisualDensity': PropertyData(
                      'visualDensity',
                      icon: Icon(Symbols.density_small),
                      shortExplanation: "Defines how compact the icon button's layout will be.",
                      children: [
                        ThemeUsesMaterial3ConditionStatement(),
                        ButtonStyleButtonPropertyExplanation(
                          propertyName: 'visualDensity',
                          defaultsM3Value: 'VisualDensity.standard',
                        ),
                        CRichText(
                          context,
                          children: [
                            TextSpan(text: 'Otherwise, use provided '),
                            CWidgetSpan(
                              child: LinkChip(
                                'visualDensity',
                                link: 'https://api.flutter.dev/flutter/material/IconButton/visualDensity.html',
                              ),
                            ),
                          ],
                        ),
                        CRichText(
                          context,
                          children: [
                            TextSpan(text: 'If not provided, use '),
                            CWidgetSpan(
                              child: LinkChip('IconTheme.of(context).visualDensity'),
                            ),
                          ],
                        ),
                      ],
                    ),

                    // TODO style?
                  },
                ))),
      );
}

class ThemeUsesMaterial3ConditionStatement extends StatelessWidget {
  const ThemeUsesMaterial3ConditionStatement({
    super.key,
    this.invertStatement = false,
  });

  final bool invertStatement;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: Theme.of(context).textTheme.bodyMedium,
        children: [
          TextSpan(text: 'If '),
          CWidgetSpan(
            child: LinkChip('theme.useMaterial3 (${Theme.of(context).useMaterial3})', link: 'https://api.flutter.dev/flutter/material/ThemeData/useMaterial3.html'),
          ),
          if (invertStatement) TextSpan(text: ' is false'),
          TextSpan(text: ':'),
        ],
      ),
    );
  }
}

class ButtonStyleButtonPropertyExplanation extends StatelessWidget {
  const ButtonStyleButtonPropertyExplanation({
    super.key,
    required this.propertyName,
    this.defaultsM3Value,
    this.finalDefault,
    this.defaultM3ValueWidgets,
  }) : assert((defaultsM3Value != null) ^ (defaultM3ValueWidgets != null));

  final String propertyName;
  final String? defaultsM3Value, finalDefault;
  final List<Widget>? defaultM3ValueWidgets;

  @override
  Widget build(BuildContext context) {
    return InsetDisplay(
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 8,
        children: [
          RichText(
            text: TextSpan(
              style: Theme.of(context).textTheme.bodyMedium,
              children: [
                TextSpan(text: 'Use provided '),
                CWidgetSpan(child: LinkChip('style.$propertyName')),
              ],
            ),
          ),
          Text('If not provided:'),
          InsetDisplay(
            content: Column(
              spacing: 8,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                RichText(
                  text: TextSpan(
                    style: Theme.of(context).textTheme.bodyMedium,
                    children: [
                      TextSpan(text: 'Use provided '),
                      CWidgetSpan(
                        child: LinkChip(propertyName, link: 'https://api.flutter.dev/flutter/material/IconButton/$propertyName.html'),
                      ),
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    style: Theme.of(context).textTheme.bodyMedium,
                    children: [
                      TextSpan(text: 'If not provided: use '),
                      CWidgetSpan(
                        child: LinkChip('IconButtonTheme.of(context).style.$propertyName'),
                      ),
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    style: Theme.of(context).textTheme.bodyMedium,
                    children: [
                      TextSpan(text: 'If not provided: use${defaultsM3Value != null ? ' ' : ':'}'),
                      if (defaultsM3Value != null)
                        CWidgetSpan(
                          child: LinkChip('_IconButtonDefaultsM3.$propertyName ($defaultsM3Value)"'),
                        ),
                    ],
                  ),
                ),
                if (defaultM3ValueWidgets != null) ...defaultM3ValueWidgets!,
                if (finalDefault != null) Text('Finally, in case something wrong happens, use $finalDefault.'),
              ],
            ),
          )
        ],
      ),
    );
  }
}
