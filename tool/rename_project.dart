// Renames this template into a new project.
// Flutter BLoC Clean Architecture template by @nkqdev - https://github.com/nkqdev/flutter-bloc-clean-architecture
//
// Usage (from the project root):
//   dart run tool/rename_project.dart --name my_shop --org com.acme --display "My Shop"
//   dart run tool/rename_project.dart ... --dry-run   # list changes only
//
// What changes:
//   - Dart package name (pubspec + every `package:<name>/` import)
//   - Android applicationId/namespace, MainActivity package and folder, label
//   - iOS bundle identifier (+ RunnerTests), CFBundleName, CFBundleDisplayName
//   - App title (l10n), VS Code launch names, README title, APP_CLIENT_ID
//
// The current values are read from the project, so the script also works on
// a project that has already been renamed once.
import 'dart:io';

const _textExtensions = {
  '.dart',
  '.yaml',
  '.yml',
  '.json',
  '.md',
  '.kts',
  '.gradle',
  '.xml',
  '.kt',
  '.plist',
  '.pbxproj',
  '.xcscheme',
  '.xcconfig',
  '.iml',
  '.arb',
};

const _skippedDirectories = {
  'build',
  '.dart_tool',
  '.git',
  'Pods',
  '.symlinks',
  'ephemeral',
  '.gradle',
  '.fvm',
};

final _dartReservedWords = {
  'abstract',
  'as',
  'assert',
  'async',
  'await',
  'break',
  'case',
  'catch',
  'class',
  'const',
  'continue',
  'default',
  'do',
  'else',
  'enum',
  'export',
  'extends',
  'false',
  'final',
  'finally',
  'for',
  'if',
  'import',
  'in',
  'is',
  'library',
  'new',
  'null',
  'return',
  'super',
  'switch',
  'this',
  'throw',
  'true',
  'try',
  'var',
  'void',
  'while',
  'with',
  'flutter',
  'test',
};

void main(List<String> arguments) {
  final args = _parseArgs(arguments);
  final newName = args['name'];
  final newOrg = args['org'];
  final newDisplay = args['display'];
  final dryRun = args.containsKey('dry-run');

  if (newName == null || newOrg == null || newDisplay == null) {
    _fail(
      'Missing arguments.\n'
      'Usage: dart run tool/rename_project.dart --name my_shop --org com.acme '
      '--display "My Shop" [--dry-run]',
    );
  }
  if (!RegExp(r'^[a-z][a-z0-9_]*$').hasMatch(newName) ||
      _dartReservedWords.contains(newName)) {
    _fail('--name must be lower_snake_case and not a Dart keyword: $newName');
  }
  if (!RegExp(r'^[a-z][a-z0-9_]*(\.[a-z][a-z0-9_]*)+$').hasMatch(newOrg)) {
    _fail('--org must look like com.company: $newOrg');
  }
  if (newDisplay.trim().isEmpty) _fail('--display must not be empty');

  final root = Directory.current;
  if (!File('${root.path}/pubspec.yaml').existsSync()) {
    _fail('Run this script from the project root (pubspec.yaml not found).');
  }

  // ---- Current values, read from the project ----
  final old = _CurrentValues.read(root.path);

  // ---- New values ----
  final newAndroidId = '$newOrg.$newName';
  // iOS bundle ids allow letters, digits, '-' and '.', not '_'.
  final newIosId = '${newOrg.replaceAll('_', '-')}.${_camelCase(newName)}';
  final newClientId = '${newName.replaceAll('_', '-')}-mobile';

  stdout.writeln(
    'Flutter BLoC Clean Architecture template by @nkqdev (https://github.com/nkqdev/flutter-bloc-clean-architecture)\n',
  );
  stdout.writeln('Renaming project${dryRun ? ' (dry run)' : ''}:');
  stdout.writeln('  package     ${old.name} -> $newName');
  stdout.writeln('  android id  ${old.androidId} -> $newAndroidId');
  stdout.writeln('  ios id      ${old.iosId} -> $newIosId');
  stdout.writeln('  app title   ${old.display} -> $newDisplay');
  stdout.writeln('');

  final edits = <_Edit>[
    _Edit.all(
      (s) => s
          .replaceAll(old.androidId, newAndroidId)
          .replaceAll(old.iosId, newIosId)
          .replaceAll('package:${old.name}/', 'package:$newName/')
          .replaceAll('${old.name}.iml', '$newName.iml'),
    ),
    _Edit.file(
      'pubspec.yaml',
      (s) => s
          .replaceFirst(
            RegExp(r'^name: .*$', multiLine: true),
            'name: $newName',
          )
          .replaceFirst(
            RegExp(r'^description: .*$', multiLine: true),
            'description: "$newDisplay mobile application."',
          ),
    ),
    _Edit.file(
      'android/app/src/main/AndroidManifest.xml',
      (s) => s.replaceFirst(
        RegExp(r'android:label="[^"]*"'),
        'android:label="$newDisplay"',
      ),
    ),
    _Edit.file(
      'ios/Runner/Info.plist',
      (s) => s
          .replaceFirstMapped(
            RegExp(r'(<key>CFBundleDisplayName</key>\s*<string>)[^<]*'),
            (m) => '${m[1]}$newDisplay',
          )
          .replaceFirstMapped(
            RegExp(r'(<key>CFBundleName</key>\s*<string>)[^<]*'),
            (m) => '${m[1]}$newName',
          ),
    ),
    for (final arb in ['lib/l10n/app_en.arb', 'lib/l10n/app_vi.arb'])
      _Edit.file(
        arb,
        (s) => s.replaceFirst(
          RegExp(r'"appTitle":\s*"[^"]*"'),
          '"appTitle": "${_escapeJson(newDisplay)}"',
        ),
      ),
    _Edit.file(
      '.vscode/launch.json',
      (s) =>
          s.replaceAll('"name": "${old.display} (', '"name": "$newDisplay ('),
    ),
    _Edit.file(
      'README.md',
      (s) =>
          s.replaceFirst(RegExp(r'^# .*$', multiLine: true), '# $newDisplay'),
    ),
    for (final env in ['env/local.json', 'env/uat.json', 'env/production.json'])
      _Edit.file(
        env,
        (s) => s.replaceFirst(
          RegExp(r'"APP_CLIENT_ID":\s*"[^"]*"'),
          '"APP_CLIENT_ID": "$newClientId"',
        ),
      ),
  ];

  var changedFiles = 0;
  for (final file in _textFiles(root)) {
    final relative = file.path.substring(root.path.length + 1);
    final original = file.readAsStringSync();
    var content = original;
    for (final edit in edits) {
      if (edit.path == null || edit.path == relative) {
        content = edit.apply(content);
      }
    }
    if (content != original) {
      changedFiles++;
      stdout.writeln('  edit  $relative');
      if (!dryRun) file.writeAsStringSync(content);
    }
  }

  // ---- Android: move MainActivity to the folder matching its package ----
  final kotlinRoot = '${root.path}/android/app/src/main/kotlin';
  final oldKotlinDir = Directory(
    '$kotlinRoot/${old.androidId.replaceAll('.', '/')}',
  );
  final newKotlinDir = Directory(
    '$kotlinRoot/${newAndroidId.replaceAll('.', '/')}',
  );
  if (oldKotlinDir.path != newKotlinDir.path && oldKotlinDir.existsSync()) {
    stdout.writeln(
      '  move  ${oldKotlinDir.path.substring(root.path.length + 1)}'
      ' -> ${newKotlinDir.path.substring(root.path.length + 1)}',
    );
    if (!dryRun) {
      newKotlinDir.createSync(recursive: true);
      for (final entity in oldKotlinDir.listSync()) {
        entity.renameSync(
          '${newKotlinDir.path}/${entity.uri.pathSegments.lastWhere((p) => p.isNotEmpty)}',
        );
      }
      _deleteEmptyParents(oldKotlinDir, stopAt: Directory(kotlinRoot));
    }
  }

  // ---- IntelliJ module file ----
  final oldIml = File('${root.path}/${old.name}.iml');
  if (old.name != newName && oldIml.existsSync()) {
    stdout.writeln('  move  ${old.name}.iml -> $newName.iml');
    if (!dryRun) oldIml.renameSync('${root.path}/$newName.iml');
  }

  stdout.writeln(
    '\n$changedFiles file(s) ${dryRun ? 'would change' : 'changed'}.',
  );
  if (!dryRun) {
    stdout.writeln('''
Next steps:
  fvm flutter clean
  fvm flutter pub get
  fvm dart run build_runner build --delete-conflicting-outputs
  fvm flutter test''');
  }
}

/// Values of the project as it is now.
class _CurrentValues {
  final String name;
  final String androidId;
  final String iosId;
  final String display;

  _CurrentValues(this.name, this.androidId, this.iosId, this.display);

  factory _CurrentValues.read(String root) {
    String match(String path, RegExp pattern, String what) {
      final file = File('$root/$path');
      final value = file.existsSync()
          ? pattern
                .allMatches(file.readAsStringSync())
                .map((m) => m.group(1)!)
                // iOS: skip the RunnerTests target, keep the app's own id.
                .where((v) => !v.endsWith('.RunnerTests'))
                .firstOrNull
          : null;
      if (value == null) _fail('Could not read $what from $path');
      return value;
    }

    return _CurrentValues(
      match(
        'pubspec.yaml',
        RegExp(r'^name:\s*(\S+)', multiLine: true),
        'package name',
      ),
      match(
        'android/app/build.gradle.kts',
        RegExp(r'applicationId\s*=\s*"([^"]+)"'),
        'applicationId',
      ),
      match(
        'ios/Runner.xcodeproj/project.pbxproj',
        RegExp(r'PRODUCT_BUNDLE_IDENTIFIER = ([^;]+);'),
        'bundle identifier',
      ),
      match(
        'lib/l10n/app_en.arb',
        RegExp(r'"appTitle":\s*"([^"]*)"'),
        'app title',
      ),
    );
  }
}

class _Edit {
  /// `null` means every text file.
  final String? path;
  final String Function(String) apply;

  _Edit.all(this.apply) : path = null;
  _Edit.file(this.path, this.apply);
}

Iterable<File> _textFiles(Directory dir) sync* {
  for (final entity in dir.listSync(followLinks: false)) {
    final name = entity.uri.pathSegments.lastWhere((p) => p.isNotEmpty);
    if (entity is Directory) {
      if (!_skippedDirectories.contains(name)) yield* _textFiles(entity);
    } else if (entity is File) {
      final dot = name.lastIndexOf('.');
      if (dot >= 0 && _textExtensions.contains(name.substring(dot))) {
        yield entity;
      }
    }
  }
}

void _deleteEmptyParents(Directory dir, {required Directory stopAt}) {
  var current = dir;
  while (current.path != stopAt.path &&
      current.existsSync() &&
      current.listSync().isEmpty) {
    current.deleteSync();
    current = current.parent;
  }
}

String _camelCase(String snake) {
  final parts = snake.split('_').where((p) => p.isNotEmpty).toList();
  return parts.first +
      parts.skip(1).map((p) => p[0].toUpperCase() + p.substring(1)).join();
}

String _escapeJson(String value) =>
    value.replaceAll(r'\', r'\\').replaceAll('"', r'\"');

Map<String, String> _parseArgs(List<String> arguments) {
  final result = <String, String>{};
  for (var i = 0; i < arguments.length; i++) {
    final arg = arguments[i];
    if (!arg.startsWith('--')) continue;
    final key = arg.substring(2);
    final hasValue =
        i + 1 < arguments.length && !arguments[i + 1].startsWith('--');
    result[key] = hasValue ? arguments[++i] : '';
  }
  return result;
}

Never _fail(String message) {
  stderr.writeln('Error: $message');
  exit(64);
}
