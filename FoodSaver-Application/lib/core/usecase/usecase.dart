import 'package:dartz/dartz.dart';
import 'package:funix_thieudvfx_foodsaver/core/exception/api_exception.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Type, Type>> call(Params params);
}

class NoParams {}

abstract class UseCaseHandleFailure<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}
