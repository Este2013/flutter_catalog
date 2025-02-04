import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_catalog/main.dart';
import 'package:flutter_catalog/material/actions.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MainApp());
}

class AppCtrl extends ChangeNotifier {
  bool _darkMode = false;
  bool get darkMode => _darkMode;
  set darkMode(bool b) {
    _darkMode = b;
    notifyListeners();
  }
}

AppCtrl appCtrl = AppCtrl();

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: appCtrl,
      builder: (context, child) => MaterialApp(
        theme: appCtrl.darkMode ? ThemeData.dark() : ThemeData(),
        home: Scaffold(
          // drawer: NavigationDrawer(children: [
          //   Icon(Icons.settings),
          // ]),

          body: ApplicationBody(),
        ),
      ),
    );
  }
}

class ApplicationBody extends StatefulWidget {
  const ApplicationBody({
    super.key,
  });

  @override
  State<ApplicationBody> createState() => _ApplicationBodyState();
}

class _ApplicationBodyState extends State<ApplicationBody> {
  String selectedPage = 'home';

  final List<String> pages = ['home', 'actions', 'state buttons', 'layout', 'forms'];

  @override
  Widget build(BuildContext context) => Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SingleChildScrollView(
            child: IntrinsicHeight(
              child: NavigationRail(
                destinations: [
                  NavigationRailDestination(icon: Icon(Icons.home), label: Text('Home')),
                  NavigationRailDestination(icon: Icon(Symbols.arrow_selector_tool, fill: 1), label: Text('Actions')),
                  NavigationRailDestination(icon: Icon(Symbols.check_box, fill: 1), label: Text('State Buttons')),
                  NavigationRailDestination(icon: Icon(Symbols.dashboard, fill: 1), label: Text('Layout')),
                  NavigationRailDestination(icon: Icon(Symbols.checklist_rtl, fill: 1), label: Text('Forms')),
                  NavigationRailDestination(icon: Icon(Symbols.settings, fill: 1), label: Text('Settings')),
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
              ),
            ),
          ),
          VerticalDivider(),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(32),
              child: Center(
                child: Builder(
                  builder: (context) {
                    if (selectedPage == 'home') {
                      return Center(child: Text(':D'));
                    }
                    if (selectedPage == 'actions') {
                      return ActionsPresentationPage();
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

class WidgetPresentation extends StatefulWidget {
  const WidgetPresentation({
    super.key,
    required this.title,
    this.presentationWindowAlignment,
    this.link,
    this.playGroundDialogBuilder,
    required this.variantsData,
  });

  final String title;
  final Alignment? presentationWindowAlignment;
  final String? link;
  final Widget Function(BuildContext)? playGroundDialogBuilder;
  final List<WidgetVariantData> variantsData;

  @override
  State<WidgetPresentation> createState() => _WidgetPresentationState();
}

class _WidgetPresentationState extends State<WidgetPresentation> {
  bool isHovered = false;
  int _currentVariantIndex = 0;
  Timer? _variantTimer;

  @override
  void initState() {
    super.initState();
    if (widget.variantsData.length > 1) {
      _startVariantCycling();
    }
  }

  void _startVariantCycling() {
    _variantTimer?.cancel();
    _variantTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      setState(() {
        _currentVariantIndex = (_currentVariantIndex + 1) % widget.variantsData.length;
      });
    });
  }

  @override
  void dispose() {
    _variantTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: MouseRegion(
          onEnter: (event) => setState(() {
            isHovered = true;
          }),
          onExit: (event) => setState(() {
            isHovered = false;
          }),
          child: Ink(
            decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).dividerColor),
              borderRadius: BorderRadius.circular(5),
            ),
            width: 300,
            height: 250,
            child: InkWell(
              onTap: () => showDialog(context: context, builder: widget.playGroundDialogBuilder ?? (_) => Placeholder()),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    flex: 4,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(5), topRight: Radius.circular(5)),
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 200),
                        color: isHovered ? Colors.purple.withAlpha(200) : Colors.transparent,
                        child: AnimatedSwitcher(
                          duration: Duration(milliseconds: 500),
                          transitionBuilder: (child, animation) => FadeTransition(opacity: animation, child: child),
                          child: Builder(
                              key: ValueKey<int>(_currentVariantIndex),
                              builder: (context) {
                                Widget child = widget.variantsData[_currentVariantIndex].widgetBuilder!(context, {});
                                if (widget.presentationWindowAlignment == Alignment.bottomLeft) {
                                  return Stack(
                                    children: [
                                      Positioned.fill(
                                          child: FractionallySizedBox(
                                        alignment: Alignment.topRight,
                                        heightFactor: 4 / 5,
                                        widthFactor: 4 / 5,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Theme.of(context).scaffoldBackgroundColor,
                                            border: Border(
                                              left: BorderSide(color: Theme.of(context).dividerColor, width: 5),
                                              bottom: BorderSide(color: Theme.of(context).dividerColor, width: 5),
                                            ),
                                            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15)),
                                          ),
                                        ),
                                      )),
                                      Positioned.fill(
                                        child: FractionallySizedBox(
                                          heightFactor: 3 / 5,
                                          widthFactor: 3 / 5,
                                          alignment: Alignment.topRight,
                                          child: Align(alignment: widget.presentationWindowAlignment!, child: child),
                                        ),
                                      )
                                    ],
                                  );
                                }
                                if (widget.presentationWindowAlignment == Alignment.bottomRight) {
                                  return Stack(
                                    children: [
                                      Positioned.fill(
                                          child: FractionallySizedBox(
                                        alignment: Alignment.topLeft,
                                        heightFactor: 4 / 5,
                                        widthFactor: 4 / 5,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Theme.of(context).scaffoldBackgroundColor,
                                            border: Border(
                                              right: BorderSide(color: Theme.of(context).dividerColor, width: 5),
                                              bottom: BorderSide(color: Theme.of(context).dividerColor, width: 5),
                                            ),
                                            borderRadius: BorderRadius.only(bottomRight: Radius.circular(15)),
                                          ),
                                        ),
                                      )),
                                      Positioned.fill(
                                        child: FractionallySizedBox(
                                          heightFactor: 3 / 5,
                                          widthFactor: 3 / 5,
                                          alignment: Alignment.topLeft,
                                          child: Align(alignment: widget.presentationWindowAlignment!, child: child),
                                        ),
                                      )
                                    ],
                                  );
                                }
                                if (widget.presentationWindowAlignment == Alignment.topLeft) {
                                  return Stack(
                                    children: [
                                      Positioned.fill(
                                          child: FractionallySizedBox(
                                        alignment: Alignment.bottomRight,
                                        heightFactor: 4 / 5,
                                        widthFactor: 4 / 5,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Theme.of(context).scaffoldBackgroundColor,
                                            border: Border(
                                              left: BorderSide(color: Theme.of(context).dividerColor, width: 5),
                                              top: BorderSide(color: Theme.of(context).dividerColor, width: 5),
                                            ),
                                            borderRadius: BorderRadius.only(topLeft: Radius.circular(15)),
                                          ),
                                        ),
                                      )),
                                      Positioned.fill(
                                        child: FractionallySizedBox(
                                          heightFactor: 3 / 5,
                                          widthFactor: 3 / 5,
                                          alignment: Alignment.bottomRight,
                                          child: Align(alignment: widget.presentationWindowAlignment!, child: child),
                                        ),
                                      )
                                    ],
                                  );
                                }
                                if (widget.presentationWindowAlignment == Alignment.topRight) {
                                  return Stack(
                                    children: [
                                      Positioned.fill(
                                          child: FractionallySizedBox(
                                        alignment: Alignment.bottomLeft,
                                        heightFactor: 4 / 5,
                                        widthFactor: 4 / 5,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Theme.of(context).scaffoldBackgroundColor,
                                            border: Border(
                                              right: BorderSide(color: Theme.of(context).dividerColor, width: 5),
                                              top: BorderSide(color: Theme.of(context).dividerColor, width: 5),
                                            ),
                                            borderRadius: BorderRadius.only(topRight: Radius.circular(15)),
                                          ),
                                        ),
                                      )),
                                      Positioned.fill(
                                        child: FractionallySizedBox(
                                          heightFactor: 3 / 5,
                                          widthFactor: 3 / 5,
                                          alignment: Alignment.bottomLeft,
                                          child: Align(alignment: widget.presentationWindowAlignment!, child: child),
                                        ),
                                      )
                                    ],
                                  );
                                }
                                if (widget.presentationWindowAlignment == Alignment.center) {
                                  return Stack(
                                    children: [
                                      Positioned.fill(
                                          child: FractionallySizedBox(
                                        alignment: Alignment.center,
                                        widthFactor: 4 / 5,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Theme.of(context).scaffoldBackgroundColor,
                                            border: Border(
                                              left: BorderSide(color: Theme.of(context).dividerColor, width: 5),
                                              right: BorderSide(color: Theme.of(context).dividerColor, width: 5),
                                            ),
                                          ),
                                        ),
                                      )),
                                      Positioned.fill(
                                        child: FractionallySizedBox(
                                          widthFactor: 3 / 5,
                                          child: Align(alignment: widget.presentationWindowAlignment!, child: child),
                                        ),
                                      )
                                    ],
                                  );
                                }
                                if (widget.presentationWindowAlignment == Alignment.centerLeft) {
                                  return Stack(
                                    children: [
                                      Positioned.fill(
                                          child: FractionallySizedBox(
                                        alignment: Alignment.centerRight,
                                        widthFactor: 4 / 5,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Theme.of(context).scaffoldBackgroundColor,
                                            border: Border(
                                              left: BorderSide(color: Theme.of(context).dividerColor, width: 5),
                                            ),
                                          ),
                                        ),
                                      )),
                                      Positioned.fill(
                                        child: FractionallySizedBox(
                                          widthFactor: 3 / 5,
                                          alignment: Alignment.centerRight,
                                          child: Align(alignment: widget.presentationWindowAlignment!, child: child),
                                        ),
                                      )
                                    ],
                                  );
                                }
                                if (widget.presentationWindowAlignment == Alignment.centerRight) {
                                  return Stack(
                                    children: [
                                      Positioned.fill(
                                          child: FractionallySizedBox(
                                        alignment: Alignment.centerLeft,
                                        widthFactor: 4 / 5,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Theme.of(context).scaffoldBackgroundColor,
                                            border: Border(
                                              right: BorderSide(color: Theme.of(context).dividerColor, width: 5),
                                            ),
                                          ),
                                        ),
                                      )),
                                      Positioned.fill(
                                        child: FractionallySizedBox(
                                          widthFactor: 3 / 5,
                                          alignment: Alignment.centerLeft,
                                          child: Align(alignment: widget.presentationWindowAlignment!, child: child),
                                        ),
                                      )
                                    ],
                                  );
                                }
                                if (widget.presentationWindowAlignment == Alignment.topCenter) {
                                  return Stack(
                                    children: [
                                      Positioned.fill(
                                          child: FractionallySizedBox(
                                        alignment: Alignment.bottomCenter,
                                        heightFactor: 5 / 6,
                                        widthFactor: 4 / 5,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Theme.of(context).scaffoldBackgroundColor,
                                            border: Border(
                                              right: BorderSide(color: Theme.of(context).dividerColor, width: 5),
                                              left: BorderSide(color: Theme.of(context).dividerColor, width: 5),
                                              top: BorderSide(color: Theme.of(context).dividerColor, width: 5),
                                            ),
                                            borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
                                          ),
                                        ),
                                      )),
                                      Positioned.fill(
                                        child: FractionallySizedBox(
                                          heightFactor: 3 / 5,
                                          widthFactor: 3 / 5,
                                          alignment: Alignment.bottomCenter,
                                          child: Align(alignment: widget.presentationWindowAlignment!, child: child),
                                        ),
                                      )
                                    ],
                                  );
                                }
                                if (widget.presentationWindowAlignment == Alignment.bottomCenter) {
                                  return Stack(
                                    children: [
                                      Positioned.fill(
                                          child: FractionallySizedBox(
                                        alignment: Alignment.topCenter,
                                        heightFactor: 5 / 6,
                                        widthFactor: 4 / 5,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Theme.of(context).scaffoldBackgroundColor,
                                            border: Border(
                                              right: BorderSide(color: Theme.of(context).dividerColor, width: 5),
                                              left: BorderSide(color: Theme.of(context).dividerColor, width: 5),
                                              bottom: BorderSide(color: Theme.of(context).dividerColor, width: 5),
                                            ),
                                            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15)),
                                          ),
                                        ),
                                      )),
                                      Positioned.fill(
                                        child: FractionallySizedBox(
                                          heightFactor: 3 / 5,
                                          widthFactor: 3 / 5,
                                          alignment: Alignment.topCenter,
                                          child: Align(alignment: widget.presentationWindowAlignment!, child: child),
                                        ),
                                      )
                                    ],
                                  );
                                }

                                if (widget.presentationWindowAlignment == null) {
                                  return Center(
                                    child: child,
                                  );
                                }
                                return Placeholder();
                              }),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              widget.title,
                              style: Theme.of(context).textTheme.titleLarge,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (_currentVariantIndex > 0) Text('(${widget.variantsData[_currentVariantIndex].name ?? 'variant $_currentVariantIndex'})'),
                          if (widget.link != null)
                            IconButton(
                              onPressed: () => launchUrl(Uri.parse(widget.link!)),
                              icon: Icon(Icons.open_in_browser),
                              padding: EdgeInsets.all(4),
                              constraints: BoxConstraints(maxHeight: 40),
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}

class SettingsDialog extends StatelessWidget {
  const SettingsDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) => AlertDialog(
        title: Text('Settings'),
        content: ConstrainedBox(
          constraints: BoxConstraints(minWidth: 300),
          child: Column(
            children: [
              Row(
                children: [
                  Text('Theme'),
                  Spacer(),
                  SegmentedButton<bool>(
                    showSelectedIcon: false,
                    onSelectionChanged: (selection) {
                      print(selection);
                      appCtrl.darkMode = selection.first;
                    },
                    selected: {appCtrl.darkMode},
                    segments: <ButtonSegment<bool>>[
                      ButtonSegment(value: false, icon: Icon(Symbols.light_mode, fill: 1)),
                      ButtonSegment(value: true, icon: Icon(Symbols.dark_mode, fill: 1)),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      );
}

// class WidgetPresentationDialog extends StatefulWidget {
//   const WidgetPresentationDialog({super.key, required this.variantsData});

//   final List<WidgetVariantData> variantsData;

//   @override
//   State<WidgetPresentationDialog> createState() => _WidgetPresentationDialogState();
// }

// class _WidgetPresentationDialogState extends State<WidgetPresentationDialog> {
//   late String selected;

//   @override
//   void initState() {
//     selected = widget.variantsData.first.name;
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) => AlertDialog(
//         title: Text('IconButton'),
//         actions: [FilledButton(onPressed: Navigator.of(context).pop, child: Text('Close'))],
//         content: SizedBox(
//           width: double.maxFinite,
//           child: Row(
//             children: [
//               if (widget.variantsData.length > 1)
//                 SizedBox(
//                   width: 200,
//                   child: Builder(
//                     builder: (context) => ListView(
//                       children: [
//                         Card(
//                           clipBehavior: Clip.hardEdge,
//                           color: (selected == widget.variantsData.first.name) ? Theme.of(context).colorScheme.secondaryContainer : null,
//                           child: InkWell(
//                             onTap: () => setState(() => selected = widget.variantsData.first.name),
//                             child: Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Row(
//                                 children: [
//                                   Expanded(child: Center(child: widget.variantsData.first.iconBuilder(context))),
//                                   Expanded(flex: 2, child: Text(widget.variantsData.first.name)),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                         Divider(),
//                         for (var variant in widget.variantsData.sublist(1))
//                           Card(
//                             clipBehavior: Clip.hardEdge,
//                             color: (selected == variant.name) ? Theme.of(context).colorScheme.secondaryContainer : null,
//                             child: InkWell(
//                               onTap: () => setState(() => selected = variant.name),
//                               child: Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Row(
//                                   children: [
//                                     Expanded(child: Center(child: variant.iconBuilder(context))),
//                                     Expanded(flex: 2, child: Text(variant.name)),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                       ],
//                     ),
//                   ),
//                 ),
//               if (widget.variantsData.length > 1) VerticalDivider(),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                   children: [
//                     Expanded(
//                       child: Container(
//                         decoration: BoxDecoration(
//                           color: Theme.of(context).scaffoldBackgroundColor,
//                           border: Border.all(color: Theme.of(context).dividerColor, width: 5),
//                           borderRadius: BorderRadius.circular(15),
//                         ),
//                         child: Builder(
//                           builder: (context) {
//                             var data = widget.variantsData.firstWhere((v) => v.name == selected);
//                             return data.widgetBuilder?.call(context, data.data) ?? Placeholder();
//                           },
//                         ),
//                       ),
//                     ),
//                     Divider(),
//                     Expanded(
//                         flex: 2,
//                         child: Builder(
//                           builder: (context) {
//                             var data = widget.variantsData.firstWhere((v) => v.name == selected);
//                             if (data.controlsBuilder == null) return Center(child: Text('No controls were provided.'));
//                             return SingleChildScrollView(child: data.controlsBuilder?.call(context, data.data));
//                           },
//                         )),
//                   ],
//                 ),
//               )
//             ],
//           ),
//         ),
//       );
// }

class WidgetVariantData extends ChangeNotifier {
  final String? name;
  final Widget Function(BuildContext) iconBuilder;
  final Widget Function(BuildContext, Map<String, dynamic> data)? widgetBuilder;

  WidgetVariantData(this.name, {required this.iconBuilder, required this.widgetBuilder, Map<String, dynamic>? defaultData});
}

// enum WidgetVariantDataValueType { folder, chooseOne, chooseMultiple, bool, str, int, double, color }
