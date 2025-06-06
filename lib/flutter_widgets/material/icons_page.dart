import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_catalog/main.dart';
import 'package:flutter_svg/svg.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:material_symbols_icons/symbols_map.dart';
import 'package:url_launcher/url_launcher.dart';

class IconsPage extends StatefulWidget {
  const IconsPage({super.key, required this.appCtrl});

  final AppCtrl appCtrl;

  @override
  State<IconsPage> createState() => _IconsPageState();
}

class _IconsPageState extends State<IconsPage> with TickerProviderStateMixin {
  List<IconData> iconList = [];
  List<String> iconNameList = [];

  int viewMode = 0;

  FontListType _fontListType = FontListType.outlined;
  final double _iconFontSize = 60.0;

  double iconWeight = 400;
  double iconGrade = 0;
  double iconOpticalSize = 48;

  // fill control
  late Animation<double> fillTween;
  late AnimationController fillController;

  // Search
  bool _isSearchFocused = false;
  late TextEditingController searchController;
  bool get searchActive => searchController.text.isNotEmpty;
  List<int> matches = [];

  // Data
  Map<String, IconData> materialSymbolsOutlinedMap = {};
  Map<String, IconData> materialSymbolsRoundedMap = {};
  Map<String, IconData> materialSymbolsSharpMap = {};
  List<String> renamedMaterialSymbolsMapKeys = [];
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    for (final key in materialSymbolsMap.keys.toList()) {
      if (key.endsWith('_rounded')) {
        materialSymbolsRoundedMap[key] = materialSymbolsMap[key]!;
      } else if (key.endsWith('_sharp')) {
        materialSymbolsSharpMap[key] = materialSymbolsMap[key]!;
      } else {
        materialSymbolsOutlinedMap[key] = materialSymbolsMap[key]!;
      }
    }
    iconList = materialSymbolsOutlinedMap.values.toList();
    iconNameList = materialSymbolsOutlinedMap.keys.toList();
    // make a list of renamed icons
    renamedMaterialSymbolsMapKeys = renamedMaterialSymbolsMap.keys.toList();

    // fill control
    fillController = AnimationController(duration: Durations.short2, vsync: this);
    fillTween = Tween<double>(begin: 0, end: 1).animate(fillController);

    // search
    searchController = TextEditingController()
      ..addListener(
        () {
          setState(() {
            if (searchActive) {
              matches = searchIconNameList(searchController.text);
            } else {
              matches = [];
            }
          });
        },
      );

    super.initState();
  }

  void _onFontListTypeChange(FontListType? val) => setState(() {
        _fontListType = val ?? FontListType.outlined;
        switch (_fontListType) {
          case FontListType.outlined:
            iconList = materialSymbolsOutlinedMap.values.toList();
            iconNameList = materialSymbolsOutlinedMap.keys.toList();
            break;
          case FontListType.rounded:
            iconList = materialSymbolsRoundedMap.values.toList();
            iconNameList = materialSymbolsRoundedMap.keys.toList();
            break;
          case FontListType.sharp:
            iconList = materialSymbolsSharpMap.values.toList();
            iconNameList = materialSymbolsSharpMap.keys.toList();
            break;
          case FontListType.universal:
            iconList = materialSymbolsMap.values.toList();
            iconNameList = materialSymbolsMap.keys.toList();
            break;
        }
      });

  List<int> searchIconNameList(String searchString) {
    List<int> matchIndices = [];
    searchString = searchString.toLowerCase();
    for (int i = 0; i < iconNameList.length; i++) {
      if (iconNameList[i].toLowerCase().contains(searchString)) {
        matchIndices.add(i);
      }
    }
    for (int j = 0; j < renamedMaterialSymbolsMapKeys.length; j++) {
      if (renamedMaterialSymbolsMapKeys[j].toLowerCase().contains(searchString)) {
        // get renamed name and find it's indices
        final iconWasRenamedTo = renamedMaterialSymbolsMap[renamedMaterialSymbolsMapKeys[j]]!; // we know this is a valid key
        int i = iconNameList.indexOf(iconWasRenamedTo);
        if (i != -1 && !matchIndices.contains(i)) {
          // add to list if it's not there already
          matchIndices.add(i);
        }
      }
    }
    return matchIndices;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
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
                            onTap: () => launchUrl(Uri.parse('https://fonts.google.com/icons?icon.set=Material+Symbols')),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    'Open in website',
                                    textAlign: TextAlign.left,
                                    style: Theme.of(context).textTheme.titleMedium,
                                    maxLines: 3,
                                  ),
                                  SizedBox.square(dimension: 40, child: Icon(Symbols.open_in_new)),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Divider(),
                      FocusTraversalOrder(
                        order: NumericFocusOrder(1),
                        child: Focus(
                          onFocusChange: (focus) {
                            setState(() {
                              _isSearchFocused = focus;
                            });
                          },
                          child: TextField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              label: Text('Search'),
                              // icon: Icon(Icons.search),
                              suffixIcon: _isSearchFocused
                                  ? IconButton(
                                      icon: const Icon(Symbols.close),
                                      onPressed: () {
                                        FocusScope.of(context).unfocus();
                                        searchController.clear();
                                      },
                                    )
                                  : null,
                            ),
                            controller: searchController,
                          ),
                        ),
                      ),
                      Divider(),
                      FocusTraversalOrder(
                        order: NumericFocusOrder(2),
                        child: Row(
                          children: [
                            Expanded(child: Text('Style', style: Theme.of(context).textTheme.titleMedium)),
                            SegmentedButton(
                              segments: [
                                ButtonSegment(value: FontListType.outlined, icon: Icon(Symbols.square), tooltip: 'Outlined'),
                                ButtonSegment(value: FontListType.rounded, icon: Icon(Symbols.circle), tooltip: 'Rounded'),
                                ButtonSegment(value: FontListType.sharp, icon: Icon(Symbols.cut), tooltip: 'Sharp'),
                              ],
                              selected: {_fontListType},
                              showSelectedIcon: false,
                              onSelectionChanged: (p0) => _onFontListTypeChange(p0.firstOrNull),
                            ),
                          ],
                        ),
                      ),
                      FocusTraversalOrder(
                        order: NumericFocusOrder(3),
                        child: Row(
                          children: [
                            Expanded(child: Text('Fill', style: Theme.of(context).textTheme.titleMedium)),
                            AnimatedBuilder(
                              animation: fillController,
                              builder: (context, child) => Switch(
                                  value: fillController.isForwardOrCompleted,
                                  onChanged: (v) {
                                    if (fillController.isForwardOrCompleted) {
                                      fillController.reverse();
                                    } else {
                                      fillController.forward();
                                    }
                                  }),
                            ),
                          ],
                        ),
                      ),
                      FocusTraversalOrder(
                        order: NumericFocusOrder(4),
                        child: Row(
                          children: [
                            Expanded(child: Text('Weight', style: Theme.of(context).textTheme.titleMedium)),
                            Slider(
                              value: iconWeight,
                              onChanged: (w) => setState(
                                () => iconWeight = w,
                              ),
                              min: 100,
                              max: 700,
                              divisions: 6,
                              label: iconWeight.floor().toString(),
                            ),
                          ],
                        ),
                      ),
                      FocusTraversalOrder(
                        order: NumericFocusOrder(5),
                        child: Row(
                          children: [
                            Expanded(child: Text('Grade', style: Theme.of(context).textTheme.titleMedium)),
                            Slider(
                              value: iconGrade,
                              onChanged: (w) => setState(
                                () => iconGrade = w,
                              ),
                              min: -25,
                              max: 200,
                              divisions: 9,
                              label: iconGrade.floor().toString(),
                            ),
                          ],
                        ),
                      ),
                      FocusTraversalOrder(
                        order: NumericFocusOrder(6),
                        child: Row(
                          children: [
                            Expanded(child: Text('Optical size', style: Theme.of(context).textTheme.titleMedium)),
                            Slider(
                              value: iconOpticalSize,
                              onChanged: (w) => setState(
                                () => iconOpticalSize = w,
                              ),
                              min: 20,
                              max: 48,
                              divisions: 5,
                              label: "${iconOpticalSize.floor()} dp",
                            ),
                          ],
                        ),
                      ),
                      Divider(),
                      FocusTraversalOrder(
                        order: NumericFocusOrder(7),
                        child: Row(
                          children: [
                            Expanded(child: Text('View', style: Theme.of(context).textTheme.titleMedium)),
                            SegmentedButton(
                              segments: [
                                ButtonSegment(value: 0, icon: Icon(Symbols.view_comfy_alt), tooltip: 'Comfy'),
                                ButtonSegment(value: 1, icon: Icon(Symbols.grid_view), tooltip: 'Dense'),
                                ButtonSegment(value: 2, icon: Icon(Symbols.view_list), tooltip: 'With tags'),
                              ],
                              selected: {viewMode},
                              showSelectedIcon: false,
                              onSelectionChanged: (p0) => setState(() => viewMode = p0.first),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            VerticalDivider(),
            Expanded(
              child: Focus(
                child: CustomScrollView(
                  controller: _scrollController,
                  slivers: [
                    SliverGrid(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final iconNameForIndex = searchActive ? iconNameList[matches[index]] : iconNameList[index];
                          final iconDataForIndex = searchActive ? iconList[matches[index]] : iconList[index];
                          return Card(
                            clipBehavior: Clip.hardEdge,
                            child: InkWell(
                              onTap: () {
                                final iconName = 'Symbols.$iconNameForIndex';
                                Clipboard.setData(ClipboardData(text: iconName)).then((_) {
                                  if (context.mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Copied "$iconName" to the clipboard.')));
                                  }
                                });
                              },
                              child: viewMode != 2
                                  ? Tooltip(
                                      message: iconNameForIndex,
                                      ignorePointer: true,
                                      child: AnimatedBuilder(
                                        animation: Listenable.merge([fillController]),
                                        builder: (context, child) => VariedIcon.varied(
                                          iconDataForIndex,
                                          size: viewMode == 0 ? _iconFontSize : 40,
                                          fill: fillController.value,
                                          weight: iconWeight,
                                          grade: iconGrade,
                                          opticalSize: iconOpticalSize,
                                        ),
                                      ),
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                      child: Row(
                                        children: [
                                          AnimatedBuilder(
                                            animation: Listenable.merge([fillController]),
                                            builder: (context, child) => VariedIcon.varied(
                                              iconDataForIndex,
                                              size: viewMode == 0 ? _iconFontSize : 40,
                                              fill: fillController.value,
                                              weight: iconWeight,
                                              grade: iconGrade,
                                              opticalSize: iconOpticalSize,
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              iconNameForIndex.replaceAll('_', ' '),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                            ),
                          );
                        },
                        childCount: searchActive ? matches.length : iconNameList.length,
                      ),
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: (viewMode == 0)
                            ? 150
                            : viewMode == 1
                                ? 70
                                : 300,
                        mainAxisExtent: viewMode == 2 ? 70 : null,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
}

enum FontListType { outlined, rounded, sharp, universal }

class InfiniteIconScroll extends StatefulWidget {
  const InfiniteIconScroll({super.key, required this.size, this.iconSize});

  final Size size;
  final double? iconSize;

  @override
  State<InfiniteIconScroll> createState() => _InfiniteIconScrollState();
}

class _InfiniteIconScrollState extends State<InfiniteIconScroll> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<List<IconData>> icons5x5 = [
    [
      Icons.star,
      Icons.favorite,
      Icons.cake,
      Icons.thumb_up,
      Icons.flash_on,
    ],
    [
      Icons.abc,
      Icons.leave_bags_at_home_outlined,
      Icons.read_more,
      Icons.zoom_out,
      Icons.ac_unit,
    ],
    [
      Icons.camera_indoor_sharp,
      Icons.headset,
      Icons.format_shapes,
      Icons.explore,
      Icons.open_in_new,
    ],
    [
      Icons.repeat_sharp,
      Icons.real_estate_agent,
      Icons.snapchat,
      Icons.sync_rounded,
      Icons.toll,
    ],
    [
      Icons.umbrella,
      Icons.u_turn_left,
      Icons.share,
      Icons.stadium,
      Icons.qr_code,
    ],
  ];
  final List<List<IconData>> icons3x3 = [
    [
      Icons.star,
      Icons.favorite,
      Icons.cake,
    ],
    [
      Icons.abc,
      Icons.leave_bags_at_home_outlined,
      Icons.read_more,
    ],
    [
      Icons.camera_indoor_sharp,
      Icons.headset,
      Icons.format_shapes,
    ],
  ];

  double offset = 0;
  final double speed = .001; // Speed of movement

  late double iconSize;
  late double wIconSpacing;
  late double hIconSpacing;

  @override
  void initState() {
    super.initState();

    iconSize = widget.iconSize ?? 24;
    wIconSpacing = 2 * iconSize;
    hIconSpacing = wIconSpacing * (widget.size.height / widget.size.width);

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 60),
    )..addListener(() {
        _updatePositions();
      });
    _controller.repeat();
  }

  void _updatePositions() {
    setState(() {
      offset += speed;
      if (offset > 1) {
        offset = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) => CustomPaint(
        size: widget.size,
        painter: IconGridPainter(
          offset: offset,
          iconsData: icons5x5,
          iconSize: iconSize,
          wIconSpacing: wIconSpacing,
          hIconSpacing: hIconSpacing,
        ),
      );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class IconGridPainter extends CustomPainter {
  final double offset;
  final List<List<IconData>> iconsData;
  final double iconSize;
  final double wIconSpacing;
  final double hIconSpacing;

  IconGridPainter({
    required this.offset,
    required this.iconsData,
    required this.iconSize,
    required this.wIconSpacing,
    required this.hIconSpacing,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Compute shifters based on the size and magic number (3)
    double wShifter = offset * size.width * iconsData.first.length / 3;
    double hShifter = offset * size.height * iconsData.length / 3;

    // Loop over the grid of icons
    for (int row = 0; row < iconsData.length; row++) {
      for (int col = 0; col < iconsData[row].length; col++) {
        // Calculate initial positions
        double left = row * wIconSpacing - wShifter;
        double top = col * hIconSpacing - hShifter;

        // Wrap around if the icon is offscreen
        if (left < -iconSize) {
          left += iconsData[row].length * wIconSpacing;
        }
        if (top < -iconSize) {
          top += iconsData[row].length * hIconSpacing;
        }

        // Retrieve the icon data
        final iconData = iconsData[row][col];

        // Use a TextPainter to draw the icon as text.
        final textPainter = TextPainter(
          text: TextSpan(
            text: String.fromCharCode(iconData.codePoint),
            style: TextStyle(
              fontSize: iconSize,
              fontFamily: iconData.fontFamily,
              package: iconData.fontPackage,
            ),
          ),
          textDirection: TextDirection.ltr,
        );
        textPainter.layout();
        textPainter.paint(canvas, Offset(left, top));
      }
    }
  }

  @override
  bool shouldRepaint(covariant IconGridPainter oldDelegate) {
    // Repaint when the offset (or any other property) changes.
    return oldDelegate.offset != offset;
  }
}
