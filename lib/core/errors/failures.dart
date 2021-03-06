import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  Failure([List properties = const <dynamic>[]]) : super(properties);
}

class CacheFailure extends Failure {}

class IdeaNotFoundFailure extends Failure {}

class IdeaAlreadyExistsFailure extends Failure {}