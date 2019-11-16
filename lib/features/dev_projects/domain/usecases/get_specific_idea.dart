import 'package:dartz/dartz.dart';
import 'package:dev_ideas/features/core/errors/failure.dart';
import 'package:dev_ideas/features/core/usecases/usecase.dart';
import 'package:dev_ideas/features/dev_projects/domain/enteties/idea.dart';
import 'package:dev_ideas/features/dev_projects/domain/repositories/dev_projects_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class GetSpecificIdea extends Usecase<Idea, String> {

  final DevProjectsRepository repository;

  GetSpecificIdea(this.repository);

  @override
  Future<Either<Failure, Idea>> call(String params) {
    return repository.getSpecificIdea(params);
  }

}

class GetSpecificIdeaParams extends Equatable {

  final String id;

  GetSpecificIdeaParams({@required this.id}) : super([id]);
}