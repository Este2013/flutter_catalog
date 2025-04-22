import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class InsetDisplay extends StatefulWidget {
  const InsetDisplay({super.key, required this.icon, required this.content});

  final Widget icon, content;

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
          Padding(padding: const EdgeInsets.only(left: 16), child: widget.icon),
          Flexible(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 1000),
              child: Card(
                color: countAncestorsOfSameType(context, InsetDisplay) % 2 == 0 ? Theme.of(context).colorScheme.surfaceContainer : Theme.of(context).colorScheme.surfaceContainerHigh,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: widget.content,
                ),
              ),
            ),
          ),
        ],
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
