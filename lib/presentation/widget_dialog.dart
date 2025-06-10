import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_catalog/presentation/base_presentation.dart';
import 'package:flutter_catalog/utils/better_widget_span.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:html/parser.dart' show parse;
import 'package:http/http.dart' as http;
import 'package:flutter_html/flutter_html.dart';

import '../widget_tree_resolver/data.dart';

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
                                ? Builder(builder: (context) {
                                    var selected = widget.selected == widget.mainVariantName ? widget.variantsData.first : widget.variantsData.firstWhere((v) => v.name == widget.selected);
                                    bool hasWidgetTreeData = selected.widgetTreeExplanation != null;
                                    if (hasWidgetTreeData) {
                                      return WidgetBuildTreeDisplayer(selected.widgetTreeExplanation!);
                                    } else {
                                      return Placeholder();
                                    }
                                  })
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
                    if (!href.startsWith('https://api.flutter.dev/flutter/')) href = 'https://api.flutter.dev/flutter/$href';
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

//////------------------ Widget tree stuff

typedef ObservedRoute = (int orderLeft, WidgetPropertyData prop, WidgetPropertyDataLink link);

class WidgetBuildTreeDisplayer extends StatefulWidget {
  const WidgetBuildTreeDisplayer(this.data, {super.key, this.defaultProperty, this.showPropertySelection = true});

  final WidgetTreeNodeData data;
  final String? defaultProperty;
  final bool showPropertySelection;

  @override
  State<WidgetBuildTreeDisplayer> createState() => _WidgetBuildTreeDisplayerState();
}

class _WidgetBuildTreeDisplayerState extends State<WidgetBuildTreeDisplayer> {
  WidgetPropertyData? observedProperties;

  @override
  void initState() {
    if (widget.defaultProperty != null) {
      observedProperties = widget.data.parameters?.firstWhere(
        (p) => p.propertyName == widget.defaultProperty,
      );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Padding(
      padding: const EdgeInsets.all(8.0),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Building Tree View'),
          actions: [
            if (widget.showPropertySelection)
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
            observedProperties: (observedProperties == null) ? const <ObservedRoute>[] : [for (final link in observedProperties!.dataLinks ?? const []) (link.order, observedProperties!, link)],
          ),
        ),
      ));

  Widget recursiveLayerBuilder({TreeNodeData? givendata, int depth = 1, List<ObservedRoute>? observedProperties}) {
    var widgetData = givendata ?? widget.data;

    if (widgetData is ConditionalTreeNodeData) {
      return AnimatedBuilder(
        animation: widgetData.conditionFulfilment,
        builder: (context, child) {
          var buildResolution = widgetData.build();
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                color: Theme.of(context).colorScheme.secondaryContainer,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IntrinsicHeight(
                    child: RichText(
                      text: TextSpan(style: Theme.of(context).textTheme.bodyMedium, children: [
                        CWidgetSpan(child: Tooltip(message: 'Condition', child: Icon(Symbols.help))),
                        CWidgetSpan(child: SizedBox(width: 16)),
                        CWidgetSpan(
                          child: Checkbox(
                            value: widgetData.conditionFulfilment.value,
                            onChanged: (v) => widgetData.conditionFulfilment.value = v!,
                          ),
                        ),
                        ...widgetData.condition,
                      ]),
                    ),
                  ),
                ),
              ),
              if (buildResolution != null)
                recursiveLayerBuilder(
                  givendata: buildResolution,
                  depth: depth + 1,
                  observedProperties: observedProperties,
                ),
            ],
          );
        },
      );
    } else if (widgetData is WidgetTreeNodeData) {
      var buildResolution = widgetData.build();

      List<(WidgetPropertyData, WidgetPropertyDataLink)> hitsHere = [];
      List<ObservedRoute> toPassDown = [];

      for (final route in observedProperties ?? const []) {
        final orderLeft = route.$1;
        final prop = route.$2;
        final link = route.$3;

        if (link.nameOfDestinationChildWidget == widgetData.widgetName && (link.destinationKey == null || link.destinationKey == widgetData.key)) {
          if (orderLeft == 1) {
            hitsHere.add((prop, link)); // <-- show on THIS widget
          } else {
            toPassDown.add((orderLeft - 1, prop, link)); // <-- strip one level, continue
          }
        } else {
          toPassDown.add(route); // unrelated → keep as‑is
        }
      }

      Tooltip leadingIcon;
      if (widgetData.isRenderObject) {
        leadingIcon = Tooltip(message: 'RenderObject', child: Icon(Symbols.draw_abstract));
      } else {
        leadingIcon = Tooltip(message: 'Widget', child: Icon(Symbols.widgets));
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: IntrinsicHeight(
                child: Row(
                  children: [
                    leadingIcon,
                    SizedBox(width: 16),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Chip(label: Text(widgetData.widgetName)),
                      ),
                    ),
                    // Show a divider when there is *something* to render on this row
                    if ((depth == 1 && (observedProperties?.isNotEmpty ?? false)) || hitsHere.isNotEmpty) const VerticalDivider(),

                    // ── Top‑level widget establishes the property definition ────────────────────
                    if (depth == 1 && (observedProperties?.isNotEmpty ?? false))
                      Expanded(
                        flex: 2,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Column(
                            spacing: 8,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // “Defines <property>”
                              CRichText(
                                context,
                                children: [
                                  const TextSpan(text: 'Defines '),
                                  CWidgetSpan(child: Chip(label: Text(observedProperties!.first.$2.propertyName))),
                                ],
                              ),

                              // Any “beforePassingToChildren” modifiers coming from *any* link
                              for (final route in observedProperties)
                                if (route.$3.beforePassingToChildren?.isNotEmpty ?? false) ...route.$3.beforePassingToChildren!.map((m) => m.render(context)),
                            ],
                          ),
                        ),
                      ),
                    if (hitsHere.isNotEmpty)
                      Expanded(
                        flex: 2,
                        child: Column(
                          spacing: 8,
                          children: [
                            for (final hit in hitsHere)
                              Expanded(
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: _renderLink(context, hit.$1, hit.$2),
                                ),
                              ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
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
    } else if (widgetData is ConditionalWrappingTreeNodeData) {
      return AnimatedBuilder(
        animation: widgetData.conditionFulfilment,
        builder: (context, child) {
          var buildResolution = widgetData.build();
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                color: Theme.of(context).colorScheme.secondaryContainer,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IntrinsicHeight(
                    child: RichText(
                      text: TextSpan(style: Theme.of(context).textTheme.bodyMedium, children: [
                        CWidgetSpan(child: Tooltip(message: 'Condition', child: Icon(Symbols.help))),
                        CWidgetSpan(child: SizedBox(width: 16)),
                        CWidgetSpan(
                          child: Checkbox(
                            value: widgetData.conditionFulfilment.value,
                            onChanged: (v) => widgetData.conditionFulfilment.value = v!,
                          ),
                        ),
                        ...widgetData.condition,
                      ]),
                    ),
                  ),
                ),
              ),
              if (buildResolution != null)
                recursiveLayerBuilder(
                  givendata: buildResolution,
                  depth: depth + 1,
                  observedProperties: observedProperties,
                ),
            ],
          );
        },
      );
    }
    return Placeholder();
  }

  Widget _renderLink(BuildContext context, WidgetPropertyData prop, WidgetPropertyDataLink link) {
    if (link is WidgetPropertyDataDirectLink) {
      return CRichText(
        context,
        children: [
          const TextSpan(text: 'Use as '),
          for (final dest in link.nameOfDestinationChildProperties) ...[
            CWidgetSpan(child: Chip(label: Text(dest))),
            const TextSpan(text: ', '),
          ],
        ]..removeLast(),
      );
    }
    if (link is WidgetPropertyDataLinkWithRenaming) {
      return CRichText(
        context,
        children: [
          const TextSpan(text: 'Use '),
          CWidgetSpan(child: Chip(label: Text(link.newName))),
          const TextSpan(text: ' as '),
          for (final dest in link.nameOfDestinationChildProperties) ...[
            CWidgetSpan(child: Chip(label: Text(dest))),
            const TextSpan(text: ', '),
          ]
        ]..removeLast(),
      );
    }
    return const Placeholder();
  }
}
