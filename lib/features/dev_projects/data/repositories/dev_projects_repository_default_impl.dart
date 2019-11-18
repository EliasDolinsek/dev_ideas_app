import 'package:dartz/dartz.dart';
import 'package:dev_ideas/features/core/errors/failures.dart';
import 'package:dev_ideas/features/dev_projects/data/datasources/dev_projects_local_datsource.dart';
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

}