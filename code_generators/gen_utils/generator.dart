import 'dart:io';

import 'package:path/path.dart' as path;

abstract class Generator {
  final String name;
  final String generatorVersion;
  final File targetFile;
  final List<String> generatedImports;

  Generator(this.name, this.generatorVersion, {required String relativeTargetFilePath, this.generatedImports = const []})
      : targetFile = File(path.join(Directory.current.path, relativeTargetFilePath));

  /// Developers must implement this to return the content to generate.
  String generate();

  /// Creates or updates the target Dart file with generated content.
  Future<void> createOutput() async {
    String marker = '/' * 50;
    String generatedImportsStart = '$marker\n// GENERATED IMPORTS - DO NOT EDIT\n$marker';
    String nonGeneratedStart = '$marker\n// NON-GENERATED SECTION\n$marker';
    String generatedStart = '$marker\n// GENERATED CODE - DO NOT EDIT\n$marker';

    String? existingContent;
    if (await targetFile.exists()) {
      existingContent = await targetFile.readAsString();
    }

    String userCode = '';
    String oldGeneratedVersion = '0.0.0';

    if (existingContent != null) {
      final parts = existingContent.split(generatedStart);
      if (parts.length > 1) {
        userCode = parts[0];

        final versionMatch = RegExp(r'// Generator Version: (.+)').firstMatch(existingContent);
        if (versionMatch != null) {
          oldGeneratedVersion = versionMatch.group(1)!;
        }
      } else {
        userCode = existingContent;
      }
    }
    if (userCode.contains(nonGeneratedStart)) {
      userCode = userCode.split(nonGeneratedStart)[1].trim();
    }

    if (_compareVersions(generatorVersion, oldGeneratedVersion) <= 0) {
      print('Existing generated code is up to date (version $oldGeneratedVersion).');
      return;
    }

    final importsSection = [generatedImportsStart, for (final imp in generatedImports) "import '$imp';"].join('\n');

    final header = [
      '// This file is generated. Do not edit unless in the designated section.',
      '// Generator Name   : $name',
      '// Generator Version: $generatorVersion',
      if (generatedImports.isNotEmpty) '',
      if (generatedImports.isNotEmpty) importsSection,
      '',
    ].join('\n');

    final generatedCode = [
      generatedStart,
      generate(),
    ].join('\n\n');

    await targetFile.create(recursive: true);
    await targetFile.writeAsString('$header\n\n$nonGeneratedStart\n\n$userCode\n\n$generatedCode');
    print('Generated code written to ${targetFile.path}');
  }

  /// Returns < 0 if v1 < v2, 0 if equal, > 0 if v1 > v2
  int _compareVersions(String v1, String v2) {
    final v1Parts = v1.split('.').map(int.parse).toList();
    final v2Parts = v2.split('.').map(int.parse).toList();

    for (var i = 0; i < 3; i++) {
      if (v1Parts[i] != v2Parts[i]) {
        return v1Parts[i] - v2Parts[i];
      }
    }
    return 0;
  }
}
