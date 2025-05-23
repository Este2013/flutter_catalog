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
          generatedImports: ['../gen_utils/generator.dart', '../gen_utils/generator.dart'],
        );

  @override
  String generate() {
    String content = '';

    for (var i = 0; i < 10; i++) {
      content = content += 'int getInt$i() => $i;\n';
    }
    return content;
  }
}

void analyseBasics() {
  var file = File(join(getFlutterSDKPath(), r'src\widgets\basic.dart'));
  print(file.path);
  print(file.existsSync());
  String content = file.readAsStringSync();

  final parseResult = parseString(content: content);
  final CompilationUnit unit = parseResult.unit;
  unit.visitChildren(_MyVisitor());
}
