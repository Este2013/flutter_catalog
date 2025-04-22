import 'dart:math';

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
                        Text(
                          "Optional size constraints for the button.",
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
                        Text('If not provided, defaults to:'),
                        InsetDisplay(icon: Icon(Icons.code), content: Text("""const BoxConstraints(
  minWidth: kMinInteractiveDimension,
  minHeight: kMinInteractiveDimension,
)""")),
                        Text('Where kMinInteractiveDimension is $kMinInteractiveDimension, and then with visual density applied.'),
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
                      body: TabBarView(children: [
                        Placeholder(),
                        Placeholder(),
                        Placeholder(),
                        Placeholder(),
                        Placeholder(),
                        Placeholder(),
                      ]),
                    ),
                  ),
                  // Enable feedback
                  Placeholder(),
                  // TODO the rest here
                  // Icon size
                  Placeholder(),
                  // Mouse Cursor
                  Placeholder(),
                  // Padding
                  Placeholder(),
                  // Splash radius
                  Placeholder(),
                  // Visual density
                  Placeholder(),
                  // TODO: style property?
                ],
              ),
            ),
          ),
        ),
      );
}
