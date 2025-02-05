import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:url_launcher/url_launcher.dart';

import 'main.dart';

class WidgetPresentationDialog extends StatefulWidget {
  const WidgetPresentationDialog(this.mainVariantName, {super.key, required this.variantsData, this.link, this.defaultIconBuilder});

  final String mainVariantName;

  final Widget Function(BuildContext)? defaultIconBuilder;
  final List<WidgetVariantData> variantsData;
  final String? link;

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
                child: DialogPresentationSection(widget.mainVariantName, variantsData: widget.variantsData, selected: selected),
              )
            ],
          ),
        ),
      );
}

class DialogPresentationSection extends StatelessWidget {
  const DialogPresentationSection(
    this.mainVariantName, {
    super.key,
    required this.variantsData,
    required this.selected,
  });

  final String mainVariantName;
  final List<WidgetVariantData> variantsData;
  final String selected;

  @override
  Widget build(BuildContext context) {
    var data = variantsData.firstWhere((v) => (v.name ?? mainVariantName) == selected);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                border: Border.all(color: Theme.of(context).dividerColor, width: 5),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(child: data.widgetBuilder?.call(context) ?? Placeholder())),
        ),
        Divider(),
        Expanded(flex: 2, child: Placeholder()),
      ],
    );
  }
}
