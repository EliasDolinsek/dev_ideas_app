import 'package:dartz/dartz.dart';
import 'package:dev_ideas/core/errors/failures.dart';
import 'package:dev_ideas/core/errors/failures.dart';
import 'package:dev_ideas/core/usecases/usecase.dart';
import 'package:dev_ideas/features/dev_projects/domain/enteties/idea.dart';
import 'package:dev_ideas/features/dev_projects/domain/repositories/dev_projects_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class GetSpecificIdea extends Usecase<Idea, String> {
  final DevProjectsRepository repository;

  GetSpecificIdea(this.repository);

  @override
  Future<Either<Failure, Idea>> call(String params) async {
    final allIdeas = await repository.getAllIdeas();
    return allIdeas.fold((failure) => Left(failure),
        (ideasList) => _getIdeaWithId(ideasList, params));
  }

  Either<Failure, Idea> _getIdeaWithId(List<Idea> ideas, String id) {
    final idea = ideas.firstWhere((idea) => idea.id == id, orElse: () => null);
    if (idea == null) {
      return Left(IdeaNotFoundFailure());
    } else {
      return Right(idea);
    }
  }
}

class GetSpecificIdeaParams extends Equatable {
  final String id;

  GetSpecificIdeaParams({@required this.id}) : super([id]);
}
