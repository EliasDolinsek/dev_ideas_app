import 'package:dartz/dartz.dart';
import 'package:dev_ideas/features/core/errors/failures.dart';
import 'package:dev_ideas/features/core/usecases/usecase.dart';
import 'package:dev_ideas/features/dev_projects/domain/enteties/idea.dart';
import 'package:dev_ideas/features/dev_projects/domain/repositories/dev_projects_repository.dart';

class GetAllIdeas extends Usecase<List<Idea>, NoParams> {

  final DevProjectsRepository repository;

  GetAllIdeas(this.repository);

  @override
  Future<Either<Failure, List<Idea>>> call(NoParams params) async {
    return await repository.getAllIdeas();
  }
}