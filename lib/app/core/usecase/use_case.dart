import 'package:dartz/dartz.dart';

import '../domain/failures/failures.dart';

abstract class UseCase<Type, Params> {
  const UseCase();

  Future<Type> call(Params params);
}

abstract class UseCaseWithFailure<F extends Failures, Type, Params>
    extends UseCase<Either<F, Type>, Params> {
  const UseCaseWithFailure();
  @override
  Future<Either<F, Type>> call(Params params);
}

abstract class UseCaseStream<F extends Failures, Type, Params> {
  const UseCaseStream();

  Stream<Either<F, Type>> call(Params params);
}

class NoParams {
  const NoParams();
}
