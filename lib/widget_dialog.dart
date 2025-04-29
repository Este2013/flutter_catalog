import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_catalog/widget_tree_resolver/icon_data.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:html/parser.dart' show parse;
import 'package:http/http.dart' as http;
import 'main.dart';
import 'package:flutter_html/flutter_html.dart';

import 'widget_tree_resolver/data.dart';

class WidgetPresentationDialog extends StatefulWidget {
  const WidgetPresentationDialog(this.mainVariantName, {super.key, required this.variantsData, this.link, this.defaultIconBuilder, this.defaultOptionsBuilder});

  final String mainVariantName;

  final Widget Function(BuildContext)? defaultIconBuilder;
  final List<WidgetVariantData> variantsData;
  final String? link;
  final Widget Function(Map<String, dynamic>? currentOptions, void Function(Map<String, dynamic>? newOptions) submitNewOptions)? defaultOptionsBuilder;

  @override
  State<WidgetPresentationDialog> createState() => _WidgetPresentationDialogState();
}

class _WidgetPresentationDialogState extends State<WidgetPresentationDialog> {
  late String selected;

  @override
  void initState() {
    selected = widget.mainVariantName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) => AlertDialog(
        title: Row(
          spacing: 8,
          children: [
            Text(widget.mainVariantName),
            Spacer(),
            if (widget.link != null)
              IconButton.filled(
                tooltip: 'Open the documentation',
                onPressed: () => launchUrl(Uri.parse(widget.link!)),
                icon: Icon(Symbols.book_2, fill: 1),
              ),
          ],
        ),
        actions: [FilledButton(onPressed: Navigator.of(context).pop, child: Text('Close'))],
        content: SizedBox(
          width: double.maxFinite,
          child: Row(
            children: [
              if (widget.variantsData.length > 1)
                SizedBox(
                  width: 200,
                  child: Builder(
                    builder: (context) => ListView(
                      children: [
                        Card(
                          clipBehavior: Clip.hardEdge,
                          color: (selected == widget.mainVariantName) ? Theme.of(context).colorScheme.secondaryContainer : null,
                          child: InkWell(
                            onTap: () => setState(() => selected = widget.mainVariantName),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Expanded(child: Center(child: widget.variantsData.first.iconBuilder?.call(context) ?? widget.defaultIconBuilder?.call(context) ?? Placeholder())),
                                  Expanded(flex: 2, child: Text(widget.mainVariantName)),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Divider(),
                        for (var variant in widget.variantsData.sublist(1))
                          Card(
                            clipBehavior: Clip.hardEdge,
                            color: (selected == variant.name) ? Theme.of(context).colorScheme.secondaryContainer : null,
                            child: InkWell(
                              onTap: () => setState(() => selected = variant.name!),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Expanded(child: Center(child: variant.iconBuilder?.call(context) ?? widget.defaultIconBuilder?.call(context) ?? Placeholder())),
                                    Expanded(flex: 2, child: Text(variant.name!)),
                                  ],
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              if (widget.variantsData.length > 1) VerticalDivider(),
              Expanded(
                child: DialogPresentationSection(
                  widget.mainVariantName,
                  variantsData: widget.variantsData,
                  selected: selected,
                  optionsBuilder: selectedVariant.optionsBuilder ?? widget.defaultOptionsBuilder,
                  docsLink: widget.link,
                ),
              )
            ],
          ),
        ),
      );

  WidgetVariantData get selectedVariant => widget.variantsData.firstWhere(
        (v) => v.name == selected,
        orElse: () => widget.variantsData.firstWhere((v) => v.name == null),
      );
}

class DialogPresentationSection extends StatefulWidget {
  const DialogPresentationSection(
    this.mainVariantName, {
    super.key,
    required this.variantsData,
    required this.selected,
    required this.optionsBuilder,
    this.docsLink,
  });

  final String mainVariantName;
  final List<WidgetVariantData> variantsData;
  final String selected;
  final Widget Function(Map<String, dynamic>? currentOptions, void Function(Map<String, dynamic>? newOptions) submitNewOptions)? optionsBuilder;
  final String? docsLink;

  @override
  State<DialogPresentationSection> createState() => _DialogPresentationSectionState();
}

class _DialogPresentationSectionState extends State<DialogPresentationSection> {
  late bool showOptions;
  Map<String, dynamic>? currentOptions;
  String? showedMode;

  @override
  void initState() {
    if (widget.optionsBuilder != null) {
      showOptions = true;
    } else {
      showOptions = false;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var data = widget.variantsData.firstWhere((v) => (v.name ?? widget.mainVariantName) == widget.selected);
    return Column(
      spacing: 8,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (data.variantExplanation != null || data.themeExplanation != null || data.docsLink != null || widget.docsLink != null)
          Row(
            children: [
              if (data.variantExplanation != null) Expanded(child: Text(data.variantExplanation!, style: Theme.of(context).textTheme.bodyLarge)) else Spacer(),
              if (data.themeExplanation != null || data.docsLink != null || widget.docsLink != null)
                SegmentedButton<String?>(
                  showSelectedIcon: false,
                  segments: [
                    ButtonSegment(value: null, icon: Icon(Symbols.code_blocks, fill: 1), tooltip: 'Demo'),
                    if (data.themeExplanation != null) ButtonSegment(value: 'theme', icon: Icon(Icons.color_lens), tooltip: 'Theme'),
                    if (data.docsLink != null || widget.docsLink != null) ButtonSegment(value: 'docs', icon: Icon(Symbols.book_2, fill: 1), tooltip: 'Documentation'),
                    if (data.widgetTreeExplanation != null)
                      ButtonSegment(value: 'tree', icon: Transform.rotate(angle: pi, child: Icon(Symbols.view_object_track, fill: 1)), tooltip: 'Widget building tree')
                  ],
                  selected: {showedMode},
                  onSelectionChanged: (v) => setState(() => showedMode = v.first),
                ),
            ],
          ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              border: Border.all(color: Theme.of(context).dividerColor, width: 5),
              borderRadius: BorderRadius.circular(15),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Center(
                child: showedMode == null
                    ? data.widgetBuilder?.call(context, currentOptions) ?? Placeholder()
                    : showedMode == 'theme'
                        ? data.themeExplanation
                        : showedMode == 'docs'
                            ? DocsDisplayer(data.docsLink ?? widget.docsLink!)
                            : showedMode == 'tree'
                                ? WidgetBuildTreeDisplayer(IconNodeData())
                                : Placeholder(),
              ),
            ),
          ),
        ),
        if (showOptions && showedMode == null) ...[
          Divider(),
          Padding(
            padding: EdgeInsets.all(8),
            child: widget.optionsBuilder?.call(currentOptions, (options) => setState(() => currentOptions = options)) ?? Placeholder(),
          )
        ],
      ],
    );
  }
}

class DocsDisplayer extends StatelessWidget {
  const DocsDisplayer(this.url, {super.key, this.pageName});

  final String url;
  final String? pageName;

  Future<String> _fetchApiPage(String url) async {
    final resp = await http.get(Uri.parse(url));
    if (resp.statusCode != 200) {
      throw Exception('Failed to load documentation ($url)');
    }
    return resp.body;
  }

  dynamic _extractDocComment(String htmlSource) {
    final document = parse(htmlSource);

    // Look specifically for the 'desc markdown' section
    final descSection = document.querySelector('.desc.markdown');

    // Return its text (or an empty string if not found)
    return descSection?.innerHtml.trim(); //?.text.trim() ?? '';
  }

  Future<dynamic> _fetchAndParseDoc(String apiDocUrl) async {
    final html = await _fetchApiPage(apiDocUrl);
    return _extractDocComment(html);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('${pageName != null ? "$pageName " : ""}Documentation'),
          automaticallyImplyLeading: false,
        ),
        body: FutureBuilder(
          future: _fetchAndParseDoc(url),
          builder: (context, snapshot) {
            if (snapshot.hasError) return ErrorWidget(snapshot.error!);
            if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: SingleChildScrollView(
                child: Html(
                  data: snapshot.data!.toString(),
                  // you can customize link tap behavior, styling, etc.
                  onLinkTap: (href, _, __) {
                    if (href == null) return;
                    if (!href.startsWith('https://api.flutter.dev/flutter/')) href = 'https://api.flutter.dev/flutter/' + href;
                    launchUrl(Uri.parse(href));
                  },
                  style: {
                    // override any tags if you like
                    "code": Style(
                      backgroundColor: Colors.grey.shade200,
                      padding: HtmlPaddings.all(4),
                    ),
                  },
                ),
              ),
            );
          },
        ),
      );
}

class WidgetBuildTreeDisplayer extends StatefulWidget {
  const WidgetBuildTreeDisplayer(this.data, {super.key});

  final WidgetTreeNodeData data;

  @override
  State<WidgetBuildTreeDisplayer> createState() => _WidgetBuildTreeDisplayerState();
}

class _WidgetBuildTreeDisplayerState extends State<WidgetBuildTreeDisplayer> {
  WidgetPropertyData? observedProperties;

  @override
  Widget build(BuildContext context) => Padding(
      padding: const EdgeInsets.all(8.0),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Building Tree View'),
          actions: [
            DropdownMenu(
              dropdownMenuEntries: [
                for (var e in widget.data.parameters ?? <WidgetPropertyData>[])
                  DropdownMenuEntry(
                    value: e,
                    label: e.propertyName,
                  )
              ],
              initialSelection: observedProperties?.propertyName,
              onSelected: (value) => setState(() => observedProperties = value as WidgetPropertyData),
            )
          ],
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
            child: recursiveLayerBuilder(
          observedProperties: observedProperties != null
              ? [
                  (
                    observedProperties!.dataLink?.order,
                    observedProperties,
                  )
                ].where((p) => p.$1 != null).toList().cast()
              : [],
        )),
      ));

  Widget recursiveLayerBuilder({WidgetTreeNodeData? givendata, int depth = 1, List<(int orderLeft, WidgetPropertyData)>? observedProperties}) {
    var widgetData = givendata ?? widget.data;
    var buildResolution = widgetData.build();

    List<WidgetPropertyData> observedLevelProperties = [];
    List<(int orderLeft, WidgetPropertyData)> toPassDown = [];

    for (var p in observedProperties ?? []) {
      if (p.$2.dataLink!.nameOfDestinationChildWidget == widgetData.widgetName) {
        if (p.$1 == 1) {
          observedLevelProperties.add(p.$2);
        } else {
          toPassDown.add((p.$1 - 1, p.$2));
        }
      } else {
        toPassDown.add(p);
      }
    }

    return Column(
      spacing: 8,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IntrinsicHeight(
          child: Row(
            children: [
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: depth * 8.0),
                    child: Chip(label: Text(widgetData.widgetName)),
                  ),
                ),
              ),
              if ((depth == 1 && (observedProperties?.isNotEmpty ?? false)) || observedLevelProperties.isNotEmpty) VerticalDivider(indent: 0, endIndent: 0),
              // Top level widget establishes definition
              if (depth == 1 && (observedProperties?.isNotEmpty ?? false))
                Expanded(
                  flex: 2,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: RichText(
                      text: TextSpan(
                        children: [TextSpan(text: 'Defines '), WidgetSpan(alignment: PlaceholderAlignment.middle, child: Chip(label: Text(observedProperties!.first.$2.propertyName)))],
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ),
                ),
              if (observedLevelProperties.isNotEmpty)
                Expanded(
                    flex: 2,
                    child: Row(
                      children: [
                        for (var p in observedLevelProperties)
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Builder(
                              builder: (context) {
                                if (p.dataLink is WidgetPropertyDataDirectLink) {
                                  return RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(text: 'Use as '),
                                        WidgetSpan(alignment: PlaceholderAlignment.middle, child: Chip(label: Text(p.dataLink!.nameOfDestinationChildProperty))),
                                      ],
                                      style: Theme.of(context).textTheme.bodyMedium,
                                    ),
                                  );
                                }
                                return Placeholder();
                              },
                            ),
                          ),
                      ],
                    )),
            ],
          ),
        ),
        if (buildResolution != null)
          recursiveLayerBuilder(
            givendata: buildResolution,
            depth: depth + 1,
            observedProperties: toPassDown,
          ),
      ],
    );
  }
}
