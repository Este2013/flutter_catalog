import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_catalog/presentation/base_presentation.dart';
import 'package:flutter_catalog/utils/better_widget_span.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:url_launcher/url_launcher.dart';

import 'docs_display.dart';
import '../widget_tree_resolver/data.dart';

class WidgetPresentationPage extends StatefulWidget {
  const WidgetPresentationPage(
    this.mainVariantName, {
    super.key,
    required this.variantsData,
    this.link,
    this.defaultIconBuilder,
    this.defaultOptionsBuilder,
  });

  final String mainVariantName;

  final Widget Function(BuildContext)? defaultIconBuilder;
  final List<WidgetVariantData> variantsData;
  final String? link;
  final Widget Function(Map<String, dynamic>? currentOptions, void Function(Map<String, dynamic>? newOptions) submitNewOptions)? defaultOptionsBuilder;

  @override
  State<WidgetPresentationPage> createState() => _WidgetPresentationPageState();
}

class _WidgetPresentationPageState extends State<WidgetPresentationPage> {
  late String selected;

  @override
  void initState() {
    selected = widget.mainVariantName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var variantExplanation = selectedVariant.variantExplanation;
    return Scaffold(
      appBar: AppBar(
        title: Text(selected),
        actionsPadding: EdgeInsets.only(right: 8),
        actions: [
          if (variantExplanation != null) Text(variantExplanation, textAlign: TextAlign.end),
          SizedBox(width: 8),
          if (widget.link != null)
            IconButton.filledTonal(
              tooltip: 'Open the documentation',
              onPressed: () => launchUrl(Uri.parse(widget.link!)),
              icon: Icon(Symbols.book_2, fill: 1),
            ),
        ],
      ),
      body: SizedBox(
        width: double.maxFinite,
        child: Row(
          children: [
            if (widget.variantsData.length > 1)
              Container(
                padding: EdgeInsets.only(left: 8),
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
              child: WidgetShowRoom(
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
  }

  WidgetVariantData get selectedVariant => widget.variantsData.firstWhere(
        (v) => v.name == selected,
        orElse: () => widget.variantsData.firstWhere((v) => v.name == null),
      );
}

class WidgetShowRoom extends StatefulWidget {
  const WidgetShowRoom(
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
  State<WidgetShowRoom> createState() => _WidgetShowRoomState();
}

class _WidgetShowRoomState extends State<WidgetShowRoom> {
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
    int availableOptionsNumber = [
      data.themeExplanation,
      data.docsLink ?? widget.docsLink,
      data.widgetTreeExplanation,
    ].where((e) => e != null).length;

    return DefaultTabController(
      length: 1 + availableOptionsNumber,
      child: Scaffold(
        appBar: TabBar(tabs: [
          Tab(icon: Icon(Symbols.code_blocks, fill: 1), text: 'Demo'),
          if (data.themeExplanation != null) Tab(icon: Icon(Symbols.color_lens), text: 'Theme'),
          if (data.docsLink != null || widget.docsLink != null) Tab(icon: Icon(Symbols.book_2, fill: 1), text: 'Documentation'),
          if (data.widgetTreeExplanation != null) Tab(icon: Transform.rotate(angle: pi, child: Icon(Symbols.view_object_track, fill: 1)), text: 'Widget building tree'),
        ]),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TabBarView(
            children: [
              Row(
                spacing: 8,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: _DecorationContainer(child: data.widgetBuilder?.call(context, currentOptions)),
                  ),

                  // TODO Make a better options panel
                  if (showOptions && showedMode == null) ...[
                    VerticalDivider(),
                    Container(
                      constraints: BoxConstraints(minWidth: 300, maxWidth: 400),
                      padding: EdgeInsets.all(8),
                      child: widget.optionsBuilder?.call(currentOptions, (options) => setState(() => currentOptions = options)) ?? Placeholder(),
                    )
                  ],
                ],
              ),
              if (data.themeExplanation != null) _DecorationContainer(child: data.themeExplanation),
              if (data.docsLink != null || widget.docsLink != null) _DecorationContainer(child: DocsDisplayer(data.docsLink ?? widget.docsLink!)),
              if (data.widgetTreeExplanation != null)
                _DecorationContainer(
                  child: Builder(builder: (context) {
                    var selected = widget.selected == widget.mainVariantName ? widget.variantsData.first : widget.variantsData.firstWhere((v) => v.name == widget.selected);
                    bool hasWidgetTreeData = selected.widgetTreeExplanation != null;
                    if (hasWidgetTreeData) {
                      return WidgetBuildTreeDisplayer(selected.widgetTreeExplanation!);
                    }
                    return Placeholder();
                  }),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DecorationContainer extends StatelessWidget {
  const _DecorationContainer({this.child});

  final Widget? child;

  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          border: Border.all(color: Theme.of(context).dividerColor, width: 5),
          borderRadius: BorderRadius.circular(15),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Center(child: child ?? Placeholder()),
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
