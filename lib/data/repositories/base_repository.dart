import 'package:dartz/dartz.dart';
import 'package:flutter_bloc_clean_architecture/data/network/failure_mapper.dart';
import 'package:flutter_bloc_clean_architecture/domain/failures/failure.dart';

/// Shared helpers for repository implementations.
abstract class BaseRepository {
  /// Executes [request] and converts any thrown error into a [Failure].
  Future<Either<Failure, T>> guard<T>(Future<T> Function() request) async {
    try {
      return Right(await request());
    } catch (e) {
      return Left(mapErrorToFailure(e));
    }
  }
}
