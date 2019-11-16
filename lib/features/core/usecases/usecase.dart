import 'package:dartz/dartz.dart';
import 'package:dev_ideas/features/core/errors/failure.dart';
import 'package:equatable/equatable.dart';

abstract class Usecase<Type, Params> {

  //dabei kann man usecase() aufrufen, genauso wie usecase.call()
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams extends Equatable {}
