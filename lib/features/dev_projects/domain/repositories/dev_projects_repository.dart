import 'package:dartz/dartz.dart';
import 'package:dev_ideas/features/core/errors/failures.dart';
import 'package:dev_ideas/features/dev_projects/domain/enteties/dev_status.dart';
import 'package:dev_ideas/features/dev_projects/domain/enteties/idea.dart';
import 'package:equatable/equatable.dart';

abstract class DevProjectsRepository extends Equatable {

  Future<Either<Failure, List<Idea>>> getAllIdeas();

}