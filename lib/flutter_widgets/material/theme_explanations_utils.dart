import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_catalog/presentation/docs_display.dart';
import 'package:flutter_catalog/utils/adaptive_tab_bar.dart';
import 'package:flutter_catalog/utils/better_widget_span.dart';
import 'package:flutter_catalog/presentation/widget_dialog.dart';
import 'package:flutter_catalog/widget_tree_resolver/data.dart';
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
  const ClassThemingExplanationView({super.key, this.className, required this.propertiesData, this.baseDocsUrl, this.treeNodeData});

  final String? className;

  /// Where keys property or group names, and values are PropertyData or Map`<String, PropertyData>`
  final PropertyGroupData propertiesData;
  final WidgetTreeNodeData? treeNodeData;

  /// Ex: for properties:
  ///  -> https://api.flutter.dev/flutter/material/IconButton/$propName.html,
  /// base url would be:
  ///  -> https://api.flutter.dev/flutter/material/IconButton
  /// without a slash at the end.
  final String? baseDocsUrl;

  @override
  State<ClassThemingExplanationView> createState() => _ClassThemingExplanationViewState();
}

enum ShownPage { eval, docs, tree }

class _ClassThemingExplanationViewState extends State<ClassThemingExplanationView> with TickerProviderStateMixin {
  late TabController tabController;

  ShownPage defaultShownPage = ShownPage.eval;
  void setDefaultShownPage(ShownPage s) => setState(() => defaultShownPage = s);

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
                  PropertyExplanationView.fromPropertyData(
                    tabData.value,
                    baseLink: widget.baseDocsUrl,
                    treeNodeData: widget.treeNodeData,
                    defaultShownPage: defaultShownPage,
                    setShownPage: setDefaultShownPage,
                  )
                else if (tabData.value is PropertyGroupData)
                  _SubGroupThemingExplanationView(
                    propertiesData: tabData.value,
                    baseDocsUrl: (tabData.value as PropertyGroupData).baseDocsUrl ?? widget.baseDocsUrl,
                    treeNodeData: widget.treeNodeData,
                    defaultShownPage: defaultShownPage,
                    setShownPage: setDefaultShownPage,
                  ),
            ],
          ),
        ),
      );
}

class _SubGroupThemingExplanationView extends StatelessWidget {
  const _SubGroupThemingExplanationView({required this.propertiesData, this.baseDocsUrl, required this.treeNodeData, required this.defaultShownPage, required this.setShownPage});

  /// Where keys property or group names, and values are PropertyData or Map`<String, PropertyData>`
  final PropertyGroupData propertiesData;

  final ShownPage defaultShownPage;
  final void Function(ShownPage s) setShownPage;

  /// Ex: for properties:
  ///  -> https://api.flutter.dev/flutter/material/IconButton/$propName.html,
  /// base url would be:
  ///  -> https://api.flutter.dev/flutter/material/IconButton
  /// without a slash at the end.
  final String? baseDocsUrl;
  final WidgetTreeNodeData? treeNodeData;

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
                  PropertyExplanationView.fromPropertyData(
                    tabData.value,
                    baseLink: baseDocsUrl,
                    treeNodeData: treeNodeData,
                    defaultShownPage: defaultShownPage,
                    setShownPage: setShownPage,
                  )
                else if (tabData.value is PropertyGroupData)
                  _SubGroupThemingExplanationView(
                    propertiesData: tabData.value,
                    baseDocsUrl: (tabData.value as PropertyGroupData).baseDocsUrl ?? baseDocsUrl,
                    treeNodeData: treeNodeData,
                    defaultShownPage: defaultShownPage,
                    setShownPage: setShownPage,
                  ),
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
  const PropertyExplanationView(
    this.propertyName, {
    super.key,
    this.child,
    this.children,
    this.shortExplanation,
    this.docsLink,
    this.onlyUsedWithMaterial3Warning,
    this.treeNodeData,
    required this.defaultShownPage,
    required this.setShownPage,
  }) : assert((child != null) ^ (children != null));

  factory PropertyExplanationView.fromPropertyData(
    PropertyData data, {
    String? baseLink,
    WidgetTreeNodeData? treeNodeData,
    required ShownPage defaultShownPage,
    required void Function(ShownPage s) setShownPage,
  }) =>
      PropertyExplanationView(
        data.propertyName,
        docsLink: data.docsLink ?? (baseLink != null ? '${[baseLink, data.propertyName].join('/')}.html' : null),
        shortExplanation: data.shortExplanation,
        onlyUsedWithMaterial3Warning: data.onlyUsedWithMaterial3Warning,
        child: data.child,
        children: data.children,
        treeNodeData: treeNodeData,
        defaultShownPage: defaultShownPage,
        setShownPage: setShownPage,
      );

  final String propertyName;
  final String? shortExplanation, docsLink;
  final List<Widget>? children;
  final Widget? child;
  final bool? onlyUsedWithMaterial3Warning;
  final WidgetTreeNodeData? treeNodeData;

  final ShownPage defaultShownPage;
  final void Function(ShownPage s) setShownPage;

  @override
  State<PropertyExplanationView> createState() => PropertyExplanationViewState();
}

class PropertyExplanationViewState extends State<PropertyExplanationView> {
  List<ShownPage> _availablePages() => [
        if (widget.child != null || widget.children != null) ShownPage.eval,
        if (widget.docsLink != null) ShownPage.docs,
        if (widget.treeNodeData != null) ShownPage.tree,
      ];

  ShownPage? _findAvailablePage(ShownPage def, List<ShownPage> available) {
    if (available.isEmpty) return null;
    if (!available.contains(def)) {
      return available.first;
    }
    return def;
  }

  @override
  Widget build(BuildContext context) {
    var availablePages = _availablePages();
    var shownPage = _findAvailablePage(widget.defaultShownPage, availablePages);

    Widget modeChoosingButton = SegmentedButton(
      segments: [
        (ShownPage.eval, Symbols.conversion_path, 'Property evaluation'),
        (ShownPage.docs, Symbols.book_2, 'Property documentation'),
        (ShownPage.tree, Symbols.view_object_track, 'Property tree view'),
      ]
          .map(
            (e) => ButtonSegment(
              value: e.$1,
              icon: Icon(e.$2),
              tooltip: e.$3,
              enabled: availablePages.contains(e.$1),
            ),
          )
          .toList(),
      selected: {shownPage},
      showSelectedIcon: false,
      onSelectionChanged: (p0) => widget.setShownPage(p0.first!),
    );

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
      ],
    );
    if (shownPage == null) return Placeholder();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (widget.shortExplanation != null || widget.docsLink != null) header,
        if (shownPage == ShownPage.eval)
          Expanded(
            child: _EvaluationOfTheming(
              propertyName: widget.propertyName,
              child: widget.child,
              children: widget.children,
              modeChoosingButton: modeChoosingButton,
            ),
          ),
        if (shownPage == ShownPage.docs)
          Expanded(
            child: DocsDisplayer(
              widget.docsLink!,
              pageName: widget.propertyName,
              actions: [SizedBox(width: 8), modeChoosingButton],
            ),
          ),
        if (shownPage == ShownPage.tree)
          Expanded(
            child: WidgetBuildTreeDisplayer(
              widget.treeNodeData!,
              showPropertySelection: false,
              defaultProperty: widget.propertyName,
              actions: [modeChoosingButton],
            ),
          ),
      ],
    );
  }
}

class _EvaluationOfTheming extends StatelessWidget {
  const _EvaluationOfTheming({required this.propertyName, required this.child, required this.children, required this.modeChoosingButton});

  final String propertyName;
  final Widget? child;
  final List<Widget>? children;
  final Widget modeChoosingButton;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('$propertyName Evaluation'),
          automaticallyImplyLeading: false,
          actions: [modeChoosingButton],
          actionsPadding: EdgeInsets.only(right: 8),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: 8,
              children: [...?children, if (child != null) child!],
            ),
          ),
        ),
      );
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
