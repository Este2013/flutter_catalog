// ignore_for_file: avoid_print

import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';

class ClassVisitor extends RecursiveAstVisitor<void> {
  @override
  void visitClassDeclaration(ClassDeclaration node) {
    print('Class: ${node.name}');
    super.visitClassDeclaration(node);
  }

  @override
  void visitMethodDeclaration(MethodDeclaration node) {
    print('  Method: ${node.name}');
    super.visitMethodDeclaration(node);
  }
}
