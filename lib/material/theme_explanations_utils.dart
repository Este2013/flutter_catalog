import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_catalog/utils/adaptive_tab_bar.dart';
import 'package:flutter_catalog/utils/better_widget_span.dart';
import 'package:flutter_catalog/widget_dialog.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:url_launcher/url_launcher.dart';

class InsetDisplay extends StatefulWidget {
  const InsetDisplay({super.key, this.icon, this.content});

  final Widget? icon, content;

  @override
  State<InsetDisplay> createState() => _InsetDisplayState();
}

class _InsetDisplayState extends State<InsetDisplay> {
  late Color color;

  int countAncestorsOfSameType(BuildContext context, Type typeToMatch) {
    int count = 0;

    context.visitAncestorElements((element) {
      if (element.widget.runtimeType == typeToMatch) {
        count++;
      }
      return true; // Keep visiting up the tree
    });

    return count;
  }

  @override
  Widget build(BuildContext context) => Row(
        children: [
          Padding(padding: const EdgeInsets.only(left: 16), child: widget.icon ?? Transform.rotate(angle: pi, child: Icon(Symbols.reply))),
          Flexible(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 1000),
              child: Card(
                color: countAncestorsOfSameType(context, InsetDisplay) % 2 == 0 ? Theme.of(context).colorScheme.surfaceContainer : Theme.of(context).colorScheme.surfaceContainerHigh,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: widget.content ?? Placeholder(),
                ),
              ),
            ),
          ),
        ],
      );
}

class InsetDisplayColumn extends StatelessWidget {
  const InsetDisplayColumn({super.key, this.icon, required this.children, this.spacing = 8});

  final Widget? icon;
  final List<Widget> children;
  final double spacing;

  @override
  Widget build(BuildContext context) => InsetDisplay(
        icon: icon,
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spacing,
          children: children,
        ),
      );
}

class ColorDisplayChip extends StatelessWidget {
  const ColorDisplayChip(
    this.color, {
    super.key,
  });

  final Color color;

  @override
  Widget build(BuildContext context) => Chip(
        avatar: Container(
          height: Theme.of(context).textTheme.bodyMedium?.fontSize ?? 14,
          width: Theme.of(context).textTheme.bodyMedium?.fontSize ?? 14,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            border: Border.all(color: Theme.of(context).dividerColor),
          ),
        ),
        label: Text(color.toHex()),
      );
}

class LinkChip extends StatelessWidget {
  const LinkChip(this.title, {super.key, this.link});

  /// 'https://api.flutter.dev/flutter/widgets/$widgetName-class.html'
  factory LinkChip.ofWidget(String widgetName) => LinkChip(widgetName, link: 'https://api.flutter.dev/flutter/widgets/$widgetName-class.html');

  /// 'https://api.flutter.dev/flutter/widgets/$widgetName/$propertyName.html'
  factory LinkChip.ofWidgetProperty(String widgetName, String propertyName, {String? customDisplay}) =>
      LinkChip(customDisplay ?? propertyName, link: 'https://api.flutter.dev/flutter/widgets/$widgetName/$propertyName.html');

  /// 'https://api.flutter.dev/flutter/material/IconButton/autofocus.html'
  factory LinkChip.ofMaterialProperty(String widgetName, String propertyName, {String? customDisplay}) =>
      LinkChip(customDisplay ?? propertyName, link: 'https://api.flutter.dev/flutter/material/$widgetName/$propertyName.html');

  final String title;
  final String? link;

  @override
  Widget build(BuildContext context) => ActionChip(
        label: Text(title),
        onPressed: link != null ? () => launchUrl(Uri.parse(link!)) : null,
      );

  CWidgetSpan asSpan() => CWidgetSpan(child: this);
}

class ClassThemingExplanationView extends StatefulWidget {
  const ClassThemingExplanationView({super.key, this.className, required this.propertiesData, this.baseDocsUrl});

  final String? className;

  /// Where keys property or group names, and values are PropertyData or Map`<String, PropertyData>`
  final PropertyGroupData propertiesData;

  /// Ex: for properties:
  ///  -> https://api.flutter.dev/flutter/material/IconButton/$propName.html,
  /// base url would be:
  ///  -> https://api.flutter.dev/flutter/material/IconButton
  /// without a slash at the end.
  final String? baseDocsUrl;

  @override
  State<ClassThemingExplanationView> createState() => _ClassThemingExplanationViewState();
}

class _ClassThemingExplanationViewState extends State<ClassThemingExplanationView> with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: widget.propertiesData.content.length, vsync: this);

    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: widget.className != null ? Text('${widget.className} Theming') : Text('Theming'),
          bottom: AdaptiveTabBar(
            controller: tabController,
            tabs: [
              for (var tabData in widget.propertiesData.content.entries)
                if (tabData.value is PropertyData)
                  Tab(icon: (tabData.value as PropertyData).icon, text: (tabData.value as PropertyData).tabName)
                else if (tabData.value is PropertyGroupData)
                  Tab(icon: (tabData.value as PropertyGroupData).icon, text: tabData.key)
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: TabBarView(
            controller: tabController,
            children: [
              for (var tabData in widget.propertiesData.content.entries)
                if (tabData.value is PropertyData)
                  PropertyExplanationView.fromPropertyData(tabData.value, baseLink: widget.baseDocsUrl)
                else if (tabData.value is PropertyGroupData)
                  _SubGroupThemingExplanationView(propertiesData: tabData.value, baseDocsUrl: (tabData.value as PropertyGroupData).baseDocsUrl ?? widget.baseDocsUrl),
            ],
          ),
        ),
      );
}

class _SubGroupThemingExplanationView extends StatelessWidget {
  const _SubGroupThemingExplanationView({required this.propertiesData, this.baseDocsUrl});

  /// Where keys property or group names, and values are PropertyData or Map`<String, PropertyData>`
  final PropertyGroupData propertiesData;

  /// Ex: for properties:
  ///  -> https://api.flutter.dev/flutter/material/IconButton/$propName.html,
  /// base url would be:
  ///  -> https://api.flutter.dev/flutter/material/IconButton
  /// without a slash at the end.
  final String? baseDocsUrl;

  @override
  Widget build(BuildContext context) => DefaultTabController(
        length: propertiesData.content.length,
        child: Scaffold(
          appBar: AdaptiveTabBar.secondary(
            tabs: [
              for (var tabData in propertiesData.content.entries)
                if (tabData.value is PropertyData)
                  Tab(icon: (tabData.value as PropertyData).icon, text: (tabData.value as PropertyData).tabName)
                else if (tabData.value is PropertyGroupData)
                  Tab(icon: (tabData.value as PropertyGroupData).icon, text: tabData.key)
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TabBarView(children: [
              for (var tabData in propertiesData.content.entries)
                if (tabData.value is PropertyData)
                  PropertyExplanationView.fromPropertyData(tabData.value, baseLink: baseDocsUrl)
                else if (tabData.value is PropertyGroupData)
                  _SubGroupThemingExplanationView(propertiesData: tabData.value, baseDocsUrl: (tabData.value as PropertyGroupData).baseDocsUrl ?? baseDocsUrl),
            ]),
          ),
        ),
      );
}

class PropertyGroupData {
  final String groupName;
  final String? baseDocsUrl;
  final Widget? icon;

  /// Where values can only be [PropertyGroupData] or [PropertyData].
  final Map<String, dynamic> content;

  PropertyGroupData({this.groupName = '', this.icon, required this.content, this.baseDocsUrl});
}

class PropertyData {
  final String propertyName;
  final Widget icon;
  final String? shortExplanation, docsLink;
  final List<Widget>? children;
  final Widget? child;
  final bool? onlyUsedWithMaterial3Warning;

  PropertyData(this.propertyName, {required this.icon, this.shortExplanation, this.docsLink, this.children, this.child, this.onlyUsedWithMaterial3Warning});

  String get tabName => _toSentenceCase(propertyName);

  /// Inserts spaces before upper-case letters and lower-cases them,
  /// then capitalises the very first character.
  ///
  /// Examples:
  ///   'camelCase'.toSentenceCase()        → 'Camel case'
  ///   'enableFeedback'.toSentenceCase()   → 'Enable feedback'
  ///   'iconURLLoader'.toSentenceCase()    → 'Icon url loader'
  String _toSentenceCase(String camelCase) {
    if (camelCase.isEmpty) return camelCase;

    final spaced = camelCase.replaceAllMapped(
      RegExp(r'([a-z])([A-Z])'),
      (m) => '${m[1]} ${m[2]!.toLowerCase()}',
    );

    // Capitalise the first letter only.
    return spaced[0].toUpperCase() + spaced.substring(1);
  }
}

class PropertyExplanationView extends StatefulWidget {
  const PropertyExplanationView(this.propertyName, {super.key, this.child, this.children, this.shortExplanation, this.docsLink, this.onlyUsedWithMaterial3Warning})
      : assert((child != null) ^ (children != null));

  factory PropertyExplanationView.fromPropertyData(PropertyData data, {String? baseLink}) => PropertyExplanationView(
        data.propertyName,
        docsLink: data.docsLink ?? (baseLink != null ? '${[baseLink, data.propertyName].join('/')}.html' : null),
        shortExplanation: data.shortExplanation,
        onlyUsedWithMaterial3Warning: data.onlyUsedWithMaterial3Warning,
        child: data.child,
        children: data.children,
      );

  final String propertyName;
  final String? shortExplanation, docsLink;
  final List<Widget>? children;
  final Widget? child;
  final bool? onlyUsedWithMaterial3Warning;

  @override
  State<PropertyExplanationView> createState() => PropertyExplanationViewState();
}

class PropertyExplanationViewState extends State<PropertyExplanationView> {
  bool showDocsPage = false;

  @override
  Widget build(BuildContext context) {
    Widget header = Row(
      spacing: 16,
      children: [
        Expanded(
            child: Column(
          spacing: 8,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (widget.shortExplanation != null) Text(widget.shortExplanation!),
            if (widget.onlyUsedWithMaterial3Warning != null) OnlyUsedWithMaterial3Warning(useMaterial3RequiredState: widget.onlyUsedWithMaterial3Warning!),
          ],
        )),
        SegmentedButton(
          segments: [
            ButtonSegment(value: false, icon: Icon(Symbols.conversion_path), tooltip: 'Property evaluation'),
            ButtonSegment(value: true, icon: Icon(Symbols.book_2), tooltip: 'Property documentation'),
            // TODO: Add tree view here per property instead of up in the beeg dialog
          ],
          selected: {showDocsPage},
          showSelectedIcon: false,
          onSelectionChanged: (p0) => setState(() => showDocsPage = p0.first),
        )
      ],
    );
    if (showDocsPage) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          header,
          Divider(),
          Expanded(child: DocsDisplayer(widget.docsLink!, pageName: widget.propertyName)),
        ],
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (widget.shortExplanation != null || widget.docsLink != null) header,
        Divider(),
        Expanded(
          child: Scaffold(
            appBar: AppBar(
              title: Text('${widget.propertyName} Evaluation'),
              automaticallyImplyLeading: false,
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  spacing: 8,
                  children: [...?widget.children, if (widget.child != null) widget.child!],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
          '${(a * 255).floor().toRadixString(16).padLeft(2, '0')}'
          '${(r * 255).floor().toRadixString(16).padLeft(2, '0')}'
          '${(g * 255).floor().toRadixString(16).padLeft(2, '0')}'
          '${(b * 255).floor().toRadixString(16).padLeft(2, '0')}'
      .toUpperCase();
}

class OnlyUsedWithMaterial3Warning extends StatelessWidget {
  const OnlyUsedWithMaterial3Warning({
    super.key,
    required this.useMaterial3RequiredState,
  });
  final bool useMaterial3RequiredState;

  @override
  Widget build(BuildContext context) => CRichText(
        context,
        children: [
          CWidgetSpan(child: Icon(Icons.warning_rounded, color: Theme.of(context).colorScheme.error)),
          TextSpan(text: ' Is only in use if '),
          LinkChip(
            'theme.useMaterial3 (${Theme.of(context).useMaterial3})',
            link: 'https://api.flutter.dev/flutter/material/ThemeData/useMaterial3.html',
          ).asSpan(),
          TextSpan(text: ' is $useMaterial3RequiredState.'),
        ],
      );
}
