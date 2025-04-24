import 'package:flutter/material.dart';
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
          builder: (context) => Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Text('Theming'),
              bottom: TabBar(
                controller: tabController,
                tabs: [
                  Tab(icon: Icon(Symbols.align_horizontal_left), child: Text('Alignment')),
                  Tab(icon: Icon(Symbols.center_focus_strong), child: Text('Autofocus')),
                  Tab(icon: Icon(Symbols.resize), child: Text('Constraints')),
                  Tab(icon: Icon(Symbols.colorize), child: Text('Colors')),
                  Tab(icon: Icon(Symbols.feedback), child: Text('Enable feedback', textAlign: TextAlign.center)),
                  Tab(icon: Icon(Symbols.photo_size_select_large), child: Text('Icon size', textAlign: TextAlign.center)),
                  Tab(icon: Icon(Symbols.mouse), child: Text('Mouse cursor', textAlign: TextAlign.center)),
                  Tab(icon: Icon(Symbols.padding), child: Text('Padding', textAlign: TextAlign.center)),
                  Tab(icon: Icon(Symbols.radio_button_checked), child: Text('Splash radius', textAlign: TextAlign.center)),
                  Tab(icon: Icon(Symbols.density_small), child: Text('Visual density', textAlign: TextAlign.center)),
                ],
                isScrollable: true,
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: TabBarView(
                controller: tabController,
                children: [
                  // Alignment
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      spacing: 8,
                      children: [
                        Text(
                          "The alignment, once evaluated, positions the icon within the IconButton's padded area.",
                        ),
                        Divider(),
                        RichText(
                          text: TextSpan(
                            style: Theme.of(context).textTheme.bodyMedium,
                            children: [
                              TextSpan(text: 'Use provided '),
                              WidgetSpan(
                                alignment: PlaceholderAlignment.middle,
                                child: LinkChip('alignment', link: 'https://api.flutter.dev/flutter/material/IconButton/alignment.html'),
                              ),
                              TextSpan(text: ';'),
                            ],
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            style: Theme.of(context).textTheme.bodyMedium,
                            children: [
                              TextSpan(text: 'If not provided, use '),
                              WidgetSpan(
                                alignment: PlaceholderAlignment.middle,
                                child: ActionChip(
                                  label: Text('Alignment.center'),
                                  onPressed: () => launchUrl(
                                    Uri.parse('https://api.flutter.dev/flutter/painting/Alignment/center-constant.html'),
                                  ),
                                ),
                              ),
                              TextSpan(text: '.'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Autofocus
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      spacing: 8,
                      children: [
                        Text(
                          "True if this widget will be selected as the initial focus when no other node in its scope is currently focused.",
                        ),
                        Divider(),
                        RichText(
                          text: TextSpan(
                            style: Theme.of(context).textTheme.bodyMedium,
                            children: [
                              TextSpan(text: 'Use provided '),
                              WidgetSpan(
                                alignment: PlaceholderAlignment.middle,
                                child: LinkChip('autofocus', link: 'https://api.flutter.dev/flutter/material/IconButton/autofocus.html'),
                              ),
                              TextSpan(text: ';'),
                            ],
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            style: Theme.of(context).textTheme.bodyMedium,
                            children: [TextSpan(text: 'If not provided, defaults to false.')],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Constraints
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      spacing: 8,
                      children: [
                        Text("Optional size constraints for the button."),
                        Divider(),
                        RichText(
                          text: TextSpan(
                            style: Theme.of(context).textTheme.bodyMedium,
                            children: [
                              TextSpan(text: 'Use provided '),
                              WidgetSpan(
                                alignment: PlaceholderAlignment.middle,
                                child: LinkChip('constraints', link: 'https://api.flutter.dev/flutter/material/IconButton/constraints.html'),
                              ),
                              TextSpan(text: ';'),
                            ],
                          ),
                        ),
                        Text('If not provided, defaults to:'),
                        InsetDisplay(icon: Icon(Icons.code), content: Text("""const BoxConstraints(
  minWidth: kMinInteractiveDimension,
  minHeight: kMinInteractiveDimension,
)""")),
                        RichText(
                          text: TextSpan(
                            style: Theme.of(context).textTheme.bodyMedium,
                            children: [
                              TextSpan(text: 'Where '),
                              WidgetSpan(
                                alignment: PlaceholderAlignment.middle,
                                child: LinkChip('kMinInteractiveDimension', link: 'https://api.flutter.dev/flutter/material/kMinInteractiveDimension-constant.html'),
                              ),
                              TextSpan(text: ' is $kMinInteractiveDimension, and then with visual density applied.'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Colors
                  DefaultTabController(
                    length: 6,
                    child: Scaffold(
                      appBar: TabBar.secondary(
                        tabs: [
                          Tab(icon: Icon(Symbols.colorize), child: Text('color')),
                          Tab(icon: Icon(Symbols.disabled_by_default), child: Text('disabled')),
                          Tab(icon: Icon(Symbols.center_focus_strong), child: Text('focus')),
                          Tab(icon: Icon(Symbols.ink_highlighter), child: Text('highlight')),
                          Tab(icon: Icon(Symbols.highlight_mouse_cursor), child: Text('hover')),
                          Tab(icon: Icon(Symbols.water_drop), child: Text('splash')),
                        ],
                      ),
                      body: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TabBarView(children: [
                          Placeholder(),
                          Placeholder(),
                          Placeholder(),
                          Placeholder(),
                          Placeholder(),
                          SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              spacing: 8,
                              children: [
                                OnlyUsedWithMaterial3Warning(),
                                Divider(),
                                RichText(
                                  text: TextSpan(
                                    style: Theme.of(context).textTheme.bodyMedium,
                                    children: [
                                      TextSpan(text: 'Use provided '),
                                      WidgetSpan(
                                        alignment: PlaceholderAlignment.middle,
                                        child: LinkChip('splashColor', link: 'https://api.flutter.dev/flutter/material/IconButton/splashColor.html'),
                                      ),
                                      TextSpan(text: ';'),
                                    ],
                                  ),
                                ),
                                RichText(
                                  text: TextSpan(
                                    style: Theme.of(context).textTheme.bodyMedium,
                                    children: [
                                      TextSpan(text: 'If not provided, use '),
                                      WidgetSpan(
                                        alignment: PlaceholderAlignment.middle,
                                        child: LinkChip('Theme.of(context).splashColor', link: 'https://api.flutter.dev/flutter/material/ThemeData/splashColor.html'),
                                      ),
                                    ],
                                  ),
                                ),
                                InsetDisplay(
                                  content: RichText(
                                    text: TextSpan(
                                      style: Theme.of(context).textTheme.bodyMedium,
                                      children: [
                                        TextSpan(text: 'Defaults to '),
                                        WidgetSpan(
                                          alignment: PlaceholderAlignment.middle,
                                          child: ColorDisplayChip(Color(0x40CCCCCC)),
                                        ),
                                        TextSpan(text: ' in dark theme, and '),
                                        WidgetSpan(
                                          alignment: PlaceholderAlignment.middle,
                                          child: ColorDisplayChip(Color(0x66C8C8C8)),
                                        ),
                                        TextSpan(text: ' in light theme.'),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ]),
                      ),
                    ),
                  ),

                  // Enable feedback
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      spacing: 8,
                      children: [
                        Text("Whether detected gestures should provide acoustic and/or haptic feedback."),
                        Divider(),
                        ThemeUsesMaterial3ConditionStatement(),
                        ButtonStyleButtonPropertyExplanation(propertyName: 'enableFeedback', defaultsM3Value: 'true', finalDefault: 'true'),
                        RichText(
                          text: TextSpan(
                            style: Theme.of(context).textTheme.bodyMedium,
                            children: [
                              TextSpan(text: 'Otherwise, use provided '),
                              WidgetSpan(
                                alignment: PlaceholderAlignment.middle,
                                child: LinkChip('enableFeedback', link: 'https://api.flutter.dev/flutter/material/IconButton/enableFeedback.html'),
                              ),
                            ],
                          ),
                        ),
                        Text('If not provided: use true.'),
                      ],
                    ),
                  ),

                  // Icon size
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      spacing: 8,
                      children: [
                        Text("Whether detected gestures should provide acoustic and/or haptic feedback."),
                        Divider(),
                        ThemeUsesMaterial3ConditionStatement(),
                        ButtonStyleButtonPropertyExplanation(
                          propertyName: 'iconSize',
                          defaultsM3Value: '24.0',
                          finalDefault: '24.0',
                        ),
                        RichText(
                          text: TextSpan(
                            style: Theme.of(context).textTheme.bodyMedium,
                            children: [
                              TextSpan(text: 'Otherwise, use provided '),
                              WidgetSpan(
                                alignment: PlaceholderAlignment.middle,
                                child: LinkChip('iconSize', link: 'https://api.flutter.dev/flutter/material/IconButton/iconSize.html'),
                              ),
                            ],
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            style: Theme.of(context).textTheme.bodyMedium,
                            children: [
                              TextSpan(text: 'If not provided, use '),
                              WidgetSpan(
                                alignment: PlaceholderAlignment.middle,
                                child: LinkChip('IconTheme.of(context).size'),
                              ),
                            ],
                          ),
                        ),
                        Text('Otherwise, use 24.'),
                      ],
                    ),
                  ),

                  // Mouse Cursor
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      spacing: 8,
                      children: [
                        Text("The cursor for a mouse pointer when it enters or is hovering over the button."),
                        Divider(),
                        ThemeUsesMaterial3ConditionStatement(),
                        ButtonStyleButtonPropertyExplanation(propertyName: 'mouseCursor', defaultM3ValueWidgets: [
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
                                      WidgetSpan(alignment: PlaceholderAlignment.middle, child: LinkChip('MaterialState.disabled')),
                                      TextSpan(text: ', use '),
                                      WidgetSpan(alignment: PlaceholderAlignment.middle, child: LinkChip('SystemMouseCursors.basic')),
                                    ],
                                  ),
                                ),
                                RichText(
                                  text: TextSpan(
                                    style: Theme.of(context).textTheme.bodyMedium,
                                    children: [
                                      TextSpan(text: 'Otherwise, use '),
                                      WidgetSpan(alignment: PlaceholderAlignment.middle, child: LinkChip('SystemMouseCursors.click')),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        ]),
                        RichText(
                          text: TextSpan(
                            style: Theme.of(context).textTheme.bodyMedium,
                            children: [
                              TextSpan(text: 'Otherwise, use provided '),
                              WidgetSpan(
                                alignment: PlaceholderAlignment.middle,
                                child: LinkChip('mouseCursor', link: 'https://api.flutter.dev/flutter/material/IconButton/mouseCursor.html'),
                              ),
                            ],
                          ),
                        ),
                        Text('If not provided, use:'),
                        InsetDisplay(
                          content: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: 8,
                            children: [
                              RichText(
                                text: TextSpan(
                                  style: Theme.of(context).textTheme.bodyMedium,
                                  children: [
                                    TextSpan(text: 'If onPressed is null: '),
                                    WidgetSpan(alignment: PlaceholderAlignment.middle, child: LinkChip('SystemMouseCursors.basic')),
                                  ],
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                  style: Theme.of(context).textTheme.bodyMedium,
                                  children: [
                                    TextSpan(text: 'Otherwise: '),
                                    WidgetSpan(alignment: PlaceholderAlignment.middle, child: LinkChip('SystemMouseCursors.click')),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),

                  // Padding
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      spacing: 8,
                      children: [
                        Text("The padding around the button's icon. The entire padded icon will react to input gestures."),
                        Divider(),
                        ThemeUsesMaterial3ConditionStatement(),
                        ButtonStyleButtonPropertyExplanation(propertyName: 'padding', defaultsM3Value: 'EdgeInsets.all(8.0)'),
                        RichText(
                          text: TextSpan(
                            style: Theme.of(context).textTheme.bodyMedium,
                            children: [
                              TextSpan(text: 'Otherwise, use provided '),
                              WidgetSpan(
                                alignment: PlaceholderAlignment.middle,
                                child: LinkChip('padding', link: 'https://api.flutter.dev/flutter/material/IconButton/padding.html'),
                              ),
                            ],
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            style: Theme.of(context).textTheme.bodyMedium,
                            children: [
                              TextSpan(text: 'If not provided, use '),
                              WidgetSpan(alignment: PlaceholderAlignment.middle, child: LinkChip('EdgeInsets.all(8.0)')),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Splash radius
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      spacing: 8,
                      children: [
                        OnlyUsedWithMaterial3Warning(),
                        Divider(),
                        ThemeUsesMaterial3ConditionStatement(),
                        RichText(
                          text: TextSpan(
                            style: Theme.of(context).textTheme.bodyMedium,
                            children: [
                              TextSpan(text: 'Use provided '),
                              WidgetSpan(
                                alignment: PlaceholderAlignment.middle,
                                child: LinkChip('splashRadius', link: 'https://api.flutter.dev/flutter/material/IconButton/splashRadius.html'),
                              ),
                              TextSpan(text: ';'),
                            ],
                          ),
                        ),
                        Text('If not provided, use the bigger option between: '),
                        InsetDisplay(
                          icon: Icon(Symbols.keyboard_double_arrow_up),
                          content: Row(
                            children: [
                              Expanded(
                                  child: LinkChip('Material.defaultSplashRadius (${Material.defaultSplashRadius})',
                                      link: 'https://api.flutter.dev/flutter/material/Material/defaultSplashRadius-constant.html')),
                              Text(' or '),
                              Expanded(child: Text('(effectiveIconSize + math.min(effectivePadding.horizontal, effectivePadding.vertical)) * 0.7', textAlign: TextAlign.center))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Visual density
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      spacing: 8,
                      children: [
                        Text("Defines how compact the icon button's layout will be."),
                        Divider(),
                        ThemeUsesMaterial3ConditionStatement(),
                        ButtonStyleButtonPropertyExplanation(
                          propertyName: 'visualDensity',
                          defaultsM3Value: 'VisualDensity.standard',
                        ),
                        RichText(
                          text: TextSpan(
                            style: Theme.of(context).textTheme.bodyMedium,
                            children: [
                              TextSpan(text: 'Otherwise, use provided '),
                              WidgetSpan(
                                alignment: PlaceholderAlignment.middle,
                                child: LinkChip('visualDensity', link: 'https://api.flutter.dev/flutter/material/IconButton/visualDensity.html'),
                              ),
                            ],
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            style: Theme.of(context).textTheme.bodyMedium,
                            children: [
                              TextSpan(text: 'If not provided, use '),
                              WidgetSpan(
                                alignment: PlaceholderAlignment.middle,
                                child: LinkChip('IconTheme.of(context).visualDensity'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // TODO: style property?
                ],
              ),
            ),
          ),
        ),
      );
}

class OnlyUsedWithMaterial3Warning extends StatelessWidget {
  const OnlyUsedWithMaterial3Warning({
    super.key,
  });

  @override
  Widget build(BuildContext context) => RichText(
        text: TextSpan(
          style: Theme.of(context).textTheme.bodyMedium,
          children: [
            WidgetSpan(
              alignment: PlaceholderAlignment.middle,
              child: Icon(Icons.warning_rounded, color: Theme.of(context).colorScheme.error),
            ),
            TextSpan(text: ' Is only in use if '),
            WidgetSpan(
              alignment: PlaceholderAlignment.middle,
              child: LinkChip('theme.useMaterial3 (${Theme.of(context).useMaterial3})', link: 'https://api.flutter.dev/flutter/material/ThemeData/useMaterial3.html'),
            ),
            TextSpan(text: ' is false.'),
          ],
        ),
      );
}

class ThemeUsesMaterial3ConditionStatement extends StatelessWidget {
  const ThemeUsesMaterial3ConditionStatement({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: Theme.of(context).textTheme.bodyMedium,
        children: [
          TextSpan(text: 'If '),
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: LinkChip('theme.useMaterial3 (${Theme.of(context).useMaterial3})', link: 'https://api.flutter.dev/flutter/material/ThemeData/useMaterial3.html'),
          ),
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
                WidgetSpan(alignment: PlaceholderAlignment.middle, child: LinkChip('style.$propertyName')),
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
                      WidgetSpan(
                        alignment: PlaceholderAlignment.middle,
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
                      WidgetSpan(
                        alignment: PlaceholderAlignment.middle,
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
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
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
