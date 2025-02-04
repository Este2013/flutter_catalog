import 'package:flutter/material.dart';
import 'package:flutter_catalog/main.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

class ActionsPresentationPage extends StatelessWidget {
  const ActionsPresentationPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
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
                    widgetBuilder: (p0, data) => IconButton(onPressed: () {}, icon: Icon(Icons.person)),
                  ),
                  WidgetVariantData(
                    'Filled',
                    iconBuilder: (p0) => IconButton.filled(onPressed: () {}, icon: Icon(Icons.person)),
                    widgetBuilder: (p0, data) => IconButton.filled(onPressed: () {}, icon: Icon(Icons.person)),
                  ),
                  WidgetVariantData(
                    'Filled tonal',
                    iconBuilder: (p0) => IconButton.filledTonal(onPressed: () {}, icon: Icon(Icons.person)),
                    widgetBuilder: (p0, data) => IconButton.filledTonal(onPressed: () {}, icon: Icon(Icons.person)),
                  ),
                  WidgetVariantData(
                    'Outlined',
                    iconBuilder: (p0) => IconButton.outlined(onPressed: () {}, icon: Icon(Icons.person)),
                    widgetBuilder: (p0, data) => IconButton.outlined(onPressed: () {}, icon: Icon(Icons.person)),
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
                    widgetBuilder: (p0, data) => TextButton(onPressed: () {}, child: Text('Hello!')),
                  ),
                  WidgetVariantData(
                    'Icon',
                    iconBuilder: (p0) => Icon(Symbols.arrow_selector_tool, fill: 1),
                    widgetBuilder: (p0, data) => TextButton.icon(onPressed: () {}, icon: Icon(Symbols.arrow_selector_tool, fill: 1), label: Text('Click me')),
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
                    widgetBuilder: (p0, data) => ElevatedButton(onPressed: () {}, child: Text('Click me')),
                  ),
                  WidgetVariantData(
                    'Icon',
                    iconBuilder: (p0) => Icon(Symbols.arrow_selector_tool, fill: 1),
                    widgetBuilder: (p0, data) => ElevatedButton.icon(onPressed: () {}, icon: Icon(Symbols.arrow_selector_tool, fill: 1), label: Text('Click me')),
                  ),
                ],
              ),
              WidgetPresentation(
                title: 'FilledButton',
                presentationWindowAlignment: Alignment.bottomRight,
                variantsData: [
                  WidgetVariantData(
                    null,
                    iconBuilder: (p0) => Icon(Icons.text_fields_outlined),
                    widgetBuilder: (p0, data) => FilledButton(onPressed: () {}, child: Text('( ·ω· )')),
                  ),
                  WidgetVariantData(
                    'Tonal',
                    iconBuilder: (p0) => Icon(Icons.text_fields_outlined),
                    widgetBuilder: (p0, data) => FilledButton.tonal(onPressed: () {}, child: Text('( ·ω· )')),
                  ),
                  WidgetVariantData(
                    'Icon',
                    iconBuilder: (p0) => Icon(Icons.text_fields_outlined),
                    widgetBuilder: (p0, data) => FilledButton.icon(onPressed: () {}, icon: Icon(Icons.emoji_emotions), label: Text('( ·ω· )')),
                  ),
                  WidgetVariantData(
                    'Tonal Icon',
                    iconBuilder: (p0) => Icon(Icons.text_fields_outlined),
                    widgetBuilder: (p0, data) => FilledButton.tonalIcon(onPressed: () {}, icon: Icon(Icons.emoji_emotions), label: Text('( ·ω· )')),
                  ),
                ],
              ),
              WidgetPresentation(
                title: 'FloatingActionButton',
                presentationWindowAlignment: null,
                variantsData: [
                  WidgetVariantData(
                    null,
                    iconBuilder: (p0) => IconButton(onPressed: () {}, icon: Icon(Icons.person)),
                    widgetBuilder: (p0, data) => FloatingActionButton(
                      onPressed: () {},
                      child: Icon(Icons.edit),
                    ),
                  ),
                  WidgetVariantData(
                    'Extended',
                    iconBuilder: (p0) => IconButton(onPressed: () {}, icon: Icon(Icons.person)),
                    widgetBuilder: (p0, data) => FloatingActionButton.extended(
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
      );
}
