import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_catalog/flutter_widgets/material/material_home/material_home.dart';
import 'package:flutter_svg/svg.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

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
            body: MaterialApplicationBody(),
          ),
        ),
      );
}
