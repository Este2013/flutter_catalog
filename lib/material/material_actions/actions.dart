import 'package:flutter/material.dart';
import 'package:flutter_catalog/main.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

import 'material_actions_ui/icon_button_theme_data.dart';

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
                  defaultOptionsBuilder: (currentOptions, submitNewOptions) => Column(
                    spacing: 8,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(spacing: 8, children: [
                        Text('isSelected:'),
                        SegmentedButton(
                          segments: [
                            ButtonSegment(value: null, icon: Icon(Icons.block), tooltip: 'null'),
                            ButtonSegment(value: true, icon: Icon(Icons.check), tooltip: 'true'),
                            ButtonSegment(value: false, icon: Icon(Icons.close), tooltip: 'false'),
                          ],
                          selected: {currentOptions?['isSelected']},
                          showSelectedIcon: false,
                          onSelectionChanged: (p0) => submitNewOptions((currentOptions ?? {})..['isSelected'] = p0.first),
                        ),
                        Chip(avatar: Icon(Symbols.frame_person, fill: 1), label: Text('selectedIcon'))
                      ]),
                      FilterChip(
                        avatar: Icon(Icons.chat),
                        label: Text('Tooltip'),
                        onSelected: (v) => submitNewOptions((currentOptions ?? {})..['tooltip'] = v ? 'Contact Edouart Charles the first' : null),
                        selected: currentOptions?['tooltip'] != null,
                        showCheckmark: false,
                      )
                    ],
                  ),
                  variantsData: [
                    WidgetVariantData(
                      null,
                      iconBuilder: (p0) => IconButton(onPressed: () {}, icon: Icon(Icons.person)),
                      widgetBuilder: (p0, opt) => IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.person),
                        isSelected: opt?['isSelected'],
                        selectedIcon: Icon(Symbols.frame_person, fill: 1),
                        tooltip: opt?['tooltip'],
                      ),
                      themeExplanation: IconButtonThemeExplanation(),
                    ),
                    WidgetVariantData(
                      'Filled',
                      iconBuilder: (p0) => IconButton.filled(onPressed: () {}, icon: Icon(Icons.person)),
                      widgetBuilder: (p0, opt) => IconButton.filled(
                        onPressed: () {},
                        icon: Icon(Icons.person),
                        isSelected: opt?['isSelected'],
                        selectedIcon: Icon(Symbols.frame_person, fill: 1),
                        tooltip: opt?['tooltip'],
                      ),
                      docsLink: "https://api.flutter.dev/flutter/material/IconButton/IconButton.filled.html",
                    ),
                    WidgetVariantData(
                      'Filled tonal',
                      iconBuilder: (p0) => IconButton.filledTonal(onPressed: () {}, icon: Icon(Icons.person)),
                      widgetBuilder: (p0, opt) => IconButton.filledTonal(
                        onPressed: () {},
                        icon: Icon(Icons.person),
                        isSelected: opt?['isSelected'],
                        selectedIcon: Icon(Symbols.frame_person, fill: 1),
                        tooltip: opt?['tooltip'],
                      ),
                      docsLink: "https://api.flutter.dev/flutter/material/IconButton/IconButton.filledTonal.html",
                    ),
                    WidgetVariantData(
                      'Outlined',
                      iconBuilder: (p0) => IconButton.outlined(onPressed: () {}, icon: Icon(Icons.person)),
                      widgetBuilder: (p0, opt) => IconButton.outlined(
                        onPressed: () {},
                        icon: Icon(Icons.person),
                        isSelected: opt?['isSelected'],
                        selectedIcon: Icon(Symbols.frame_person, fill: 1),
                        tooltip: opt?['tooltip'],
                      ),
                      docsLink: "https://api.flutter.dev/flutter/material/IconButton/IconButton.outlined.html",
                    ),
                  ],
                  link: 'https://api.flutter.dev/flutter/material/IconButton-class.html',
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
