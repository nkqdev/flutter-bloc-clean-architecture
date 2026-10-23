import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// Guards the Clean Architecture dependency rules by scanning imports.
///
/// Allowed flow:
///   presentation -> domain, common      data -> domain, common
///   common -> domain (entities only)    domain -> nothing but itself
///   di / routes / main.dart wire everything together.
const _package = 'package:flutter_bloc_clean_architecture/';

final _importPattern = RegExp(r'''^(?:import|export)\s+['"]([^'"]+)['"]''');

/// Every `package:` / `dart:` URI imported by the hand-written files in [dir].
Map<String, List<String>> _importsIn(String dir) {
  final result = <String, List<String>>{};
  final files = Directory(dir)
      .listSync(recursive: true)
      .whereType<File>()
      .where(
        (f) =>
            f.path.endsWith('.dart') &&
            !f.path.endsWith('.g.dart') &&
            !f.path.endsWith('.freezed.dart'),
      );
  for (final file in files) {
    result[file.path] = [
      for (final line in file.readAsLinesSync())
        ?_importPattern.firstMatch(line.trim())?.group(1),
    ];
  }
  return result;
}

List<String> _violations(String dir, bool Function(String uri) isForbidden) {
  return [
    for (final MapEntry(key: file, value: uris) in _importsIn(dir).entries)
      for (final uri in uris)
        if (isForbidden(uri)) '$file -> $uri',
  ];
}

bool _layer(String uri, String layer) => uri.startsWith('$_package$layer/');

void main() {
  test('domain is pure Dart and imports only itself', () {
    const allowed = [
      'dart:',
      'package:dartz/',
      'package:meta/',
      '${_package}domain/',
    ];
    final violations = _violations(
      'lib/domain',
      (uri) => !allowed.any(uri.startsWith) || uri == 'dart:ui',
    );
    expect(violations, isEmpty, reason: violations.join('\n'));
  });

  test('data does not depend on presentation, routes or di', () {
    final violations = _violations(
      'lib/data',
      (uri) =>
          _layer(uri, 'presentation') ||
          _layer(uri, 'routes') ||
          _layer(uri, 'di') ||
          uri.startsWith('package:flutter_bloc/'),
    );
    expect(violations, isEmpty, reason: violations.join('\n'));
  });

  test('presentation does not depend on data or di', () {
    final violations = _violations(
      'lib/presentation',
      (uri) =>
          _layer(uri, 'data') ||
          _layer(uri, 'di') ||
          uri.startsWith('package:dio/') ||
          uri.startsWith('package:retrofit/'),
    );
    expect(violations, isEmpty, reason: violations.join('\n'));
  });

  test('common does not depend on data, presentation, routes or di', () {
    final violations = _violations(
      'lib/common',
      (uri) =>
          _layer(uri, 'data') ||
          _layer(uri, 'presentation') ||
          _layer(uri, 'routes') ||
          _layer(uri, 'di'),
    );
    expect(violations, isEmpty, reason: violations.join('\n'));
  });
}
