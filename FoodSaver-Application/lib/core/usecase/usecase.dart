import 'package:dartz/dartz.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Type, Type>> call(Params params);
}

class NoParams {}
