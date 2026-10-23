import 'package:flutter_bloc_clean_architecture/di/modules/bloc_module.dart';
import 'package:flutter_bloc_clean_architecture/di/modules/core_module.dart';
import 'package:flutter_bloc_clean_architecture/di/modules/repository_module.dart';
import 'package:flutter_bloc_clean_architecture/di/modules/usecase_module.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

/// Composition root: the only place that wires every layer together.
///
/// Modules are registered from the outside in: infrastructure, repositories
/// (data), use cases (domain), then blocs (presentation).
mixin ServiceLocator {
  static Future<void> configureDependencies() async {
    await CoreModule.register(getIt);
    await RepositoryModule.register(getIt);
    await UseCaseModule.register(getIt);
    await BlocModule.register(getIt);
  }
}
