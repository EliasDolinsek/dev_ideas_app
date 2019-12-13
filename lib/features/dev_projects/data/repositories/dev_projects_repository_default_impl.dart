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
      return _addIdea(idea, ideasAsList);
    });
  }

  Future<Either<Failure, void>> _addIdea(Idea idea, List<Idea> ideas) async {
    if(_ideaByIdAlreadyExists(ideas, idea)){
      final failure = IdeaAlreadyExistsFailure();
      return Left(failure);
    } else {
      final ideaModelToAdd = IdeaModel.fromIdea(idea);
      ideas.add(ideaModelToAdd);

      await localDataSource.writeIdeas(ideas);
      return Right(null);
    }
  }

  @override
  Future<Either<Failure, void>> removeIdea(String ideaID) async {
    final ideas = await getAllIdeas();
    return ideas.fold((failure) => Left(failure), (ideasAsList) {
      return _removeIdea(ideaID, ideasAsList);
    });
  }

  Future<Either<Failure, void>> _removeIdea(String ideaID, List<Idea> ideas) async {
    final ideaToRemove = ideas.firstWhere((idea) => idea.id == ideaID,
        orElse: () => null);

    if (ideaToRemove == null) {
      final failure = IdeaNotFoundFailure();
      return Left(failure);
    } else {
      ideas.remove(ideaToRemove);

      localDataSource.writeIdeas(ideas);
      return Right(null);
    }
  }

  @override
  Future<Either<Failure, void>> updateIdea(String ideaID, Idea update) async {
    final ideas = await getAllIdeas();
    return ideas.fold((failure) => Left(failure), (ideasAsList) async {
      return _updateIdea(ideaID, update, ideasAsList);
    });
  }

  Future<Either<Failure, void>> _updateIdea(String ideaID, Idea update, List<Idea> ideas) async {
    final ideaToReplace = ideas.firstWhere((idea) => idea.id == ideaID,
        orElse: () => null);

    if (ideaToReplace == null) {
      final failure = IdeaNotFoundFailure();
      return Left(failure);
    } else {
      final indexOfReplacement = ideas.indexOf(ideaToReplace);

      ideas.removeAt(indexOfReplacement);
      ideas.insert(indexOfReplacement, update);

      await localDataSource.writeIdeas(ideas);
      return Right(null);
    }
  }

  bool _ideaByIdAlreadyExists(List<Idea> ideas, Idea idea) {
    for (Idea currentIdea in ideas) {
      if (currentIdea.id == idea.id) return true;
    }

    return false;
  }
}
