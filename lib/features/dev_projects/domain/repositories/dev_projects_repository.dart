import 'package:dartz/dartz.dart';
import 'package:dev_ideas/core/errors/failures.dart';
import 'package:dev_ideas/features/dev_projects/domain/enteties/idea.dart';
import 'package:equatable/equatable.dart';

abstract class DevProjectsRepository extends Equatable {

  Future<Either<Failure, List<Idea>>> getAllIdeas();

  Future<Either<Failure, void>> addIdea(Idea idea);

  Future<Either<Failure, void>> removeIdea(String ideaID);

  Future<Either<Failure, void>> updateIdea(String ideaID, Idea update);

}