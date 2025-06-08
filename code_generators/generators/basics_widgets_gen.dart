// ignore_for_file: avoid_print

import 'dart:io';

import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';

import '../collectors/class_collectors.dart';
import '../gen_utils/generator.dart';
import '../gen_utils/get_flutter_files.dart';

class BasicsWidgetDataGen extends Generator {
  BasicsWidgetDataGen()
      : super(
          'BasicsWidgetData',
          '1.0.0',
          relativeTargetFilePath: 'lib/flutter_widgets/basics_data.dart',
          generatedImports: ['package:flutter_catalog/widget_tree_resolver/data.dart'],
        );

  @override
  String generate() {
    String sourceDartFile = '${getFlutterSDKPath()}\\src\\widgets\\basic.dart';
    print(sourceDartFile);
    final sourceContent = File(sourceDartFile).readAsStringSync();

    // print(sourceContent);

    final parseResult = parseString(content: sourceContent, path: sourceDartFile);
    final unit = parseResult.unit;
    final collector = RecursiveExtendedWidgetCollector(
      extendedClasses: [
        'SingleChildRenderObjectWidget',
        'InheritedWidget',
        'ParentDataWidget',
        'MultiChildRenderObjectWidget',
        'LeafRenderObjectWidget',
        'StatelessWidget',
      ],
    );
    unit.visitChildren(collector);
    collector.finalize();

    var result = '';
    for (final classNode in collector.widgets) {
      final className = classNode.name.lexeme;
      final parameters = <String, String>{}; // name -> type

      print('\n\n$className');

      if (className.startsWith('_')) continue;

      for (final member in classNode.members) {
        print('${member.runtimeType}: \n\t$member');
        if (member is ConstructorDeclaration && member.factoryKeyword == null) {
          for (final param in member.parameters.parameters) {
            print('\t | param: $param (${param.runtimeType})');
            if (param is DefaultFormalParameter) {
              final normalParam = param.parameter;
              print("\t\t | ${param.name?.lexeme}");
              final name = param.name?.lexeme;
              if (normalParam is SuperFormalParameter && ['key', 'child'].contains(param.name?.lexeme)) {
                print('skipping super param: "${param.name?.lexeme}"');
              } else if (normalParam is SuperFormalParameter) {
                final type = normalParam.type?.toSource() ?? 'dynamic';
                if (name != null) {
                  parameters[name] = type;
                } else {
                  print('name was null');
                }
              } else if (normalParam is FieldFormalParameter && param.name?.lexeme != null) {
                final type = normalParam.type?.toSource() ?? 'dynamic';
                if (name != null) {
                  parameters[name] = type;
                } else {
                  print('name was null');
                }
              } else if (normalParam is SimpleFormalParameter && param.name?.lexeme != null) {
                final type = normalParam.type?.toSource() ?? 'dynamic';
                if (name != null) {
                  parameters[name] = type;
                } else {
                  print('name was null');
                }
              } else {
                print('\t\t | Skipped; parameter of type ${normalParam.runtimeType}');
              }
            }
          }
        }
      }

      result += '${_generateDataClass(className, parameters)}\n\n';
    }

    return result;
  }

  String _generateDataClass(String className, Map<String, String> params) {
    final buffer = StringBuffer();

    buffer.writeln('class ${className}Data extends WidgetTreeNodeData {');
    buffer.writeln('  ${className}Data({super.child, super.key})');
    buffer.writeln('      : super(');
    buffer.writeln("          '$className',");
    buffer.writeln("          isRenderObject: true,");
    buffer.writeln('          parameters: [');

    for (final entry in params.entries) {
      final name = entry.key;
      final type = entry.value;
      final docUrl = 'https://api.flutter.dev/flutter/widgets/$className/$name.html';
      buffer.writeln("            WidgetPropertyData('$name', typeName: '$type', docsLink: '$docUrl'),");
    }

    buffer.writeln('          ],');
    buffer.writeln('        );\n');
    buffer.writeln('  @override');
    buffer.writeln('  TreeNodeData? build() => child;');
    buffer.writeln('}');

    return buffer.toString();
  }
}

class BasicsWidgetPresentationGen extends Generator {
  BasicsWidgetPresentationGen()
      : super(
          'BasicsWidgetPresentation',
          '1.0.1',
          relativeTargetFilePath: 'lib/flutter_widgets/material/material_home/material_basic_widgets.dart',
          generatedImports: [
            'package:flutter/material.dart',
            'package:flutter_catalog/main.dart',
            'package:flutter_catalog/flutter_widgets/basics_data.dart',
            'package:material_symbols_icons/symbols.dart',
            'material_home.dart',
          ],
        );

  @override
  String generateCustomSection(String alreadyPresentText) {
    // Do not override what's there! (if anything's there)
    if (alreadyPresentText.trim().isNotEmpty) return alreadyPresentText;

    var collector = obtainCollector;

    var result = 'Widget _iconFor(String className) {';
    result += '  switch(className) {';

    for (final classNode in collector.widgets) {
      final className = classNode.name.lexeme;
      if (className.startsWith('_')) continue;
      result += '\n     case "$className": ';
    }

    result += '\n    default: return Icon(Icons.close, color: Colors.red);';
    result += '\n  }\n}';

    result += '\n\n_dialogFor(String className) {';
    result += '\n  switch(className) {';

    for (final classNode in collector.widgets) {
      final className = classNode.name.lexeme;
      if (className.startsWith('_')) continue;
      result += '\n     case "$className": ';
      result += '''return WidgetPresentation.createDialogFrom(
                      title: '$className',
                      variantsData: [
                        WidgetVariantData(
                          null,
                          variantExplanation: '',
                          iconBuilder: null,
                          widgetBuilder: null,
                          widgetTreeExplanation: ${className}Data(),
                        ),
                      ],
                      link: 'https://api.flutter.dev/flutter/widgets/$className-class.html',
                    );''';
    }

    result += '\n    default: return null;';
    result += '\n  }\n}';

    return result;
  }

  @override
  String generate() {
    var collector = obtainCollector;

    var result = 'List<Widget> get basicWidgetsList => [';
    for (final classNode in collector.widgets) {
      final className = classNode.name.lexeme;
      if (className.startsWith('_')) continue;

      result += '${_generateClassPresentation(className)}\n\n';
    }

    return '$result\n];';
  }

  String _generateClassPresentation(String className) {
    final iconMethod = '_iconFor("$className")';
    final dialogMethod = '_dialogFor("$className")';

    return '''
  CustomCardItem.widgetPresentation(
    leading: $iconMethod,
    title: '$className',
    dialog: $dialogMethod,
  ),''';
  }

  RecursiveExtendedWidgetCollector get obtainCollector {
    String sourceDartFile = '${getFlutterSDKPath()}\\src\\widgets\\basic.dart';
    print(sourceDartFile);
    final sourceContent = File(sourceDartFile).readAsStringSync();

    final parseResult = parseString(content: sourceContent, path: sourceDartFile);
    final unit = parseResult.unit;
    final collector = RecursiveExtendedWidgetCollector(
      extendedClasses: [
        'SingleChildRenderObjectWidget',
        'InheritedWidget',
        'ParentDataWidget',
        'MultiChildRenderObjectWidget',
        'LeafRenderObjectWidget',
        'StatelessWidget',
      ],
    );
    unit.visitChildren(collector);
    collector.finalize();

    return collector;
  }
}
