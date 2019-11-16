import 'package:dartz/dartz.dart';
import 'package:dev_ideas/features/core/errors/failure.dart';
import 'package:dev_ideas/features/core/usecases/usecase.dart';
import 'package:dev_ideas/features/dev_projects/domain/enteties/dev_status.dart';
import 'package:dev_ideas/features/dev_projects/domain/enteties/idea.dart';
import 'package:dev_ideas/features/dev_projects/domain/repositories/dev_projects_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class GetIdeasByFilter extends Usecase<List<Idea>, GetIdeasByFilterParams> {
  final DevProjectsRepository repository;

  GetIdeasByFilter(this.repository);

  @override
  Future<Either<Failure, List<Idea>>> call(GetIdeasByFilterParams params) async {
    return await repository.getIdeasByFilter(
        title: params.title,
        category: params.category,
        devStatus: params.devStatus);
  }
}

class GetIdeasByFilterParams extends Equatable {
  final String title, category;
  final DevStatus devStatus;

  GetIdeasByFilterParams(
      {@required this.title, @required this.category, @required this.devStatus})
      : super([title, category, devStatus]);
}
