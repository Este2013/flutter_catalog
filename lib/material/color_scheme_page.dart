import 'package:flutter/material.dart';
import 'package:flutter_catalog/main.dart';
import 'package:flutter_svg/svg.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:url_launcher/url_launcher.dart';

class ColorSchemePage extends StatefulWidget {
  const ColorSchemePage({super.key, required this.appCtrl});

  final AppCtrl appCtrl;

  @override
  State<ColorSchemePage> createState() => _ColorSchemePageState();
}

class _ColorSchemePageState extends State<ColorSchemePage> with TickerProviderStateMixin {
  ColorScheme? colorScheme;
  ColorScheme? darkColorScheme;
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    colorScheme = Theme.of(context).colorScheme.copyWith();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('Color scheme'),
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
        body: Row(
          children: [
            FocusTraversalGroup(
              policy: OrderedTraversalPolicy(),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                width: 300,
                alignment: Alignment.topCenter,
                child: SingleChildScrollView(
                  child: Column(
                    spacing: 8,
                    children: [
                      FocusTraversalOrder(
                        order: NumericFocusOrder(0),
                        child: Card(
                          clipBehavior: Clip.hardEdge,
                          margin: EdgeInsets.zero,
                          child: InkWell(
                            onTap: () => launchUrl(Uri.parse('https://api.flutter.dev/flutter/material/ColorScheme-class.html')),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    'Open documentation',
                                    textAlign: TextAlign.left,
                                    style: Theme.of(context).textTheme.titleMedium,
                                    maxLines: 3,
                                  ),
                                  SizedBox.square(
                                    dimension: 40,
                                    child: Icon(Symbols.book_2, fill: 1),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Divider(),
                      Table(
                        columnWidths: {3: FlexColumnWidth(.2)},
                        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                        children: [
                          TableRow(children: [
                            TableCell(child: Text('Primary', style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.center)),
                            TableCell(child: Text('Secondary', style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.center)),
                            TableCell(child: Text('Tertiary', style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.center)),
                            TableCell(child: SizedBox()),
                          ]),
                          TableRow(children: [
                            TableCell(
                              child: Align(
                                alignment: Alignment.center,
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(color: colorScheme!.primary, borderRadius: BorderRadius.circular(8)),
                                ),
                              ),
                            ),
                            TableCell(
                              child: Align(
                                alignment: Alignment.center,
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(color: colorScheme!.secondary, borderRadius: BorderRadius.circular(8)),
                                ),
                              ),
                            ),
                            TableCell(
                              child: Align(
                                alignment: Alignment.center,
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(color: colorScheme!.tertiary, borderRadius: BorderRadius.circular(8)),
                                ),
                              ),
                            ),
                            TableCell(
                              child: Align(
                                alignment: Alignment.center,
                                child: Tooltip(
                                  message: '''Primary: \n\t\t- The color displayed most frequently across your app’s screens and components.
Secondary: \n\t\t- An accent color used for less prominent components in the UI, such as filter chips.
Tertiary: \n\t\t- A color used as a contrasting accent that can balance primary and secondary colors or bring heightened attention to an element, such as an input field.''',
                                  child: Icon(Icons.info),
                                ),
                              ),
                            ),
                          ]),
                          // onXary
                          TableRow(children: [
                            TableCell(child: SizedBox()),
                            TableCell(child: Text('On X-ary', style: Theme.of(context).textTheme.titleSmall, textAlign: TextAlign.center)),
                            TableCell(child: SizedBox()),
                            TableCell(child: SizedBox()),
                          ]),
                          TableRow(children: [
                            TableCell(
                              child: Align(
                                alignment: Alignment.center,
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(color: colorScheme!.onPrimary, borderRadius: BorderRadius.circular(8)),
                                ),
                              ),
                            ),
                            TableCell(
                              child: Align(
                                alignment: Alignment.center,
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(color: colorScheme!.onSecondary, borderRadius: BorderRadius.circular(8)),
                                ),
                              ),
                            ),
                            TableCell(
                              child: Align(
                                alignment: Alignment.center,
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(color: colorScheme!.onTertiary, borderRadius: BorderRadius.circular(8)),
                                ),
                              ),
                            ),
                            TableCell(child: Align(alignment: Alignment.center, child: Tooltip(message: 'Clearly legible when drawn on X-ary.', child: Icon(Icons.info))))
                          ]),
                          // XaryFixed
                          TableRow(children: [
                            TableCell(child: SizedBox()),
                            TableCell(child: Text('Fixed', style: Theme.of(context).textTheme.titleSmall, textAlign: TextAlign.center)),
                            TableCell(child: SizedBox()),
                            TableCell(child: SizedBox()),
                          ]),
                          TableRow(children: [
                            TableCell(
                              child: Align(
                                alignment: Alignment.center,
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(color: colorScheme!.primaryFixed, borderRadius: BorderRadius.circular(8)),
                                ),
                              ),
                            ),
                            TableCell(
                              child: Align(
                                alignment: Alignment.center,
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(color: colorScheme!.secondaryFixed, borderRadius: BorderRadius.circular(8)),
                                ),
                              ),
                            ),
                            TableCell(
                              child: Align(
                                alignment: Alignment.center,
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(color: colorScheme!.tertiaryFixed, borderRadius: BorderRadius.circular(8)),
                                ),
                              ),
                            ),
                            TableCell(
                                child: Align(
                                    alignment: Alignment.center, child: Tooltip(message: 'A substitute for Container that\'s the same color for the dark and light themes.', child: Icon(Icons.info))))
                          ]),
                          // onXaryFixed
                          TableRow(children: [
                            TableCell(child: SizedBox()),
                            TableCell(child: Text('OnFixed', style: Theme.of(context).textTheme.titleSmall, textAlign: TextAlign.center)),
                            TableCell(child: SizedBox()),
                            TableCell(child: SizedBox()),
                          ]),
                          TableRow(children: [
                            TableCell(
                              child: Align(
                                alignment: Alignment.center,
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(color: colorScheme!.onPrimaryFixed, borderRadius: BorderRadius.circular(8)),
                                ),
                              ),
                            ),
                            TableCell(
                              child: Align(
                                alignment: Alignment.center,
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(color: colorScheme!.onSecondaryFixed, borderRadius: BorderRadius.circular(8)),
                                ),
                              ),
                            ),
                            TableCell(
                              child: Align(
                                alignment: Alignment.center,
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(color: colorScheme!.onTertiaryFixed, borderRadius: BorderRadius.circular(8)),
                                ),
                              ),
                            ),
                            TableCell(
                                child:
                                    Align(alignment: Alignment.center, child: Tooltip(message: 'Used for text and icons that exist on top of elements having Fixed color.', child: Icon(Icons.info))))
                          ]),
                          // onXaryFixedVariant
                          TableRow(children: [
                            TableCell(child: SizedBox()),
                            TableCell(child: Text('OnFixedVar', style: Theme.of(context).textTheme.titleSmall, textAlign: TextAlign.center)),
                            TableCell(child: SizedBox()),
                            TableCell(child: SizedBox()),
                          ]),
                          TableRow(children: [
                            TableCell(
                              child: Align(
                                alignment: Alignment.center,
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(color: colorScheme!.onPrimaryFixedVariant, borderRadius: BorderRadius.circular(8)),
                                ),
                              ),
                            ),
                            TableCell(
                              child: Align(
                                alignment: Alignment.center,
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(color: colorScheme!.onSecondaryFixedVariant, borderRadius: BorderRadius.circular(8)),
                                ),
                              ),
                            ),
                            TableCell(
                              child: Align(
                                alignment: Alignment.center,
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(color: colorScheme!.onTertiaryFixedVariant, borderRadius: BorderRadius.circular(8)),
                                ),
                              ),
                            ),
                            TableCell(child: Align(alignment: Alignment.center, child: Tooltip(message: 'A lower-emphasis option for text and icons than onFixed.', child: Icon(Icons.info))))
                          ]),
                          // XaryFixedDim
                          TableRow(children: [
                            TableCell(child: SizedBox()),
                            TableCell(child: Text('FixedDim', style: Theme.of(context).textTheme.titleSmall, textAlign: TextAlign.center)),
                            TableCell(child: SizedBox()),
                            TableCell(child: SizedBox()),
                          ]),
                          TableRow(children: [
                            TableCell(
                              child: Align(
                                alignment: Alignment.center,
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(color: colorScheme!.primaryFixedDim, borderRadius: BorderRadius.circular(8)),
                                ),
                              ),
                            ),
                            TableCell(
                              child: Align(
                                alignment: Alignment.center,
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(color: colorScheme!.secondaryFixedDim, borderRadius: BorderRadius.circular(8)),
                                ),
                              ),
                            ),
                            TableCell(
                              child: Align(
                                alignment: Alignment.center,
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(color: colorScheme!.tertiaryFixedDim, borderRadius: BorderRadius.circular(8)),
                                ),
                              ),
                            ),
                            TableCell(child: Align(alignment: Alignment.center, child: Tooltip(message: 'Used for elements needing more emphasis than Fixed.', child: Icon(Icons.info))))
                          ]),
                          // XaryContainer
                          TableRow(children: [
                            TableCell(child: SizedBox()),
                            TableCell(child: Text('Container', style: Theme.of(context).textTheme.titleSmall, textAlign: TextAlign.center)),
                            TableCell(child: SizedBox()),
                            TableCell(child: SizedBox()),
                          ]),
                          TableRow(children: [
                            TableCell(
                              child: Align(
                                alignment: Alignment.center,
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(color: colorScheme!.primaryContainer, borderRadius: BorderRadius.circular(8)),
                                ),
                              ),
                            ),
                            TableCell(
                              child: Align(
                                alignment: Alignment.center,
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(color: colorScheme!.secondaryContainer, borderRadius: BorderRadius.circular(8)),
                                ),
                              ),
                            ),
                            TableCell(
                              child: Align(
                                alignment: Alignment.center,
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(color: colorScheme!.tertiaryContainer, borderRadius: BorderRadius.circular(8)),
                                ),
                              ),
                            ),
                            TableCell(child: Align(alignment: Alignment.center, child: Tooltip(message: 'Used for elements needing less emphasis than X-ary', child: Icon(Icons.info))))
                          ]),
                          // onXaryContainer
                          TableRow(children: [
                            TableCell(child: SizedBox()),
                            TableCell(child: Text('OnContainer', style: Theme.of(context).textTheme.titleSmall, textAlign: TextAlign.center)),
                            TableCell(child: SizedBox()),
                            TableCell(child: SizedBox()),
                          ]),
                          TableRow(children: [
                            TableCell(
                              child: Align(
                                alignment: Alignment.center,
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(color: colorScheme!.onPrimaryContainer, borderRadius: BorderRadius.circular(8)),
                                ),
                              ),
                            ),
                            TableCell(
                              child: Align(
                                alignment: Alignment.center,
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(color: colorScheme!.onSecondaryContainer, borderRadius: BorderRadius.circular(8)),
                                ),
                              ),
                            ),
                            TableCell(
                              child: Align(
                                alignment: Alignment.center,
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(color: colorScheme!.onTertiaryContainer, borderRadius: BorderRadius.circular(8)),
                                ),
                              ),
                            ),
                            TableCell(child: Align(alignment: Alignment.center, child: Tooltip(message: 'Clearly legible when drawn on Container.', child: Icon(Icons.info))))
                          ]),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            VerticalDivider(),
            Expanded(
              child: Container(
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.fromBorderSide(BorderSide(color: Theme.of(context).dividerColor, width: 5)),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: MaterialApp(
                    debugShowCheckedModeBanner: false,
                    theme: ThemeData(colorScheme: colorScheme),
                    home: Scaffold(
                      appBar: AppBar(
                        title: Text('AppBar'),
                        actionsPadding: EdgeInsets.only(right: 8),
                        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.settings))],
                      ),
                      drawer: Drawer(),
                      bottomNavigationBar: BottomAppBar(
                        child: Row(
                          children: [ElevatedButton(onPressed: () {}, child: Text('ElevatedButton'))],
                        ),
                      ),
                      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
                      floatingActionButton: FloatingActionButton(onPressed: () {}, child: Icon(Icons.favorite)),
                      body: DemoBody(),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );

  /* ColorScheme buildColorScheme() => ColorScheme(
        brightness: brightness!.value,
        
        // Primary colors
        primaryContainer: ,
        onPrimaryContainer: ,
        
        // Surfaces
        surface: ,
        surfaceBright: ,
        surfaceContainer: ,
        surfaceContainerHigh: ,
        surfaceContainerHighest: ,
        surfaceContainerLow: ,
        surfaceContainerLowest: ,
        surfaceDim: ,
        surfaceTint: ,
        onSurface: ,
        onSurfaceVariant: ,
        
        // Inverses
        inversePrimary: ,
        inverseSurface: ,
        onInverseSurface: ,

        // Errors
        error: ,
        errorContainer: ,
        onError: ,
        onErrorContainer: ,

        // Misc
        outline: ,
        outlineVariant: ,
        scrim: ,
        shadow: ,
      );
 */
}

class DemoBody extends StatelessWidget {
  const DemoBody({super.key});

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Text Widget
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                "Hello, this is a demo app!",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            // Icon Widget
            const Icon(Icons.star, size: 50, color: Colors.orange),
            const SizedBox(height: 10),

            // Decorated Container
            Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text("This is inside a decorated container."),
            ),
            const SizedBox(height: 10),
            // Row with Icon and Text Columns
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: const [
                    Icon(Icons.phone, color: Colors.green),
                    SizedBox(height: 4),
                    Text("Phone"),
                  ],
                ),
                Column(
                  children: const [
                    Icon(Icons.email, color: Colors.red),
                    SizedBox(height: 4),
                    Text("Email"),
                  ],
                ),
                Column(
                  children: const [
                    Icon(Icons.map, color: Colors.blue),
                    SizedBox(height: 4),
                    Text("Map"),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            // ListTile Widget
            const ListTile(
              leading: Icon(Icons.account_circle),
              title: Text("John Doe"),
              subtitle: Text("Software Developer"),
              trailing: Icon(Icons.more_vert),
            ),
            const SizedBox(height: 10),
            // Card Widget
            Card(
              margin: const EdgeInsets.all(10),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text("Card Title", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 8),
                    Text("This is a description inside a card."),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            // Row with a Switch
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Toggle switch: "),
                Switch(value: true, onChanged: (bool value) {}),
              ],
            ),
            const SizedBox(height: 10),
            // Slider Widget
            Column(
              children: [
                const Text("Slider value demo:"),
                Slider(value: 0.5, onChanged: (double value) {}),
              ],
            ),
            const SizedBox(height: 10),
            // Circular Progress Indicator
            const Center(child: CircularProgressIndicator()),
            const SizedBox(height: 10),
            // Buttons Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: const Text("Button 1"),
                ),
                OutlinedButton(
                  onPressed: () {},
                  child: const Text("Button 2"),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text("Button 3"),
                ),
              ],
            ),
            const SizedBox(height: 10),
            // TextField Widget
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: "Enter text here",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 10),
            // DropdownButton Widget
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownMenu<String>(
                initialSelection: "One",
                dropdownMenuEntries: ["One", "Two", "Three"].map((String value) {
                  return DropdownMenuEntry<String>(value: value, label: value);
                }).toList(),
                onSelected: (_) {},
              ),
            ),
            const SizedBox(height: 10),
            // Wrap with Chips
            Wrap(
              spacing: 8,
              children: const [
                Chip(label: Text("Chip 1")),
                Chip(label: Text("Chip 2")),
                Chip(label: Text("Chip 3")),
              ],
            ),
            const SizedBox(height: 10),
            // Divider Widget
            const Divider(thickness: 2),
            const SizedBox(height: 10),
            // Animated Container Placeholder
            Container(
              height: 100,
              color: Colors.amber,
              child: const Center(child: Text("Animated Container Placeholder")),
            ),
            const SizedBox(height: 10),
            // ListView inside a fixed-height Container
            SizedBox(
              height: 150,
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text("List Item ${index + 1}"),
                  );
                },
              ),
            ),
          ],
        ),
      );
}
