import 'dart:math';

import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../theme_explanations_utils.dart';

class IconThemeExplanation extends StatefulWidget {
  const IconThemeExplanation({
    super.key,
  });

  @override
  State<IconThemeExplanation> createState() => _IconThemeExplanationState();
}

class _IconThemeExplanationState extends State<IconThemeExplanation> with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 7, vsync: this);
  }

  @override
  Widget build(BuildContext context) => Navigator(
        onGenerateRoute: (settings) => MaterialPageRoute(
          builder: (context) => Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Text('Theming'),
              bottom: TabBar(controller: tabController, tabs: [
                Tab(icon: Icon(Icons.colorize), child: Text('Color')),
                Tab(icon: Icon(Icons.gradient), child: Text('Fill')),
                Tab(icon: Icon(Icons.height), child: Text('Size')),
                Tab(icon: Icon(Icons.remove_red_eye), child: Text('Optical Size')),
                Tab(icon: Icon(Icons.balance), child: Text('Weight')),
                Tab(icon: Icon(Icons.grade), child: Text('Grade')),
                Tab(icon: Icon(Icons.opacity), child: Text('Opacity')),
              ]),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: TabBarView(
                controller: tabController,
                children: [
                  // color
                  IconColorExplanation(),
                  // fill
                  IconFillExplanation(),
                  // Size
                  IconSizeExplanation(),
                  // OpticalSize
                  IconOpticalSizeExplanation(),
                  // Grade
                  IconWeightExplanation(),
                  // Grade
                  IconGradeExplanation(),
                  // Opacity
                  IconOpacityExplanation(),
                ],
              ),
            ),
          ),
        ),
      );
}

class IconColorExplanation extends StatelessWidget {
  const IconColorExplanation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 8,
        children: [
          Text("The color, once evaluated, will be further adjusted by the nearest IconTheme's IconThemeData.opacity."),
          Divider(),
          RichText(
            text: TextSpan(
              style: Theme.of(context).textTheme.bodyMedium,
              children: [
                TextSpan(text: 'Use provided '),
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: LinkChip('Color', link: 'https://api.flutter.dev/flutter/dart-ui/Color-class.html'),
                )
              ],
            ),
          ),
          RichText(
            text: TextSpan(
              style: Theme.of(context).textTheme.bodyMedium,
              children: [TextSpan(text: 'If not provided, use '), WidgetSpan(alignment: PlaceholderAlignment.middle, child: LinkChip('IconTheme.of(context).color'))],
            ),
          ),
          InsetDisplay(
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 8,
              children: [
                RichText(
                  text: TextSpan(
                    style: Theme.of(context).textTheme.bodyMedium,
                    children: [
                      TextSpan(text: 'If '),
                      WidgetSpan(alignment: PlaceholderAlignment.middle, child: LinkChip('IconTheme.of', link: 'https://api.flutter.dev/flutter/widgets/IconTheme/of.html')),
                      TextSpan(text: ' finds a surrounding IconTheme widget'),
                    ],
                  ),
                ),
                InsetDisplay(
                  content: RichText(
                    text: TextSpan(
                      style: Theme.of(context).textTheme.bodyMedium,
                      children: [
                        TextSpan(text: 'Use corresponding '),
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: LinkChip('IconThemeData', link: 'https://api.flutter.dev/flutter/widgets/IconThemeData-class.html'),
                        ),
                        TextSpan(text: '\'s color'),
                      ],
                    ),
                  ),
                ),
                InsetDisplay(
                  icon: Icon(Symbols.info),
                  content: RichText(
                    text: TextSpan(
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(height: 2.6),
                      children: [
                        TextSpan(text: 'In material apps, if there is a '),
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: LinkChip('Theme', link: 'https://api.flutter.dev/flutter/material/Theme-class.html'),
                        ),
                        TextSpan(text: ' without any IconThemes specified, icon colors default to:\n - '),
                        WidgetSpan(alignment: PlaceholderAlignment.middle, child: ColorDisplayChip(Colors.black)),
                        TextSpan(text: ' if ThemeData.brightness is light;\n - '),
                        WidgetSpan(alignment: PlaceholderAlignment.middle, child: ColorDisplayChip(Colors.white)),
                        TextSpan(text: ' if ThemeData.brightness is dark.'),
                      ],
                    ),
                  ),
                ),
                RichText(
                  text: TextSpan(style: Theme.of(context).textTheme.bodyMedium?.copyWith(height: 2.5), children: [
                    TextSpan(text: 'Otherwise, use '),
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: LinkChip('IconThemeData.fallback()', link: 'https://api.flutter.dev/flutter/widgets/IconThemeData/IconThemeData.fallback.html'),
                    ),
                    TextSpan(text: '\'s color: '),
                    WidgetSpan(alignment: PlaceholderAlignment.middle, child: ColorDisplayChip(IconThemeData.fallback().color!)),
                  ]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class IconFillExplanation extends StatelessWidget {
  const IconFillExplanation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        spacing: 8,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text("The fill level of an icon is determined by evaluating the Icon's 'fill' property or falling back to the nearest IconTheme."),
          Divider(),
          RichText(
            text: TextSpan(
              style: Theme.of(context).textTheme.bodyMedium,
              children: [
                TextSpan(text: 'Use provided '),
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: LinkChip('fill', link: 'https://api.flutter.dev/flutter/widgets/Icon/fill.html'),
                )
              ],
            ),
          ),
          RichText(
            text: TextSpan(
              style: Theme.of(context).textTheme.bodyMedium,
              children: [
                TextSpan(text: 'If not provided, use '),
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: ActionChip(
                    label: Text('IconTheme.of(context).fill'),
                  ),
                )
              ],
            ),
          ),
          InsetDisplay(
            icon: Transform.rotate(angle: pi, child: Icon(Symbols.reply)),
            content: RichText(
              text: TextSpan(
                style: Theme.of(context).textTheme.bodyMedium,
                children: [
                  TextSpan(text: 'If '),
                  WidgetSpan(
                    alignment: PlaceholderAlignment.middle,
                    child: LinkChip('IconTheme.of', link: 'https://api.flutter.dev/flutter/widgets/IconTheme/of.html'),
                  ),
                  TextSpan(text: ' finds a surrounding IconTheme widget, it uses the corresponding '),
                  WidgetSpan(
                    alignment: PlaceholderAlignment.middle,
                    child: LinkChip('IconThemeData.fill', link: 'https://api.flutter.dev/flutter/widgets/IconThemeData/fill.html'),
                  ),
                  TextSpan(
                    style: Theme.of(context).textTheme.bodyMedium,
                    children: [
                      TextSpan(text: '\nIf none is found, use fallback fill value: '),
                      WidgetSpan(
                        child: Text(
                          '${IconThemeData.fallback().fill ?? 0.0}',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class IconSizeExplanation extends StatelessWidget {
  const IconSizeExplanation({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        spacing: 8,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text("The icon size is determined by the 'size' property, or inherited from the nearest IconTheme."),
          Divider(),
          RichText(
            text: TextSpan(
              style: Theme.of(context).textTheme.bodyMedium,
              children: [
                TextSpan(text: 'Use provided '),
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: LinkChip('size', link: 'https://api.flutter.dev/flutter/widgets/Icon/size.html'),
                ),
              ],
            ),
          ),
          RichText(
            text: TextSpan(
              style: Theme.of(context).textTheme.bodyMedium,
              children: [
                TextSpan(text: 'If not provided, use '),
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: ActionChip(
                    label: Text('IconTheme.of(context).size'),
                  ),
                ),
              ],
            ),
          ),
          InsetDisplay(
            icon: Transform.rotate(angle: pi, child: Icon(Symbols.reply)),
            content: RichText(
              text: TextSpan(
                style: Theme.of(context).textTheme.bodyMedium,
                children: [
                  TextSpan(text: 'Fallback size if none is provided: '),
                  WidgetSpan(
                    child: Text(
                      '${IconThemeData.fallback().size}',
                      style: TextStyle(fontWeight: FontWeight.bold),
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
}

class IconOpticalSizeExplanation extends StatelessWidget {
  const IconOpticalSizeExplanation({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        spacing: 8,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text("Optical size offers a way to automatically adjust the stroke weight as icon size changes."),
          Divider(),
          RichText(
            text: TextSpan(
              style: Theme.of(context).textTheme.bodyMedium,
              children: [
                TextSpan(text: 'Use provided '),
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: LinkChip('optical size', link: 'https://api.flutter.dev/flutter/widgets/Icon/opticalSize.html'),
                ),
              ],
            ),
          ),
          RichText(
            text: TextSpan(
              style: Theme.of(context).textTheme.bodyMedium,
              children: [
                TextSpan(text: 'If not provided, use '),
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: ActionChip(
                    label: Text('IconTheme.of(context).opticalSize'),
                  ),
                ),
              ],
            ),
          ),
          InsetDisplay(
            icon: Transform.rotate(angle: pi, child: Icon(Symbols.reply)),
            content: RichText(
              text: TextSpan(
                style: Theme.of(context).textTheme.bodyMedium,
                children: [
                  TextSpan(text: 'Fallback optical size: '),
                  WidgetSpan(
                    child: Text(
                      '${IconThemeData.fallback().opticalSize ?? "null"}',
                      style: TextStyle(fontWeight: FontWeight.bold),
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
}

class IconWeightExplanation extends StatelessWidget {
  const IconWeightExplanation({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        spacing: 8,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text("The weight of an icon affects how bold or light it appears."),
          Divider(),
          RichText(
            text: TextSpan(
              style: Theme.of(context).textTheme.bodyMedium,
              children: [
                TextSpan(text: 'Use provided '),
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: LinkChip('weight', link: 'https://api.flutter.dev/flutter/widgets/Icon/weight.html'),
                ),
              ],
            ),
          ),
          RichText(
            text: TextSpan(
              style: Theme.of(context).textTheme.bodyMedium,
              children: [
                TextSpan(text: 'If not provided, use '),
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: ActionChip(
                    label: Text('IconTheme.of(context).weight'),
                  ),
                ),
              ],
            ),
          ),
          InsetDisplay(
            icon: Transform.rotate(angle: pi, child: Icon(Symbols.reply)),
            content: RichText(
              text: TextSpan(
                style: Theme.of(context).textTheme.bodyMedium,
                children: [
                  TextSpan(text: 'Fallback weight: '),
                  WidgetSpan(
                    child: Text(
                      '${IconThemeData.fallback().weight ?? "null"}',
                      style: TextStyle(fontWeight: FontWeight.bold),
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
}

class IconGradeExplanation extends StatelessWidget {
  const IconGradeExplanation({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        spacing: 8,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text("Grade and weight both affect a symbol's stroke weight (thickness), but grade has a smaller impact on the size of the symbol."),
          Divider(),
          RichText(
            text: TextSpan(
              style: Theme.of(context).textTheme.bodyMedium,
              children: [
                TextSpan(text: 'Use provided '),
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: LinkChip('grade', link: 'https://api.flutter.dev/flutter/widgets/Icon/grade.html'),
                ),
              ],
            ),
          ),
          RichText(
            text: TextSpan(
              style: Theme.of(context).textTheme.bodyMedium,
              children: [
                TextSpan(text: 'If not provided, use '),
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: ActionChip(
                    label: Text('IconTheme.of(context).grade'),
                  ),
                ),
              ],
            ),
          ),
          InsetDisplay(
            icon: Transform.rotate(angle: pi, child: Icon(Symbols.reply)),
            content: RichText(
              text: TextSpan(
                style: Theme.of(context).textTheme.bodyMedium,
                children: [
                  TextSpan(text: 'Fallback grade: '),
                  WidgetSpan(
                    child: Text(
                      '${IconThemeData.fallback().grade ?? "null"}',
                      style: TextStyle(fontWeight: FontWeight.bold),
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
}

class IconOpacityExplanation extends StatelessWidget {
  const IconOpacityExplanation({super.key});

  @override
  Widget build(BuildContext context) {
    final fallbackOpacity = IconThemeData.fallback().opacity;

    return SingleChildScrollView(
      child: Column(
        spacing: 8,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text("Icon opacity is not a direct property on Icon, but is applied via IconTheme."),
          Divider(),
          RichText(
            text: TextSpan(
              style: Theme.of(context).textTheme.bodyMedium,
              children: [
                TextSpan(text: 'Icon color is modified by '),
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: LinkChip('IconThemeData.opacity', link: 'https://api.flutter.dev/flutter/widgets/IconThemeData/opacity.html'),
                ),
              ],
            ),
          ),
          InsetDisplay(
            icon: Icon(Symbols.info),
            content: Text("This value multiplies the icon's final color alpha."),
          ),
          RichText(
            text: TextSpan(
              style: Theme.of(context).textTheme.bodyMedium,
              children: [
                TextSpan(text: 'Fallback opacity: '),
                WidgetSpan(
                  child: Text(
                    '$fallbackOpacity',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
