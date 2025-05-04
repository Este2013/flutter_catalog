import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_catalog/utils/better_widget_span.dart';
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
            builder: (context) => ClassThemingExplanationView(
                className: 'Icon',
                baseDocsUrl: 'https://api.flutter.dev/flutter/widgets/Icon',
                propertiesData: PropertyGroupData(content: {
                  'Color': PropertyData(
                    'color',
                    icon: Icon(Icons.colorize),
                    child: IconColorExplanation(),
                  ),
                  'Fill': PropertyData(
                    'fill',
                    icon: Icon(Icons.gradient),
                    child: IconFillExplanation(),
                  ),
                  'Size': PropertyData(
                    'size',
                    icon: Icon(Icons.height),
                    child: IconSizeExplanation(),
                  ),
                  'Optical Size': PropertyData(
                    'opticalSize',
                    icon: Icon(Icons.remove_red_eye),
                    child: IconOpticalSizeExplanation(),
                  ),
                  'Weight': PropertyData(
                    'weight',
                    icon: Icon(Icons.balance),
                    child: IconWeightExplanation(),
                  ),
                  'Grade': PropertyData(
                    'grade',
                    icon: Icon(Icons.grade),
                    child: IconGradeExplanation(),
                  ),
                  'Opacity': PropertyData(
                    'opacity',
                    icon: Icon(Icons.opacity),
                    child: IconOpacityExplanation(),
                  ),
                }))),
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
          CRichText(
            context,
            children: [
              TextSpan(text: 'Use provided '),
              CWidgetSpan(child: LinkChip('Color', link: 'https://api.flutter.dev/flutter/dart-ui/Color-class.html')),
            ],
          ),
          CRichText(
            context,
            children: [TextSpan(text: 'If not provided, use '), CWidgetSpan(child: LinkChip('IconTheme.of(context).color'))],
          ),
          InsetDisplay(
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 8,
              children: [
                CRichText(
                  context,
                  children: [
                    TextSpan(text: 'If '),
                    CWidgetSpan(child: LinkChip('IconTheme.of', link: 'https://api.flutter.dev/flutter/widgets/IconTheme/of.html')),
                    TextSpan(text: ' finds a surrounding IconTheme widget'),
                  ],
                ),
                InsetDisplay(
                  content: CRichText(
                    context,
                    children: [
                      TextSpan(text: 'Use corresponding '),
                      CWidgetSpan(
                        child: LinkChip('IconThemeData', link: 'https://api.flutter.dev/flutter/widgets/IconThemeData-class.html'),
                      ),
                      TextSpan(text: '\'s color'),
                    ],
                  ),
                ),
                InsetDisplay(
                  icon: Icon(Symbols.info),
                  content: RichText(
                    text: TextSpan(
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(height: 2.6),
                      children: [
                        TextSpan(text: 'In material apps, if there is a '),
                        CWidgetSpan(
                          child: LinkChip('Theme', link: 'https://api.flutter.dev/flutter/material/Theme-class.html'),
                        ),
                        TextSpan(text: ' without any IconThemes specified, icon colors default to:\n - '),
                        CWidgetSpan(child: ColorDisplayChip(Colors.black)),
                        TextSpan(text: ' if ThemeData.brightness is light;\n - '),
                        CWidgetSpan(child: ColorDisplayChip(Colors.white)),
                        TextSpan(text: ' if ThemeData.brightness is dark.'),
                      ],
                    ),
                  ),
                ),
                CRichText(context, children: [
                  TextSpan(text: 'Otherwise, use '),
                  CWidgetSpan(
                    child: LinkChip('IconThemeData.fallback()', link: 'https://api.flutter.dev/flutter/widgets/IconThemeData/IconThemeData.fallback.html'),
                  ),
                  TextSpan(text: '\'s color: '),
                  CWidgetSpan(child: ColorDisplayChip(IconThemeData.fallback().color!)),
                ]),
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
          CRichText(
            context,
            children: [
              TextSpan(text: 'Use provided '),
              CWidgetSpan(
                child: LinkChip('fill', link: 'https://api.flutter.dev/flutter/widgets/Icon/fill.html'),
              )
            ],
          ),
          CRichText(
            context,
            children: [
              TextSpan(text: 'If not provided, use '),
              CWidgetSpan(
                child: ActionChip(
                  label: Text('IconTheme.of(context).fill'),
                ),
              )
            ],
          ),
          InsetDisplay(
            icon: Transform.rotate(angle: pi, child: Icon(Symbols.reply)),
            content: CRichText(
              context,
              children: [
                TextSpan(text: 'If '),
                CWidgetSpan(
                  child: LinkChip('IconTheme.of', link: 'https://api.flutter.dev/flutter/widgets/IconTheme/of.html'),
                ),
                TextSpan(text: ' finds a surrounding IconTheme widget, it uses the corresponding '),
                CWidgetSpan(
                  child: LinkChip('IconThemeData.fill', link: 'https://api.flutter.dev/flutter/widgets/IconThemeData/fill.html'),
                ),
                TextSpan(
                  style: Theme.of(context).textTheme.bodyMedium,
                  children: [
                    TextSpan(text: '\nIf none is found, use fallback fill value: '),
                    CWidgetSpan(
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
          CRichText(
            context,
            children: [
              TextSpan(text: 'Use provided '),
              CWidgetSpan(
                child: LinkChip('size', link: 'https://api.flutter.dev/flutter/widgets/Icon/size.html'),
              ),
            ],
          ),
          CRichText(
            context,
            children: [
              TextSpan(text: 'If not provided, use '),
              CWidgetSpan(
                child: ActionChip(
                  label: Text('IconTheme.of(context).size'),
                ),
              ),
            ],
          ),
          InsetDisplay(
            icon: Transform.rotate(angle: pi, child: Icon(Symbols.reply)),
            content: CRichText(
              context,
              children: [
                TextSpan(text: 'Fallback size if none is provided: '),
                CWidgetSpan(
                  child: Text(
                    '${IconThemeData.fallback().size}',
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
          CRichText(
            context,
            children: [
              TextSpan(text: 'Use provided '),
              CWidgetSpan(
                child: LinkChip('optical size', link: 'https://api.flutter.dev/flutter/widgets/Icon/opticalSize.html'),
              ),
            ],
          ),
          CRichText(
            context,
            children: [
              TextSpan(text: 'If not provided, use '),
              CWidgetSpan(
                child: ActionChip(
                  label: Text('IconTheme.of(context).opticalSize'),
                ),
              ),
            ],
          ),
          InsetDisplay(
            icon: Transform.rotate(angle: pi, child: Icon(Symbols.reply)),
            content: CRichText(
              context,
              children: [
                TextSpan(text: 'Fallback optical size: '),
                CWidgetSpan(
                  child: Text(
                    '${IconThemeData.fallback().opticalSize ?? "null"}',
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
          CRichText(
            context,
            children: [
              TextSpan(text: 'Use provided '),
              CWidgetSpan(
                child: LinkChip('weight', link: 'https://api.flutter.dev/flutter/widgets/Icon/weight.html'),
              ),
            ],
          ),
          CRichText(
            context,
            children: [
              TextSpan(text: 'If not provided, use '),
              CWidgetSpan(
                child: ActionChip(
                  label: Text('IconTheme.of(context).weight'),
                ),
              ),
            ],
          ),
          InsetDisplay(
            icon: Transform.rotate(angle: pi, child: Icon(Symbols.reply)),
            content: CRichText(
              context,
              children: [
                TextSpan(text: 'Fallback weight: '),
                CWidgetSpan(
                  child: Text(
                    '${IconThemeData.fallback().weight ?? "null"}',
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
          CRichText(
            context,
            children: [
              TextSpan(text: 'Use provided '),
              CWidgetSpan(
                child: LinkChip('grade', link: 'https://api.flutter.dev/flutter/widgets/Icon/grade.html'),
              ),
            ],
          ),
          CRichText(
            context,
            children: [
              TextSpan(text: 'If not provided, use '),
              CWidgetSpan(
                child: ActionChip(
                  label: Text('IconTheme.of(context).grade'),
                ),
              ),
            ],
          ),
          InsetDisplay(
            icon: Transform.rotate(angle: pi, child: Icon(Symbols.reply)),
            content: CRichText(
              context,
              children: [
                TextSpan(text: 'Fallback grade: '),
                CWidgetSpan(
                  child: Text(
                    '${IconThemeData.fallback().grade ?? "null"}',
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
          CRichText(
            context,
            children: [
              TextSpan(text: 'Icon color is modified by '),
              CWidgetSpan(
                child: LinkChip('IconThemeData.opacity', link: 'https://api.flutter.dev/flutter/widgets/IconThemeData/opacity.html'),
              ),
            ],
          ),
          InsetDisplay(
            icon: Icon(Symbols.info),
            content: Text("This value multiplies the icon's final color alpha."),
          ),
          CRichText(
            context,
            children: [
              TextSpan(text: 'Fallback opacity: '),
              CWidgetSpan(
                child: Text(
                  '$fallbackOpacity',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
