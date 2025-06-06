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
          relativeTargetFilePath: 'lib/flutter_widgets/basics.dart',
          generatedImports: ['package:flutter_catalog/widget_tree_resolver/data.dart'],
        );

  @override
  String generate() {
    var sourceDartFile = '${getFlutterSDKPath()}\\src\\widgets\\basic.dart';
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
