import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';

// Visits widgets that extend (possibly recursively) one of the provided base class(es).
class RecursiveExtendedWidgetCollector extends RecursiveAstVisitor<void> {
  final List<String> extendedClasses;

  RecursiveExtendedWidgetCollector({required this.extendedClasses}) : assert(extendedClasses.isNotEmpty);

  // RUNNING VARIABLES

  /// To fill in the widgets list, call finalize().
  final List<ClassDeclaration> widgets = [];
  final Map<String, String?> inheritanceMap = {}; // className -> superclassName

  // Not a map to preserve order of classdeclarations in the original source file
  final List<(String, ClassDeclaration)> tempStorage = [];

  /////////////////////////////

  @override
  void visitClassDeclaration(ClassDeclaration node) {
    final className = node.name.lexeme;
    final extendsClause = node.extendsClause;
    final superclass = extendsClause?.superclass.name2.lexeme;

    inheritanceMap[className] = superclass;
    tempStorage.add((className, node));

    super.visitClassDeclaration(node);
  }

  void finalize() {
    for (final className in inheritanceMap.keys) {
      if (extendedClasses.any((base) => _isSubclassOf(className, base))) {
        final node = _findNodeByName(className);
        if (node != null) widgets.add(node);
      }
    }
  }

  bool _isSubclassOf(String? name, String target) {
    while (name != null) {
      if (name == target) return true;
      name = inheritanceMap[name];
    }
    return false;
  }

  ClassDeclaration? _findNodeByName(String name) => tempStorage.firstWhere((e) => e.$1 == name).$2;
}
