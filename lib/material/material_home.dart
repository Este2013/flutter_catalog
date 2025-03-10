import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_catalog/main.dart';
import 'package:flutter_svg/svg.dart';
import 'package:material_symbols_icons/get.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:material_symbols_icons/symbols_map.dart';
import 'package:url_launcher/url_launcher.dart';

class IconsPage extends StatefulWidget {
  const IconsPage({super.key, required this.appCtrl});

  final AppCtrl appCtrl;

  @override
  State<IconsPage> createState() => _IconsPageState();
}

class _IconsPageState extends State<IconsPage> {
  List<IconData> iconList = [];
  List<String> iconNameList = [];
  FontListType _fontListType = FontListType.outlined;

  final double _iconFontSize = 60.0;

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
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              width: 300,
              child: Column(
                spacing: 8,
                children: [
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            'Open in website',
                            textAlign: TextAlign.left,
                            style: Theme.of(context).textTheme.bodyMedium,
                            maxLines: 3,
                          ),
                          SizedBox.square(
                            dimension: 40,
                            child: IconButton.outlined(
                              color: Colors.grey,
                              onPressed: () {
                                launchUrl(Uri.parse('https://fonts.google.com/icons?icon.set=Material+Symbols'));
                              },
                              icon: const Icon(Symbols.open_in_new),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Divider(),
                  Row(
                    children: [
                      Expanded(child: Text('Style')),
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
                  )
                ],
              ),
            ),
            VerticalDivider(),
            Expanded(
              child: CustomScrollView(
                controller: _scrollController,
                slivers: [
                  SliverGrid(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final iconNameForIndex = /* TODO searchActive ? iconNameList[matches[index]] : */ iconNameList[index];
                        final iconDataForIndex = /* TODO searchActive ? iconList[matches[index]] : */ iconList[index];
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
                            child: Tooltip(
                              message: iconNameForIndex,
                              child: VariedIcon.varied(
                                iconDataForIndex,
                                size: _iconFontSize,
                              ),
                            ),
                          ),
                        );
                      },
                      childCount: /* TODO searchActive ? matches.length : */ iconNameList.length,
                    ),
                    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 150,
                    ),
                  ),
                ],
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
      ;
    });
  }

  @override
  Widget build(BuildContext context) {
    // var iconsData = icons5x5; // TODO Why is 3 a magic number here?
    // double wShifter = offset * widget.size.width * iconsData.first.length / 3;
    // double hShifter = offset * widget.size.height * iconsData.length / 3;
    // return Stack(
    //   children: [
    //     for (var iconList in iconsData.indexed)
    //       for (var icon in iconList.$2.indexed)
    //         Builder(builder: (context) {
    //           double left = iconList.$1 * wIconSpacing - wShifter;
    //           double top = icon.$1 * hIconSpacing - hShifter;

    //           if (left < -iconSize) left += iconsData[iconList.$1].length * wIconSpacing;
    //           if (top < -iconSize) top += iconList.$2.length * hIconSpacing;

    //           return Positioned(
    //             left: left,
    //             top: top,
    //             child: Icon(
    //               icon.$2,
    //               size: iconSize,
    //             ),
    //           );
    //         })
    //   ],
    // );
    return CustomPaint(
      size: widget.size,
      painter: IconGridPainter(
        offset: offset,
        iconsData: icons5x5,
        iconSize: iconSize,
        wIconSpacing: wIconSpacing,
        hIconSpacing: hIconSpacing,
      ),
    );
  }

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
