import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

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

class ActionsPresentationPage extends StatelessWidget {
  const ActionsPresentationPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      runSpacing: 32,
      spacing: 32,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        WidgetPresentation(title: 'ElevatedButton'),
        WidgetPresentation(title: 'FilledButton'),
        WidgetPresentation(title: 'FilledButton.tonal'),
        WidgetPresentation(title: 'OutlinedButton'),
        WidgetPresentation(title: 'TextButton'),
      ],
    );
  }
}

class WidgetPresentation extends StatefulWidget {
  const WidgetPresentation({
    super.key,
    required this.title,
  });

  final String title;

  @override
  State<WidgetPresentation> createState() => _WidgetPresentationState();
}

class _WidgetPresentationState extends State<WidgetPresentation> {
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
            width: 350,
            height: 400,
            child: InkWell(
              onTap: () {},
              child: Column(
                children: [
                  Expanded(
                    flex: 4,
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 200),
                      color: isHovered ? Colors.amber : Colors.transparent,
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        widget.title,
                        style: Theme.of(context).textTheme.titleLarge,
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
