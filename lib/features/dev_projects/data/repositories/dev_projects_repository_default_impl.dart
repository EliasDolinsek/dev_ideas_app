import 'package:dartz/dartz.dart';
import 'package:dev_ideas/core/errors/failures.dart';
import 'package:dev_ideas/features/dev_projects/data/datasources/dev_projects_local_datsource.dart';
import 'package:dev_ideas/features/dev_projects/data/models/idea_model.dart';
import 'package:dev_ideas/features/dev_projects/domain/enteties/idea.dart';
import 'package:dev_ideas/features/dev_projects/domain/repositories/dev_projects_repository.dart';
import 'package:meta/meta.dart';

class DevProjectsRepositoryDefaultImpl extends DevProjectsRepository {
  final DevProjectsLocalDataSource localDataSource;

  DevProjectsRepositoryDefaultImpl({@required this.localDataSource});

  @override
  Future<Either<Failure, List<Idea>>> getAllIdeas() async {
    try {
      return Right(await localDataSource.getAllIdeas());
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, void>> addIdea(Idea idea) async {
    final ideas = await getAllIdeas();
    return ideas.fold((failure) => Left(failure), (ideasAsList) async {
      if(_ideaByIdAlreadyExists(ideasAsList, idea)){
        return Left(IdeaAlreadyExistsFailure());
      } else {
        final ideaToAdd = IdeaModel.fromIdea(idea);
        ideasAsList.add(ideaToAdd);
        await localDataSource.writeIdeas(ideasAsList);
        return Right(null);
      }
    });
  }

  @override
  Future<Either<Failure, void>> removeIdea(String ideaID) async {
    final ideas = await getAllIdeas();
    return ideas.fold((failure) => Left(failure), (ideasAsList) {
      final ideaToRemove = ideasAsList.firstWhere((idea) => idea.id == ideaID,
          orElse: () => null);
      if (ideaToRemove == null) {
        return Left(IdeaNotFoundFailure());
      } else {
        ideasAsList.remove(ideaToRemove);
        localDataSource.writeIdeas(ideasAsList);
        return Right(null);
      }
    });
  }

  @override
  Future<Either<Failure, void>> updateIdea(String ideaID, Idea update) async {
    final ideas = await getAllIdeas();
    return ideas.fold((failure) => Left(failure), (ideasAsList) async {
      final ideaToReplace = ideasAsList.firstWhere((idea) => idea.id == ideaID,
          orElse: () => null);
      if (ideaToReplace == null) {
        return Left(IdeaNotFoundFailure());
      } else {
        final indexOfReplacement = ideasAsList.indexOf(ideaToReplace);

        ideasAsList.removeAt(indexOfReplacement);
        ideasAsList.insert(indexOfReplacement, update);

        await localDataSource.writeIdeas(ideasAsList);

        return Right(null);
      }
    });
  }

  bool _ideaByIdAlreadyExists(List<Idea> ideas, Idea idea) {
    for (Idea currentIdea in ideas) {
      if (currentIdea.id == idea.id) return true;
    }

    return false;
  }
}
