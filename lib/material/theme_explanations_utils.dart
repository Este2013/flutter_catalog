import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_catalog/material/material_actions/material_actions_ui/icon_button_theme_data.dart';
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

  final String title;
  final String? link;

  @override
  Widget build(BuildContext context) => ActionChip(
        label: Text(title),
        onPressed: link != null ? () => launchUrl(Uri.parse(link!)) : null,
      );
}

class PropertyExplanationView extends StatefulWidget {
  const PropertyExplanationView(this.propertyName, {super.key, this.child, this.children, this.shortExplanation, this.docsLink, this.onlyUsedWithMaterial3Warning = false})
      : assert((child != null) ^ (children != null));

  final String propertyName;
  final String? shortExplanation, docsLink;
  final List<Widget>? children;
  final Widget? child;
  final bool onlyUsedWithMaterial3Warning;

  @override
  State<PropertyExplanationView> createState() => PropertyExplanationStateView();
}

class PropertyExplanationStateView extends State<PropertyExplanationView> {
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
            if (widget.onlyUsedWithMaterial3Warning) OnlyUsedWithMaterial3Warning(),
          ],
        )),
        SegmentedButton(
          segments: [
            ButtonSegment(value: false, icon: Icon(Symbols.conversion_path), tooltip: 'Property evaluation'),
            ButtonSegment(value: true, icon: Icon(Symbols.book_2), tooltip: 'Property documentation'),
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
  });

  @override
  Widget build(BuildContext context) => RichText(
        text: TextSpan(
          style: Theme.of(context).textTheme.bodyMedium,
          children: [
            WidgetSpan(
              alignment: PlaceholderAlignment.middle,
              child: Icon(Icons.warning_rounded, color: Theme.of(context).colorScheme.error),
            ),
            TextSpan(text: ' Is only in use if '),
            WidgetSpan(
              alignment: PlaceholderAlignment.middle,
              child: LinkChip('theme.useMaterial3 (${Theme.of(context).useMaterial3})', link: 'https://api.flutter.dev/flutter/material/ThemeData/useMaterial3.html'),
            ),
            TextSpan(text: ' is false.'),
          ],
        ),
      );
}
