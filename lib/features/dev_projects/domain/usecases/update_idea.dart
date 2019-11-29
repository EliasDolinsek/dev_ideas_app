import 'package:dartz/dartz.dart';
import 'package:dev_ideas/core/errors/failures.dart';
import 'package:dev_ideas/core/usecases/usecase.dart';
import 'package:dev_ideas/features/dev_projects/domain/enteties/idea.dart';
import 'package:dev_ideas/features/dev_projects/domain/repositories/dev_projects_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class UpdateIdea extends Usecase<void, UpdateIdeaParams> {

  final DevProjectsRepository repository;

  UpdateIdea(this.repository);

  @override
  Future<Either<Failure, void>> call(UpdateIdeaParams params) async {
    return await repository.updateIdea(params.ideaID, params.update);
  }

}

class UpdateIdeaParams extends Equatable {

  final String ideaID;
  final Idea update;

  UpdateIdeaParams({@required this.ideaID, @required this.update}) : super([ideaID, update]);
}