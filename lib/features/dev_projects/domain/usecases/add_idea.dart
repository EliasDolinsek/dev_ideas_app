import 'package:dartz/dartz.dart';
import 'package:dev_ideas/core/errors/failures.dart';
import 'package:dev_ideas/core/usecases/usecase.dart';
import 'package:dev_ideas/features/dev_projects/domain/enteties/idea.dart';
import 'package:dev_ideas/features/dev_projects/domain/repositories/dev_projects_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class AddIdea extends Usecase<void, AddIdeaParams>{

  final DevProjectsRepository repository;

  AddIdea(this.repository);

  @override
  Future<Either<Failure, void>> call(AddIdeaParams params) async {
    return await repository.addIdea(params.idea);
  }

}

class AddIdeaParams extends Equatable {

  final Idea idea;

  AddIdeaParams({@required this.idea}) : super([idea]);

}