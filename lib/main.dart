import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_catalog/material/actions.dart';
import 'package:flutter_catalog/material/material_home.dart';
import 'package:flutter_catalog/widget_dialog.dart';
import 'package:flutter_svg/svg.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

import 'material/layouts.dart';
import 'material/state_actions.dart';

void main() {
  runApp(const MainApp());
}

enum StyleSheet {
  material('Material'),
  cupertino('Cupertino');

  final String displayName;
  const StyleSheet(this.displayName);
}

class AppCtrl extends ChangeNotifier {
  bool _expandRail = false;
  bool get expandRail => _expandRail;
  set expandRail(bool b) {
    _expandRail = b;
    notifyListeners();
  }

  bool _darkMode = false;
  bool get darkMode => _darkMode;
  set darkMode(bool b) {
    _darkMode = b;
    notifyListeners();
  }

  StyleSheet _styleSheet = StyleSheet.material;
  StyleSheet get styleSheet => _styleSheet;
  set styleSheet(StyleSheet s) {
    _styleSheet = s;
    notifyListeners();
  }
}

AppCtrl appCtrl = AppCtrl();

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
        animation: appCtrl,
        builder: (context, child) => MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: appCtrl.darkMode ? ThemeData.dark() : ThemeData(),
          home: Scaffold(
            // drawer: NavigationDrawer(children: [
            //   Icon(Icons.settings),
            // ]),

            appBar: AppBar(
              leading: IconButton(
                onPressed: () => appCtrl.expandRail = !appCtrl.expandRail,
                icon: Icon(appCtrl.expandRail ? Symbols.left_panel_close : Symbols.left_panel_open, fill: 1),
              ),
              leadingWidth: 82,
              title: Text('Flutter catalog${kDebugMode ? ' (debug mode)' : ''}'),
              actionsPadding: EdgeInsets.symmetric(horizontal: 32),
              actions: [
                AnimatedBuilder(
                  animation: appCtrl,
                  builder: (context, _) => IconButton(
                    onPressed: () => appCtrl.darkMode = !appCtrl.darkMode,
                    tooltip: '${appCtrl.darkMode ? 'Dark' : 'Light'} Mode',
                    icon: Icon(appCtrl.darkMode ? Icons.dark_mode : Icons.light_mode),
                  ),
                ),
                AnimatedBuilder(
                  animation: appCtrl,
                  builder: (context, _) => IconButton(
                    onPressed: () => showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              title: Text('Not implemented'),
                              content: Text('Cupertino design sheet is not yet implemented.'),
                            )),
                    tooltip: '${appCtrl.styleSheet.displayName} Design',
                    icon: SvgPicture.asset(
                      'assets/logos/Google_Material_Design_Logo.svg',
                      semanticsLabel: 'Material Icon',
                    ),
                  ),
                ),
              ],
            ),
            body: ApplicationBody(),
          ),
        ),
      );
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
                      return PresentationCard(
                        title: 'Material icons',
                        // TODO trailingTitle: IconButton(onPressed: onPressed, icon: icon),
                        child: InfiniteIconScroll(
                          size: Size(300, 200),
                          iconSize: 50,
                        ),
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => Scaffold(
                                    appBar: AppBar(
                                      title: Text('Material icons'),
                                      leadingWidth: 82,
                                      actionsPadding: EdgeInsets.symmetric(horizontal: 32),
                                      actions: [
                                        AnimatedBuilder(
                                          animation: appCtrl,
                                          builder: (context, _) => IconButton(
                                            onPressed: () => appCtrl.darkMode = !appCtrl.darkMode,
                                            tooltip: '${appCtrl.darkMode ? 'Dark' : 'Light'} Mode',
                                            icon: Icon(appCtrl.darkMode ? Icons.dark_mode : Icons.light_mode),
                                          ),
                                        ),
                                        AnimatedBuilder(
                                          animation: appCtrl,
                                          builder: (context, _) => IconButton(
                                            onPressed: () => showDialog(
                                                context: context,
                                                builder: (context) => AlertDialog(
                                                      title: Text('Not implemented'),
                                                      content: Text('Cupertino design sheet is not yet implemented.'),
                                                    )),
                                            tooltip: '${appCtrl.styleSheet.displayName} Design',
                                            icon: SvgPicture.asset(
                                              'assets/logos/Google_Material_Design_Logo.svg',
                                              semanticsLabel: 'Material Icon',
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    body: Center(
                                      child: Text('icon stuff'),
                                    ),
                                  )),
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

class WidgetPresentation extends StatefulWidget {
  const WidgetPresentation({
    super.key,
    required this.title,
    this.presentationCardWidget,
    this.presentationWindowAlignment,
    this.presentationSplits = 5,
    this.presentationDeletePadding = false,
    this.link,
    required this.variantsData,
    this.iconBuilder,
    this.defaultOptionsBuilder,
    this.deprecationMessage,
  });

  final String title;
  final Alignment? presentationWindowAlignment;
  final Widget? presentationCardWidget;
  final int presentationSplits;
  final bool presentationDeletePadding;

  final String? link;
  // If not provided, all variants need to be given one.
  final Widget Function(BuildContext)? iconBuilder;
  final List<WidgetVariantData> variantsData;
  final String? deprecationMessage;

  @override
  State<WidgetPresentation> createState() => _WidgetPresentationState();

  final Widget Function(Map<String, dynamic>? currentOptions, void Function(Map<String, dynamic>? newOptions) submitNewOptions)? defaultOptionsBuilder;
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
  Widget build(BuildContext context) => PresentationCard(
        title: widget.title,
        leadingTitle: (widget.deprecationMessage != null)
            ? IconButton(
                splashRadius: null,
                padding: EdgeInsets.zero,
                tooltip: widget.deprecationMessage!,
                icon: Icon(Icons.warning),
                onPressed: () {},
              )
            : null,
        trailingTitle: (_currentVariantIndex > 0) ? Text('(${widget.variantsData[_currentVariantIndex].name ?? 'variant $_currentVariantIndex'})') : null,
        onTap: () => showDialog(
            context: context,
            builder: (_) => WidgetPresentationDialog(
                  widget.title,
                  variantsData: widget.variantsData,
                  link: widget.link,
                  defaultOptionsBuilder: widget.defaultOptionsBuilder,
                )),
        child: AnimatedSwitcher(
          duration: Duration(milliseconds: 500),
          transitionBuilder: (child, animation) => FadeTransition(opacity: animation, child: child),
          child: Builder(
              key: ValueKey<int>(_currentVariantIndex),
              builder: (context) {
                Widget child;
                if (widget.presentationCardWidget != null) {
                  child = widget.presentationCardWidget!;
                } else {
                  child = widget.variantsData[_currentVariantIndex].widgetBuilder!(context, null);
                }
                double appMarginFactor = (widget.presentationSplits - 1) / widget.presentationSplits;
                double appPaddingFactor = widget.presentationDeletePadding ? appMarginFactor - .03 : (widget.presentationSplits - 2) / widget.presentationSplits;

                if (widget.presentationWindowAlignment == Alignment.bottomLeft) {
                  return Stack(
                    children: [
                      Positioned.fill(
                          child: FractionallySizedBox(
                        alignment: Alignment.topRight,
                        heightFactor: appMarginFactor,
                        widthFactor: appMarginFactor,
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
                          heightFactor: appPaddingFactor,
                          widthFactor: appPaddingFactor,
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
                        heightFactor: appMarginFactor,
                        widthFactor: appMarginFactor,
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
                          heightFactor: appPaddingFactor,
                          widthFactor: appPaddingFactor,
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
                        heightFactor: appMarginFactor,
                        widthFactor: appMarginFactor,
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
                          heightFactor: appPaddingFactor,
                          widthFactor: appPaddingFactor,
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
                        heightFactor: appMarginFactor,
                        widthFactor: appMarginFactor,
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
                          heightFactor: appPaddingFactor,
                          widthFactor: appPaddingFactor,
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
                        widthFactor: appMarginFactor,
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
                          widthFactor: appPaddingFactor,
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
                        widthFactor: appMarginFactor,
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
                          widthFactor: appPaddingFactor,
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
                        widthFactor: appMarginFactor,
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
                          widthFactor: appPaddingFactor,
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
                        widthFactor: appMarginFactor,
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
                          heightFactor: appPaddingFactor,
                          widthFactor: appPaddingFactor,
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
                        widthFactor: appMarginFactor,
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
                          heightFactor: appPaddingFactor,
                          widthFactor: appPaddingFactor,
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
      );
}

class PresentationCard extends StatefulWidget {
  const PresentationCard({
    super.key,
    required this.title,
    this.onTap,
    this.child,
    this.leadingTitle,
    this.trailingTitle,
  });

  final String title;
  final Widget? child;
  final VoidCallback? onTap;
  final Widget? leadingTitle, trailingTitle;

  @override
  State<PresentationCard> createState() => _PresentationCardState();
}

class _PresentationCardState extends State<PresentationCard> {
  bool isHovered = false;

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
              onTap: widget.onTap,
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
                        child: widget.child,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Row(
                        spacing: 8,
                        children: [
                          if (widget.leadingTitle != null) widget.leadingTitle!,
                          Expanded(
                            child: Text(
                              widget.title,
                              style: Theme.of(context).textTheme.titleLarge,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (widget.trailingTitle != null) widget.trailingTitle!,
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
                    onSelectionChanged: (selection) => appCtrl.darkMode = selection.first,
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

class WidgetVariantData extends ChangeNotifier {
  final String? name;
  final Widget Function(BuildContext)? iconBuilder;
  final Widget Function(BuildContext, Map<String, dynamic>? options)? widgetBuilder;
  final Widget Function(Map<String, dynamic>? currentOptions, void Function(Map<String, dynamic>? newOptions) submitNewOptions)? optionsBuilder;

  WidgetVariantData(this.name, {required this.iconBuilder, required this.widgetBuilder, this.optionsBuilder});
}
