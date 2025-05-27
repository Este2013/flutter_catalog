// ignore_for_file: avoid_print

import 'dart:io';

import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:path/path.dart';

import '../gen_utils/generator.dart';
import '../gen_utils/get_flutter_files.dart';

class BasicsWidgetDataGen extends Generator {
  BasicsWidgetDataGen()
      : super(
          'BasicsWidgetData',
          '0.1.2',
          relativeTargetFilePath: 'generated_test/basics.dart',
          // generatedImports: ['../gen_utils/generator.dart', '../gen_utils/generator.dart'],
        );

  @override
  String generate() {
    String content = 'I like\n';

    var sourceDartFile = '${getFlutterSDKPath()}\\src\\widgets\\basic.dart';
    print(sourceDartFile);
    final sourceContent = File(sourceDartFile).readAsStringSync();

    // print(sourceContent);

    final parseResult = parseString(content: sourceContent, path: sourceDartFile);
    final unit = parseResult.unit;
    final collector = SingleChildRenderObjectWidgetCollector();
    unit.visitChildren(collector);

    var result = '';
    for (final classNode in collector.widgets) {
      final className = classNode.name.lexeme;
      final parameters = <String, String>{}; // name -> type

      print('\n\n' + className);
      for (final member in classNode.members) {
        print('${member.runtimeType}: \n\t$member');
        if (member is ConstructorDeclaration && member.factoryKeyword == null) {
          for (final param in member.parameters.parameters) {
            print('hi $param (${param.runtimeType})');
            // TODO params not generating
            if (param is DefaultFormalParameter) {
              final normalParam = param.parameter;
              if (normalParam is SimpleFormalParameter && normalParam.keyword?.lexeme != null) {
                final name = normalParam.keyword?.lexeme;
                final type = normalParam.type?.toSource() ?? 'dynamic';
                if (name != null) {
                  parameters[name] = type;
                } else {
                  print('name was null');
                }
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

class SingleChildRenderObjectWidgetCollector extends RecursiveAstVisitor<void> {
  final widgets = <ClassDeclaration>[];

  @override
  void visitClassDeclaration(ClassDeclaration node) {
    print('hi');
    final extendsClause = node.extendsClause;
    if (extendsClause != null && extendsClause.superclass.name2.lexeme == 'SingleChildRenderObjectWidget') {
      widgets.add(node);
    }
    super.visitClassDeclaration(node);
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
