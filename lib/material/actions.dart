import 'package:flutter/material.dart';
import 'package:flutter_catalog/main.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

class ActionsPresentationPage extends StatelessWidget {
  const ActionsPresentationPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(bottom: 16),
          child: Center(
            child: Wrap(
              runSpacing: 32,
              spacing: 32,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                WidgetPresentation(
                  title: 'IconButton',
                  presentationWindowAlignment: Alignment.topRight,
                  variantsData: [
                    WidgetVariantData(
                      null,
                      iconBuilder: (p0) => IconButton(onPressed: () {}, icon: Icon(Icons.person)),
                      widgetBuilder: (p0, _) => IconButton(onPressed: () {}, icon: Icon(Icons.person)),
                    ),
                    WidgetVariantData(
                      'Filled',
                      iconBuilder: (p0) => IconButton.filled(onPressed: () {}, icon: Icon(Icons.person)),
                      widgetBuilder: (p0, _) => IconButton.filled(onPressed: () {}, icon: Icon(Icons.person)),
                    ),
                    WidgetVariantData(
                      'Filled tonal',
                      iconBuilder: (p0) => IconButton.filledTonal(onPressed: () {}, icon: Icon(Icons.person)),
                      widgetBuilder: (p0, _) => IconButton.filledTonal(onPressed: () {}, icon: Icon(Icons.person)),
                    ),
                    WidgetVariantData(
                      'Outlined',
                      iconBuilder: (p0) => IconButton.outlined(onPressed: () {}, icon: Icon(Icons.person)),
                      widgetBuilder: (p0, _) => IconButton.outlined(onPressed: () {}, icon: Icon(Icons.person)),
                    ),
                  ],
                ),
                WidgetPresentation(
                  title: 'TextButton',
                  presentationWindowAlignment: Alignment.center,
                  variantsData: [
                    WidgetVariantData(
                      null,
                      iconBuilder: (p0) => Icon(Icons.text_fields_outlined),
                      widgetBuilder: (p0, opt) => TextButton(onPressed: () {}, child: Text(opt?['Name'] ?? 'Click me')),
                    ),
                    WidgetVariantData(
                      'Icon',
                      iconBuilder: (p0) => Icon(Symbols.arrow_selector_tool, fill: 1),
                      widgetBuilder: (p0, opt) => TextButton.icon(onPressed: () {}, icon: Icon(Symbols.arrow_selector_tool, fill: 1), label: Text(opt?['Name'] ?? 'Click me')),
                    ),
                  ],
                ),
                WidgetPresentation(
                  title: 'ElevatedButton',
                  presentationWindowAlignment: Alignment.bottomLeft,
                  variantsData: [
                    WidgetVariantData(
                      null,
                      iconBuilder: (p0) => Icon(Icons.text_fields_outlined),
                      widgetBuilder: (p0, opt) => ElevatedButton(onPressed: () {}, child: Text(opt?['Name'] ?? 'Click me')),
                    ),
                    WidgetVariantData(
                      'Icon',
                      iconBuilder: (p0) => Icon(Symbols.arrow_selector_tool, fill: 1),
                      widgetBuilder: (p0, opt) => ElevatedButton.icon(onPressed: () {}, icon: Icon(Symbols.arrow_selector_tool, fill: 1), label: Text(opt?['Name'] ?? 'Click me')),
                    ),
                  ],
                ),
                WidgetPresentation(
                  title: 'FilledButton',
                  link:
                      'https://api.flutter.dev/flutter/material/ButtonStyle-class.html?_gl=1*unaw4e*_ga*MjcwMTE3ODUwLjE3MjY1ODY0NjI.*_ga_04YGWK0175*MTczODc0ODAwMS40NS4xLjE3Mzg3NDg5NDcuMC4wLjA.#material-3-button-types',
                  presentationWindowAlignment: Alignment.bottomRight,
                  variantsData: [
                    WidgetVariantData(
                      null,
                      iconBuilder: (p0) => Icon(Symbols.circle, fill: 1),
                      widgetBuilder: (p0, opt) => FilledButton(onPressed: () {}, child: Text(opt?['Name'] ?? '( ·ω· )')),
                    ),
                    WidgetVariantData(
                      'Tonal',
                      iconBuilder: (p0) => Icon(Symbols.ev_shadow),
                      widgetBuilder: (p0, opt) => FilledButton.tonal(onPressed: () {}, child: Text(opt?['Name'] ?? '( ·ω· )')),
                    ),
                    WidgetVariantData(
                      'Icon',
                      iconBuilder: (p0) => Icon(Icons.add_circle),
                      widgetBuilder: (p0, opt) => FilledButton.icon(onPressed: () {}, icon: Icon(Icons.emoji_emotions), label: Text(opt?['Name'] ?? '( ·ω· )')),
                    ),
                    WidgetVariantData(
                      'Tonal Icon',
                      iconBuilder: (p0) => Icon(Symbols.ev_shadow_add),
                      widgetBuilder: (p0, opt) => FilledButton.tonalIcon(onPressed: () {}, icon: Icon(Icons.emoji_emotions), label: Text(opt?['Name'] ?? '( ·ω· )')),
                    ),
                  ],
                ),
                WidgetPresentation(
                  title: 'OutlinedButton',
                  link:
                      'https://api.flutter.dev/flutter/material/ButtonStyle-class.html?_gl=1*unaw4e*_ga*MjcwMTE3ODUwLjE3MjY1ODY0NjI.*_ga_04YGWK0175*MTczODc0ODAwMS40NS4xLjE3Mzg3NDg5NDcuMC4wLjA.#material-3-button-types',
                  presentationWindowAlignment: Alignment.bottomRight,
                  variantsData: [
                    WidgetVariantData(
                      null,
                      iconBuilder: (p0) => Icon(Symbols.circle, fill: 1),
                      widgetBuilder: (p0, opt) => OutlinedButton(onPressed: () {}, child: Text(opt?['Name'] ?? '( ·ω· )')),
                    ),
                    WidgetVariantData(
                      'Icon',
                      iconBuilder: (p0) => Icon(Icons.add_circle),
                      widgetBuilder: (p0, opt) => OutlinedButton.icon(onPressed: () {}, icon: Icon(Icons.emoji_emotions), label: Text(opt?['Name'] ?? '( ·ω· )')),
                    ),
                  ],
                ),
                WidgetPresentation(
                  title: 'FloatingActionButton',
                  presentationWindowAlignment: null,
                  link:
                      'https://api.flutter.dev/flutter/material/FloatingActionButton-class.html?_gl=1*8n6dpk*_ga*MjcwMTE3ODUwLjE3MjY1ODY0NjI.*_ga_04YGWK0175*MTczODc0ODAwMS40NS4xLjE3Mzg3NDgwMDQuMC4wLjA.',
                  variantsData: [
                    WidgetVariantData(
                      null,
                      iconBuilder: (p0) => Icon(Icons.check_box_outline_blank),
                      widgetBuilder: (p0, opt) => FloatingActionButton(
                        onPressed: () {},
                        child: Icon(Icons.edit),
                      ),
                    ),
                    WidgetVariantData(
                      'Extended',
                      iconBuilder: (p0) => Icon(Symbols.right_panel_close),
                      widgetBuilder: (p0, opt) => FloatingActionButton.extended(
                        onPressed: () {},
                        icon: Icon(Icons.add),
                        label: Text('Create'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
}
