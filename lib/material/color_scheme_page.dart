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
    setState(() {
      colorScheme = Theme.of(context).colorScheme.copyWith();
    });
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
                      Column(
                        children: [
                          // Group 1: Titles for Primary, Secondary, Tertiary with info icon on same row
                          Row(
                            children: [
                              Expanded(
                                child: Center(
                                  child: Text(
                                    'Primary',
                                    style: Theme.of(context).textTheme.titleMedium,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Center(
                                  child: Text(
                                    'Secondary',
                                    style: Theme.of(context).textTheme.titleMedium,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Center(
                                  child: Text(
                                    'Tertiary',
                                    style: Theme.of(context).textTheme.titleMedium,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          // Row: ColorDemoContainers for Primary, Secondary, Tertiary (no info icon here)
                          Row(
                            children: [
                              Expanded(
                                child: Center(
                                  child: ColorDemoContainer(colorScheme!.primary, name: 'primary', explanation: "The color displayed most frequently across your app’s screens and components."),
                                ),
                              ),
                              Expanded(
                                child: Center(
                                  child: ColorDemoContainer(
                                    colorScheme!.secondary,
                                    name: 'secondary',
                                    explanation: "An accent color used for less prominent components in the UI, such as filter chips.",
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Center(
                                  child: ColorDemoContainer(
                                    colorScheme!.tertiary,
                                    name: 'tertiary',
                                    explanation: "A contrasting accent that can balance primary and secondary colors or bring heightened attention to an element.",
                                  ),
                                ),
                              ),
                            ],
                          ),

                          // Group 2: "On X-ary"
                          SizedBox(height: 4),
                          Text(
                            'On X-ary',
                            style: Theme.of(context).textTheme.titleSmall,
                            textAlign: TextAlign.center,
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Center(child: ColorDemoContainer(colorScheme!.onPrimary, name: 'onPrimary')),
                              Center(child: ColorDemoContainer(colorScheme!.onSecondary, name: 'onSecondary')),
                              Center(child: ColorDemoContainer(colorScheme!.onTertiary, name: 'onTertiary')),
                            ],
                          ),

                          // Group 3: "Fixed"
                          SizedBox(height: 4),
                          Tooltip(
                            message: 'A substitute for Container that\'s the same color for the dark and light themes.',
                            child: Text(
                              'Fixed',
                              style: Theme.of(context).textTheme.titleSmall,
                              textAlign: TextAlign.center,
                            ),
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Center(child: ColorDemoContainer(colorScheme!.primaryFixed, name: 'primaryFixed')),
                              Center(child: ColorDemoContainer(colorScheme!.secondaryFixed, name: 'secondaryFixed')),
                              Center(child: ColorDemoContainer(colorScheme!.tertiaryFixed, name: 'tertiaryFixed')),
                            ],
                          ),

                          // Group 4: "OnFixed"
                          SizedBox(height: 4),
                          Tooltip(
                            message: 'Used for text and icons that exist on top of elements having Fixed color.',
                            child: Text(
                              'OnFixed',
                              style: Theme.of(context).textTheme.titleSmall,
                              textAlign: TextAlign.center,
                            ),
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Center(child: ColorDemoContainer(colorScheme!.onPrimaryFixed, name: 'onPrimaryFixed')),
                              Center(child: ColorDemoContainer(colorScheme!.onSecondaryFixed, name: 'onSecondaryFixed')),
                              Center(child: ColorDemoContainer(colorScheme!.onTertiaryFixed, name: 'onTertiaryFixed')),
                            ],
                          ),

                          // Group 5: "OnFixedVar"
                          SizedBox(height: 4),
                          Tooltip(
                            message: 'A lower-emphasis option for text and icons than onFixed.',
                            child: Text(
                              'OnFixedVar',
                              style: Theme.of(context).textTheme.titleSmall,
                              textAlign: TextAlign.center,
                            ),
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Center(child: ColorDemoContainer(colorScheme!.onPrimaryFixedVariant, name: 'onPrimaryFixedVariant')),
                              Center(child: ColorDemoContainer(colorScheme!.onSecondaryFixedVariant, name: 'onSecondaryFixedVariant')),
                              Center(child: ColorDemoContainer(colorScheme!.onTertiaryFixedVariant, name: 'onTertiaryFixedVariant')),
                            ],
                          ),

                          // Group 6: "FixedDim"
                          SizedBox(height: 4),
                          Tooltip(
                            message: 'Used for elements needing more emphasis than Fixed.',
                            child: Text(
                              'FixedDim',
                              style: Theme.of(context).textTheme.titleSmall,
                              textAlign: TextAlign.center,
                            ),
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Center(child: ColorDemoContainer(colorScheme!.primaryFixedDim, name: 'primaryFixedDim')),
                              Center(child: ColorDemoContainer(colorScheme!.secondaryFixedDim, name: 'secondaryFixedDim')),
                              Center(child: ColorDemoContainer(colorScheme!.tertiaryFixedDim, name: 'tertiaryFixedDim')),
                            ],
                          ),

                          // Group 7: "Container"
                          SizedBox(height: 4),
                          Tooltip(
                            message: 'Used for elements needing less emphasis than X-ary',
                            child: Text(
                              'Container',
                              style: Theme.of(context).textTheme.titleSmall,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Center(child: ColorDemoContainer(colorScheme!.primaryContainer, name: 'primaryContainer')),
                              Center(child: ColorDemoContainer(colorScheme!.secondaryContainer, name: 'secondaryContainer')),
                              Center(child: ColorDemoContainer(colorScheme!.tertiaryContainer, name: 'tertiaryContainer')),
                            ],
                          ),

                          // Group 8: "OnContainer"
                          SizedBox(height: 4),
                          Tooltip(
                            message: 'Clearly legible when drawn on Container.',
                            child: Text(
                              'OnContainer',
                              style: Theme.of(context).textTheme.titleSmall,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Center(child: ColorDemoContainer(colorScheme!.onPrimaryContainer, name: 'onPrimaryContainer')),
                              Center(child: ColorDemoContainer(colorScheme!.onSecondaryContainer, name: 'onSecondaryContainer')),
                              Center(child: ColorDemoContainer(colorScheme!.onTertiaryContainer, name: 'onTertiaryContainer')),
                            ],
                          ),
                        ],
                      ),

                      Divider(),
                      // Surfaces
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: 8,
                        children: [
                          Text('Surface colors', style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.center),
                          Tooltip(message: "Surface colors are used for backgrounds and large, low-emphasis areas of the screen.", child: Icon(Symbols.info_i, size: 16))
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text('   Dim'),
                          for (var e in [
                            ('SurfaceDim', colorScheme!.surfaceDim, "A color that's always darkest in the dark or light theme."),
                            ('Surface', colorScheme!.surface, "The background color for widgets like Scaffold."),
                            ('SurfaceBright', colorScheme!.surfaceBright, "A color that's always the lightest in the dark or light theme."),
                          ])
                            ColorDemoContainer(e.$2, name: e.$1, explanation: e.$3),
                          Text('Bright'),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Lowest'),
                          Text('← Container surfaces →', style: Theme.of(context).textTheme.titleSmall, textAlign: TextAlign.center),
                          Text('Highest'),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          for (var e in [
                            ('SurfaceContainerLowest', colorScheme!.surfaceContainerLowest, "A surface container color with the lightest tone and the least emphasis relative to the surface."),
                            (
                              'SurfaceContainerLow',
                              colorScheme!.surfaceContainerLow,
                              "A surface container color with a lighter tone that creates less emphasis than surfaceContainer but more emphasis than surfaceContainerLowest."
                            ),
                            (
                              'SurfaceContainer',
                              colorScheme!.surfaceContainer,
                              "A recommended color role for a distinct area within the surface.\nSurface container color roles are independent of elevation."
                            ),
                            (
                              'SurfaceContainerHigh',
                              colorScheme!.surfaceContainerHigh,
                              "A surface container color with a darker tone. It is used to create more emphasis than surfaceContainer but less emphasis than surfaceContainerHighest."
                            ),
                            (
                              'SurfaceContainerHighest',
                              colorScheme!.surfaceContainerHighest,
                              "A surface container color with the darkest tone. It is used to create the most emphasis against the surface."
                            ),
                          ])
                            ColorDemoContainer(e.$2, name: e.$1, explanation: e.$3),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            VerticalDivider(),
            Expanded(child: Demo(colorScheme: colorScheme)),
          ],
        ),
      );

  /* ColorScheme buildColorScheme() => ColorScheme(        
        // Surfaces
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

class Demo extends StatelessWidget {
  const Demo({
    super.key,
    required this.colorScheme,
  });

  final ColorScheme? colorScheme;

  @override
  Widget build(BuildContext context) {
    return Container(
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
          home: Navigator(
            key: Key('color demo navigator'),
            clipBehavior: Clip.hardEdge,
            onGenerateRoute: (settings) => MaterialPageRoute(
              builder: (context) => Scaffold(
                appBar: AppBar(
                  title: Text('AppBar'),
                  actionsPadding: EdgeInsets.only(right: 8),
                  actions: [
                    IconButton(
                        onPressed: () => showDialog(
                            useRootNavigator: false,
                            context: context,
                            builder: (c) => AlertDialog(
                                  actions: [TextButton(onPressed: Navigator.of(c).pop, child: Text('Oké'))],
                                  content: Text('Wow your settings are here\n\tI am setting one\n\tI am setting two'),
                                  title: Text('Preferences'),
                                )),
                        icon: Icon(Icons.settings))
                  ],
                ),
                drawer: Drawer(),
                bottomNavigationBar: BottomAppBar(
                  child: Row(
                    spacing: 8,
                    children: [
                      ElevatedButton(onPressed: () {}, child: Text('ElevatedButton')),
                      OutlinedButton(onPressed: () {}, child: const Text("OutlinedButton")),
                      TextButton(onPressed: () {}, child: const Text("TextButton")),
                    ],
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
    );
  }
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
              children: [
                Chip(label: Text("Chip 1")),
                FilterChip(onSelected: (value) {}, deleteIcon: Icon(Icons.close), label: Text("Chip 2")),
                ActionChip(avatar: Icon(Icons.favorite), label: Text("Chip 3"), onPressed: () {}),
                ActionChip(avatar: Icon(Icons.star), label: Text("Disabled Chip")),
              ],
            ),
            const SizedBox(height: 10),
            // Divider Widget
            const Divider(thickness: 2),
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

class ColorDemoContainer extends StatefulWidget {
  const ColorDemoContainer(this.color, {super.key, required this.name, this.explanation});

  final Color color;
  final String name;
  final String? explanation;

  @override
  State<ColorDemoContainer> createState() => _ColorDemoContainerState();
}

class _ColorDemoContainerState extends State<ColorDemoContainer> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) => MouseRegion(
        onEnter: (event) => setState(() => isHovered = true),
        onExit: (event) => setState(() => isHovered = false),
        child: Tooltip(
          message: '${widget.name}${widget.explanation != null ? "\n${widget.explanation!}" : ""}',
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(color: widget.color, borderRadius: BorderRadius.circular(8), border: Border.all(color: Theme.of(context).colorScheme.onSurface)),
            // child: AnimatedOpacity(
            //   opacity: isHovered ? 1 : 1,
            //   duration: Durations.medium1,
            //   child: Icon(Icons.copy),
            // ),
          ),
        ),
      );
}
