import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_catalog/main.dart';
import 'package:flutter_catalog/material/color_scheme_page.dart';
import 'package:flutter_svg/svg.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:url_launcher/url_launcher.dart';

import 'actions.dart';
import 'icons_page.dart';
import 'layouts.dart';
import 'state_actions.dart';

class MaterialApplicationBody extends StatefulWidget {
  const MaterialApplicationBody({
    super.key,
  });

  @override
  State<MaterialApplicationBody> createState() => _MaterialApplicationBodyState();
}

class _MaterialApplicationBodyState extends State<MaterialApplicationBody> {
  String selectedPage = 'home';

  final List<String> pages = [
    'home',
    'layout',
    'actions',
    'state buttons',
    'forms',
  ];

  @override
  Widget build(BuildContext context) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SingleChildScrollView(
            child: IntrinsicHeight(
              child: AnimatedBuilder(
                  animation: appCtrl,
                  builder: (context, _) => NavigationRail(
                        extended: appCtrl.expandRail,
                        destinations: [
                          NavigationRailDestination(icon: Icon(Icons.home), label: Text('Home', style: Theme.of(context).textTheme.bodyLarge)),
                          NavigationRailDestination(icon: Icon(Symbols.dashboard, fill: 1), label: Text('Layout', style: Theme.of(context).textTheme.bodyLarge)),
                          NavigationRailDestination(icon: Icon(Symbols.touch_app, fill: 1), label: Text('Actions', style: Theme.of(context).textTheme.bodyLarge)),
                          NavigationRailDestination(icon: Icon(Symbols.check_box, fill: 1), label: Text('State Buttons', style: Theme.of(context).textTheme.bodyLarge)),
                          NavigationRailDestination(icon: Icon(Symbols.checklist_rtl, fill: 1), label: Text('Forms', style: Theme.of(context).textTheme.bodyLarge)),
                        ],
                        selectedIndex: pages.indexOf(selectedPage),
                        groupAlignment: -1,
                        onDestinationSelected: (value) => setState(() {
                          if (value < pages.length) {
                            selectedPage = pages[value];
                          } else {
                            showDialog(
                              context: context,
                              builder: (context) => SettingsDialog(),
                            );
                          }
                        }),
                      )),
            ),
          ),
          VerticalDivider(),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 32, right: 16, top: 16),
              child: Center(
                child: Builder(
                  builder: (context) {
                    if (selectedPage == 'home') {
                      return SingleChildScrollView(
                        child: Column(
                          spacing: 16,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              spacing: 16,
                              children: [
                                Text('Online resources', style: Theme.of(context).textTheme.titleLarge),
                                Expanded(child: Divider()),
                              ],
                            ),
                            Wrap(
                              children: [
                                Card(
                                  clipBehavior: Clip.hardEdge,
                                  child: InkWell(
                                    onTap: () => launchUrl(Uri.parse('https://docs.flutter.dev/ui/widgets')),
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 16, bottom: 16, left: 16, right: 22),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        spacing: 16,
                                        children: [
                                          FlutterLogo(
                                            size: 50,
                                          ),
                                          Text('Flutter widget catalog', style: Theme.of(context).textTheme.titleMedium),
                                          Icon(Icons.open_in_new),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Card(
                                  clipBehavior: Clip.hardEdge,
                                  child: InkWell(
                                    onTap: () => launchUrl(Uri.parse('https://docs.flutter.dev/ui/widgets/material')),
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 16, bottom: 16, left: 16, right: 22),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        spacing: 16,
                                        children: [
                                          FlutterLogo(
                                            size: 50,
                                          ),
                                          Text('Flutter material catalog', style: Theme.of(context).textTheme.titleMedium),
                                          Icon(Icons.open_in_new),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Card(
                                  clipBehavior: Clip.hardEdge,
                                  child: InkWell(
                                    onTap: () => launchUrl(Uri.parse('https://m3.material.io/')),
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 16, bottom: 16, left: 16, right: 22),
                                      child: Row(
                                        spacing: 16,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          SvgPicture.asset(
                                            'assets/logos/Google_Material_Design_Logo.svg',
                                            height: 50,
                                            semanticsLabel: 'Material Icon',
                                          ),
                                          Text('Material Design 3', style: Theme.of(context).textTheme.titleMedium),
                                          Icon(Icons.open_in_new),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              spacing: 16,
                              children: [
                                Text('Style', style: Theme.of(context).textTheme.titleLarge),
                                Expanded(child: Divider()),
                              ],
                            ),
                            Wrap(
                              children: [
                                Card(
                                  clipBehavior: Clip.hardEdge,
                                  child: InkWell(
                                    onTap: () => Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) => IconsPage(appCtrl: appCtrl)),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 16, bottom: 16, left: 16, right: 22),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        spacing: 16,
                                        children: [
                                          Icon(Icons.emoji_symbols, size: 50),
                                          Text('Material icons', style: Theme.of(context).textTheme.titleMedium),
                                          Icon(Icons.explore),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Card(
                                  clipBehavior: Clip.hardEdge,
                                  child: InkWell(
                                    onTap: () => Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) => ColorSchemePage(appCtrl: appCtrl)),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 16, bottom: 16, left: 16, right: 22),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        spacing: 16,
                                        children: [
                                          SizedBox.square(
                                            dimension: 50,
                                            child: GridView.count(
                                              mainAxisSpacing: 2,
                                              crossAxisSpacing: 2,
                                              crossAxisCount: 2,
                                              children: [
                                                for (var c in [
                                                  Theme.of(context).colorScheme.primary,
                                                  Theme.of(context).colorScheme.secondary,
                                                  Theme.of(context).colorScheme.tertiary,
                                                  Theme.of(context).colorScheme.inversePrimary,
                                                ])
                                                  Container(decoration: BoxDecoration(color: c, shape: BoxShape.circle)),
                                              ],
                                            ),
                                          ),
                                          Text('Color scheme', style: Theme.of(context).textTheme.titleMedium),
                                          Icon(Icons.explore),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              spacing: 16,
                              children: [
                                Text('Basic widgets', style: Theme.of(context).textTheme.titleLarge),
                                Expanded(child: Divider()),
                              ],
                            ),
                            Wrap(
                              children: [
                                WidgetPresentation(
                                  title: 'Text',
                                  variantsData: [
                                    WidgetVariantData(
                                      null,
                                      variantExplanation: 'A run of text with a single style.',
                                      iconBuilder: (p0) => Icon(Icons.text_fields),
                                      widgetBuilder: (p0, options) => Padding(
                                        padding: EdgeInsets.all(16),
                                        child: Text(
                                          'Lorem Ipsum\nLorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.',
                                          style: Theme.of(context).textTheme.titleMedium,
                                          textAlign: TextAlign.center,
                                          overflow: TextOverflow.fade,
                                        ),
                                      ),
                                    ),
                                    WidgetVariantData(
                                      'RichText',
                                      variantExplanation: 'Displays text with multiple styles. The text to display is described using a tree of TextSpan objects.',
                                      iconBuilder: (p0) => Icon(Symbols.format_color_text),
                                      widgetBuilder: (p0, options) => Padding(
                                        padding: EdgeInsets.all(16),
                                        child: RichText(
                                          text: TextSpan(children: [
                                            TextSpan(
                                              text: 'Lorem ✨Ipsum✨\n',
                                              style: Theme.of(context).textTheme.titleMedium,
                                            ),
                                            TextSpan(style: Theme.of(context).textTheme.bodyLarge, children: [
                                              TextSpan(text: 'Lorem ipsum dolor sit amet', style: TextStyle(fontStyle: FontStyle.italic)),
                                              TextSpan(text: ' consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. '),
                                              TextSpan(
                                                  style: TextStyle(color: Colors.amber),
                                                  text:
                                                      'At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, '),
                                              TextSpan(
                                                  text:
                                                      'sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum.'),
                                              TextSpan(text: ' Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.', style: TextStyle(fontWeight: FontWeight.bold))
                                            ])
                                          ]),
                                          textAlign: TextAlign.center,
                                          overflow: TextOverflow.fade,
                                        ),
                                      ),
                                    ),
                                    WidgetVariantData(
                                      'DefaultTextStyle',
                                      variantExplanation: "Defines the style of reference for all descendants Text widgets that do not have their own style.",
                                      iconBuilder: (p0) => Icon(Icons.style),
                                      widgetBuilder: (p0, options) => Padding(
                                        padding: EdgeInsets.all(16),
                                        child: DefaultTextStyle(
                                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontStyle: FontStyle.italic) ?? TextStyle(),
                                          textAlign: TextAlign.center,
                                          overflow: TextOverflow.fade,
                                          child: Text(
                                              'Lorem Ipsum\nLorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.'),
                                        ),
                                      ),
                                    ),
                                  ],
                                  link: 'https://docs.flutter.dev/ui/widgets/text',
                                ),
                                WidgetPresentation(
                                  title: 'Icon',
                                  variantsData: [
                                    WidgetVariantData(null,
                                        variantExplanation: 'A graphical icon widget drawn with a glyph from a font described in an IconData.',
                                        iconBuilder: (p0) => Icon(Symbols.emoji_symbols),
                                        widgetBuilder: (p0, options) => Padding(
                                              padding: EdgeInsets.all(16),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  Icon(Icons.star, color: Colors.amber.shade700),
                                                  Icon(Icons.music_note),
                                                  Icon(Icons.favorite, color: Colors.red),
                                                ],
                                              ),
                                            ),
                                        themeGraph: IconThemeGraph()),
                                  ],
                                  link: 'https://api.flutter.dev/flutter/widgets/Icon-class.html',
                                ),
                                WidgetPresentation(
                                  title: 'Container',
                                  presentationWindowAlignment: Alignment.center,
                                  presentationCardWidget: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 100,
                                        decoration: BoxDecoration(
                                            border: Border.all(color: Theme.of(context).colorScheme.primary, width: 5),
                                            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), topLeft: Radius.elliptical(30, 40)),
                                            gradient: LinearGradient(colors: [
                                              Theme.of(context).colorScheme.inversePrimary,
                                              Theme.of(context).colorScheme.onInverseSurface,
                                            ])),
                                        child: Center(child: Container(margin: EdgeInsets.only(top: 16, left: 20), width: 60, height: 40, color: Theme.of(context).colorScheme.secondary)),
                                      )
                                    ],
                                  ),
                                  variantsData: [
                                    WidgetVariantData(
                                      null,
                                      iconBuilder: (p0) => Icon(Icons.check_box_outline_blank_sharp),
                                      widgetBuilder: (p0, options) => Container(
                                        color: Colors.amber,
                                      ),
                                    ),
                                    WidgetVariantData(
                                      'Padding',
                                      iconBuilder: (p0) => Icon(Icons.check_box_outline_blank_sharp), // TODO this whole Continer presentation
                                      widgetBuilder: (p0, options) => ColoredBox(color: Theme.of(context).colorScheme.surfaceContainerLow),
                                    ),
                                  ],
                                  link:
                                      'https://api.flutter.dev/flutter/widgets/Container-class.html?_gl=1*owbzev*_ga*MjcwMTE3ODUwLjE3MjY1ODY0NjI.*_ga_04YGWK0175*MTc0MjU2MzcyNC4xMTEuMS4xNzQyNTcxMDkzLjAuMC4w',
                                )
                              ],
                            ),
                          ],
                        ),
                      );
                    }

                    if (selectedPage == 'layout') {
                      return LayoutsPresentationPage();
                    }
                    if (selectedPage == 'actions') {
                      return ActionsPresentationPage();
                    }
                    if (selectedPage == 'state buttons') {
                      return StateActionsPresentationPage();
                    }
                    return Placeholder();
                  },
                ),
              ),
            ),
          ),
        ],
      );
}

class IconThemeGraph extends StatefulWidget {
  const IconThemeGraph({
    super.key,
  });

  @override
  State<IconThemeGraph> createState() => _IconThemeGraphState();
}

class _IconThemeGraphState extends State<IconThemeGraph> with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) => Navigator(
        onGenerateRoute: (settings) => MaterialPageRoute(
          builder: (context) => Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Text('Theming'),
              bottom: TabBar(controller: tabController, tabs: [
                Tab(icon: Icon(Icons.colorize), child: Text('Color')),
                Tab(icon: Icon(Icons.gradient), child: Text('Fill')),
              ]),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: TabBarView(
                controller: tabController,
                children: [
                  // color
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      spacing: 8,
                      children: [
                        Text("The color, once evaluated, will be further adjusted by the nearest IconTheme's IconThemeData.opacity."),
                        Divider(),
                        RichText(
                          text: TextSpan(
                            style: Theme.of(context).textTheme.bodyMedium,
                            children: [
                              TextSpan(text: 'Use provided '),
                              WidgetSpan(
                                  alignment: PlaceholderAlignment.middle,
                                  child: ActionChip(
                                    label: Text('Color'),
                                    onPressed: () => launchUrl(Uri.parse('https://api.flutter.dev/flutter/dart-ui/Color-class.html')),
                                  ))
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
                                  label: Text('IconTheme.of(context).color'),
                                  // onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                                  //   builder: (context) => IconThemeDataExplorer(
                                  //     initPage: 'color',
                                  //   ),
                                  // )),
                                ),
                              )
                            ],
                          ),
                        ),
                        Row(
                          spacing: 8,
                          children: [
                            Padding(padding: EdgeInsets.only(left: 16), child: Transform.rotate(angle: pi, child: Icon(Symbols.reply))),
                            Flexible(
                              child: ConstrainedBox(
                                constraints: BoxConstraints(maxWidth: 1000),
                                child: Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      spacing: 8,
                                      children: [
                                        RichText(
                                          text: TextSpan(
                                            style: Theme.of(context).textTheme.bodyMedium,
                                            children: [
                                              TextSpan(text: 'If '),
                                              WidgetSpan(
                                                alignment: PlaceholderAlignment.middle,
                                                child: ActionChip(
                                                  label: Text('IconTheme.of'),
                                                  onPressed: () => launchUrl(Uri.parse('https://api.flutter.dev/flutter/widgets/IconTheme/of.html')),
                                                ),
                                              ),
                                              TextSpan(text: ' finds a surrounding IconTheme widget'),
                                            ],
                                          ),
                                        ),
                                        Row(
                                          spacing: 8,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(left: 16),
                                              child: Transform.rotate(angle: pi, child: Icon(Symbols.reply)),
                                            ),
                                            Flexible(
                                              child: ConstrainedBox(
                                                constraints: BoxConstraints(maxWidth: 1000),
                                                child: Card(
                                                  color: Theme.of(context).colorScheme.surfaceContainerHigh,
                                                  child: Padding(
                                                      padding: const EdgeInsets.all(16.0),
                                                      child: RichText(
                                                        text: TextSpan(
                                                          style: Theme.of(context).textTheme.bodyMedium,
                                                          children: [
                                                            TextSpan(text: 'Use corresponding '),
                                                            WidgetSpan(
                                                              alignment: PlaceholderAlignment.middle,
                                                              child: ActionChip(
                                                                label: Text('IconThemeData'),
                                                                onPressed: () => launchUrl(Uri.parse('https://api.flutter.dev/flutter/widgets/IconThemeData-class.html')),
                                                              ),
                                                            ),
                                                            TextSpan(text: '\'s color'),
                                                          ],
                                                        ),
                                                      )),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          spacing: 8,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(left: 16, top: 0),
                                              child: Icon(Symbols.info),
                                            ),
                                            Flexible(
                                              child: ConstrainedBox(
                                                constraints: BoxConstraints(maxWidth: 1000),
                                                child: Card(
                                                  color: Theme.of(context).colorScheme.surfaceContainerHigh,
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(16.0),
                                                    child: RichText(
                                                      text: TextSpan(
                                                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(height: 2.6),
                                                        children: [
                                                          TextSpan(text: 'In material apps, if there is a '),
                                                          WidgetSpan(
                                                              alignment: PlaceholderAlignment.middle,
                                                              child: ActionChip(
                                                                label: Text('Theme'),
                                                                onPressed: () => launchUrl(Uri.parse('https://api.flutter.dev/flutter/material/Theme-class.html')),
                                                              )),
                                                          TextSpan(text: ' without any IconThemes specified, icon colors default to:\n - '),
                                                          WidgetSpan(alignment: PlaceholderAlignment.middle, child: ColorDisplayChip(Colors.black)),
                                                          TextSpan(text: ' if ThemeData.brightness is light;\n - '),
                                                          WidgetSpan(alignment: PlaceholderAlignment.middle, child: ColorDisplayChip(Colors.white)),
                                                          TextSpan(text: ' if ThemeData.brightness is dark.'),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        RichText(
                                          text: TextSpan(style: Theme.of(context).textTheme.bodyMedium?.copyWith(height: 2.5), children: [
                                            TextSpan(text: 'Otherwise, use '),
                                            WidgetSpan(
                                              alignment: PlaceholderAlignment.middle,
                                              child: ActionChip(
                                                label: Text('IconThemeData.fallback()'),
                                                onPressed: () => launchUrl(Uri.parse('https://api.flutter.dev/flutter/widgets/IconThemeData/IconThemeData.fallback.html')),
                                              ),
                                            ),
                                            TextSpan(text: '\'s color: '),
                                            WidgetSpan(alignment: PlaceholderAlignment.middle, child: ColorDisplayChip(IconThemeData.fallback().color!)),
                                          ]),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // fill
                  Text('fill'),
                ],
              ),
            ),
          ),
        ),
      );
}

class IconThemeDataExplorer extends StatefulWidget {
  const IconThemeDataExplorer({super.key, this.initPage});

  final String? initPage;

  @override
  State<IconThemeDataExplorer> createState() => _IconThemeDataExplorerState();
}

class _IconThemeDataExplorerState extends State<IconThemeDataExplorer> with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    if (widget.initPage != null) {
      if (widget.initPage == 'color') {
        tabController.index = 0;
      }
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('IconThemeData'),
          bottom: TabBar(controller: tabController, tabs: [
            Tab(icon: Icon(Icons.colorize), child: Text('Color')),
            Tab(icon: Icon(Icons.gradient), child: Text('Fill')),
          ]),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: TabBarView(
            controller: tabController,
            children: [
              // color
              Column(
                spacing: 8,
                children: [
                  Row(
                    spacing: 8,
                    children: [
                      Text('Use provided'),
                      ActionChip(
                        label: Text('Color'),
                        onPressed: () => launchUrl(Uri.parse('https://api.flutter.dev/flutter/dart-ui/Color-class.html')),
                      ),
                    ],
                  ),
                ],
              ),
              // fill
              Text('fill'),
            ],
          ),
        ),
      );
}

class ColorDisplayChip extends StatelessWidget {
  const ColorDisplayChip(
    this.color, {
    super.key,
  });

  final Color color;

  @override
  Widget build(BuildContext context) => Chip(
        avatar: Container(
          height: Theme.of(context).textTheme.bodyMedium?.fontSize ?? 14,
          width: Theme.of(context).textTheme.bodyMedium?.fontSize ?? 14,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            border: Border.all(color: Theme.of(context).dividerColor),
          ),
        ),
        label: Text(color.toHex()),
      );
}

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
          '${(a * 255).floor().toRadixString(16).padLeft(2, '0')}'
          '${(r * 255).floor().toRadixString(16).padLeft(2, '0')}'
          '${(g * 255).floor().toRadixString(16).padLeft(2, '0')}'
          '${(b * 255).floor().toRadixString(16).padLeft(2, '0')}'
      .toUpperCase();
}
