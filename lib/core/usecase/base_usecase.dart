import 'package:dartz/dartz.dart';
import '../errors/failure.dart';

abstract class BaseUsecase<T, Parameters> {
  // callable class
  Future<Either<Failure, T>> call(Parameters parameters);
}