import 'package:flutter/material.dart';
import 'package:flutter_catalog/main.dart';
import 'package:flutter_catalog/flutter_widgets/material/color_scheme_page.dart';
import 'package:flutter_catalog/widget_dialog.dart';
import 'package:flutter_catalog/widget_tree_resolver/container_data.dart';
import 'package:flutter_catalog/widget_tree_resolver/icon_data.dart';
import 'package:flutter_svg/svg.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:url_launcher/url_launcher.dart';

import '../material_actions/actions.dart';
import '../icons_page.dart';
import '../layouts.dart';
import 'material_home_ui/icon_theme_data.dart';
import '../state_actions.dart';

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
                            TitleRow('Online resources'),
                            Wrap(
                              children: [
                                CustomCardItem.link(
                                  leading: FlutterLogo(size: 50),
                                  title: 'Flutter widget catalog',
                                  link: 'https://docs.flutter.dev/ui/widgets',
                                ),
                                CustomCardItem.link(
                                  leading: FlutterLogo(size: 50),
                                  title: 'Flutter material catalog',
                                  link: 'https://docs.flutter.dev/ui/widgets/material',
                                ),
                                CustomCardItem.link(
                                  leading: SvgPicture.asset(
                                    'assets/logos/Google_Material_Design_Logo.svg',
                                    height: 50,
                                    semanticsLabel: 'Material Icon',
                                  ),
                                  title: 'Material Design 3',
                                  link: 'https://m3.material.io/',
                                ),
                              ],
                            ),
                            TitleRow('Style'),
                            Wrap(
                              children: [
                                CustomCardItem.explore(
                                  leading: Icon(Icons.emoji_symbols, size: 50),
                                  route: MaterialPageRoute(builder: (context) => IconsPage(appCtrl: appCtrl)),
                                  title: 'Material icons',
                                ),
                                CustomCardItem.explore(
                                  leading: _ColoredCirclesIcon(),
                                  route: MaterialPageRoute(builder: (context) => ColorSchemePage(appCtrl: appCtrl)),
                                  title: 'Color scheme',
                                ),
                              ],
                            ),
                            TitleRow('Text widgets'),
                            Wrap(
                              children: [
                                CustomCardItem.widgetPresentation(
                                    leading: Icon(Icons.text_fields),
                                    title: 'Text',
                                    dialog: WidgetPresentation.createDialogFrom(
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
                                      ],
                                    )),
                                CustomCardItem.widgetPresentation(
                                    leading: Icon(Icons.format_color_text),
                                    title: 'RichText',
                                    dialog: WidgetPresentation.createDialogFrom(
                                      title: 'RichText',
                                      variantsData: [
                                        WidgetVariantData(
                                          null,
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
                                    )),
                                CustomCardItem.widgetPresentation(
                                    leading: Icon(Icons.style),
                                    title: 'DefaultTextStyle',
                                    dialog: WidgetPresentation.createDialogFrom(
                                      title: 'DefaultTextStyle',
                                      variantsData: [
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
                                    )),
                                CustomCardItem.widgetPresentation(
                                    leading: Icon(Icons.star, color: Colors.amber.shade700),
                                    title: 'Icon',
                                    dialog: WidgetPresentation.createDialogFrom(
                                      title: 'Icon',
                                      variantsData: [
                                        WidgetVariantData(
                                          null,
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
                                          themeExplanation: IconThemeExplanation(treeNodeData: IconNodeData()),
                                          widgetTreeExplanation: IconNodeData(),
                                        ),
                                      ],
                                      link: 'https://api.flutter.dev/flutter/widgets/Icon-class.html',
                                    )),
                              ],
                            ),
                            // TODO put container in correct category
                            TitleRow('Container (missing category)'),
                            CustomCardItem.widgetPresentation(
                                leading: Icon(Symbols.square_dot),
                                title: 'Container',
                                dialog: WidgetPresentation.createDialogFrom(
                                  title: 'Container',
                                  variantsData: [
                                    WidgetVariantData(
                                      null,
                                      iconBuilder: (p0) => Icon(Icons.check_box_outline_blank_sharp),
                                      widgetBuilder: (p0, options) => Container(color: Colors.amber),
                                      widgetTreeExplanation: ContainerNodeData(),
                                    ),
                                  ],
                                  link: 'https://api.flutter.dev/flutter/widgets/Container-class.html',
                                )),
                            TitleRow('Base widgets'),
                            // TODO widgets from basics
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

class TitleRow extends StatelessWidget {
  const TitleRow(this.title, {super.key});

  final String title;

  @override
  Widget build(BuildContext context) => Row(
        spacing: 16,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleLarge),
          Expanded(child: Divider()),
        ],
      );
}

class _ColoredCirclesIcon extends StatelessWidget {
  const _ColoredCirclesIcon();

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
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
    );
  }
}

class CustomCardItem extends StatelessWidget {
  final void Function(BuildContext context)? onTap;
  final Widget leading;
  final String title;
  final Widget trailing;

  const CustomCardItem({
    super.key,
    required this.onTap,
    required this.leading,
    required this.title,
    required this.trailing,
  });

  factory CustomCardItem.link({
    Key? key,
    required Widget leading,
    required String title,
    required String link,
  }) =>
      CustomCardItem(
        key: key,
        onTap: (_) => launchUrl(Uri.parse(link)),
        leading: leading,
        title: title,
        trailing: Icon(Icons.open_in_new),
      );

  factory CustomCardItem.explore({
    Key? key,
    required Widget leading,
    required Route route,
    required String title,
  }) =>
      CustomCardItem(
        key: key,
        onTap: (context) => Navigator.of(context).push(route),
        leading: leading,
        title: title,
        trailing: Icon(Icons.explore),
      );

  factory CustomCardItem.widgetPresentation({
    Key? key,
    required Widget leading,
    required String title,
    required WidgetPresentationDialog dialog,
  }) =>
      CustomCardItem(
        key: key,
        onTap: (context) => showDialog(context: context, builder: (_) => dialog),
        leading: leading,
        title: title,
        trailing: Icon(Icons.widgets),
      );

  @override
  Widget build(BuildContext context) => Card(
        clipBehavior: Clip.hardEdge,
        child: InkWell(
          onTap: onTap != null ? () => onTap?.call(context) : null,
          child: Padding(
            padding: const EdgeInsets.only(
              top: 16,
              bottom: 16,
              left: 16,
              right: 22,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              spacing: 16, // keeps the same spacing as your original code
              children: [
                IconTheme(data: IconThemeData(size: 50), child: leading),
                ConstrainedBox(
                  constraints: BoxConstraints(minWidth: 100),
                  child: Center(
                    child: Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                ),
                trailing,
              ],
            ),
          ),
        ),
      );
}
