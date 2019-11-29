import 'package:dartz/dartz.dart';
import 'package:dev_ideas/core/errors/failures.dart';
import 'package:dev_ideas/core/usecases/usecase.dart';
import 'package:dev_ideas/features/dev_projects/domain/repositories/dev_projects_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class RemoveIdea extends Usecase<void, RemoveIdeaParams> {

  final DevProjectsRepository repository;

  RemoveIdea(this.repository);

  @override
  Future<Either<Failure, void>> call(RemoveIdeaParams params) async {
    return await repository.removeIdea(params.ideaID);
  }

}
class RemoveIdeaParams extends Equatable {

  final String ideaID;

  RemoveIdeaParams({@required this.ideaID}) : super([ideaID]);
}