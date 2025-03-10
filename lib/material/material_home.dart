import 'package:flutter/material.dart';
import 'package:flutter_catalog/main.dart';
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
        crossAxisAlignment: CrossAxisAlignment.stretch,
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
                          // NavigationRailDestination(icon: Icon(Symbols.settings, fill: 1), label: Text('Settings')),
                        ],
                        selectedIndex: pages.indexOf(selectedPage),
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
              padding: EdgeInsets.only(left: 32, right: 16),
              child: Center(
                child: Builder(
                  builder: (context) {
                    if (selectedPage == 'home') {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 100,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              children: [
                                Card(
                                  clipBehavior: Clip.hardEdge,
                                  child: InkWell(
                                    onTap: () => launchUrl(Uri.parse('https://docs.flutter.dev/ui/widgets')),
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 16, bottom: 16, left: 16, right: 22),
                                      child: Row(
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
                          ),
                          PresentationCard(
                            title: 'Material icons',
                            trailingTitle: IconButton(
                              onPressed: () => launchUrl(Uri.parse('https://fonts.google.com/icons?icon.size=24&icon.color=%23e8eaed')),
                              icon: Icon(Icons.open_in_new),
                            ),
                            child: IconTheme(
                              data: Theme.of(context).iconTheme.copyWith(size: 40),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Icon(Icons.favorite),
                                      Icon(Icons.star),
                                      Icon(Icons.abc),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Icon(Icons.cake),
                                      Icon(Icons.qr_code),
                                      Icon(Icons.headset),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Icon(Icons.explore),
                                      Icon(Icons.thumb_up),
                                      Icon(Icons.more_horiz),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => IconsPage(appCtrl: appCtrl)),
                            ),
                          ),
                        ],
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
