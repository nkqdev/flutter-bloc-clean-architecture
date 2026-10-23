import 'package:dartz/dartz.dart';
import 'package:flutter_bloc_clean_architecture/domain/failures/failure.dart';

/// Base contract for every use case in the domain layer.
abstract class UseCase<T, Params> {
  Future<Either<Failure, T>> call(Params params);
}

/// Used by use cases that do not require any input.
class NoParams {
  const NoParams();
}
