import 'package:dartz/dartz.dart';
import 'package:dev_ideas/core/errors/failures.dart';
import 'package:dev_ideas/core/usecases/usecase.dart';
import 'package:dev_ideas/features/dev_projects/domain/enteties/dev_status.dart';
import 'package:dev_ideas/features/dev_projects/domain/enteties/idea.dart';
import 'package:dev_ideas/features/dev_projects/domain/repositories/dev_projects_repository.dart';
import 'package:equatable/equatable.dart';

class GetIdeasByFilter extends Usecase<List<Idea>, GetIdeasByFilterParams> {
  final DevProjectsRepository repository;

  GetIdeasByFilter(this.repository);

  @override
  Future<Either<Failure, List<Idea>>> call(
      GetIdeasByFilterParams params) async {
    final allIdeas = await repository.getAllIdeas();

    return allIdeas.fold((failure) {
      return Left(failure);
    }, (ideasList) {
      return Right(_filterIdeas(ideasList, params));
    });
  }

  List<Idea> _filterIdeas(
      List<Idea> ideasToFilter, GetIdeasByFilterParams filter) {
    var usableIdeas = ideasToFilter;

    if (filter.devStatus != null)
      usableIdeas = _filterIdeasByDevStatus(usableIdeas, filter.devStatus);

    final filteredIdeas = [];
    if(filter.title != null){
     filteredIdeas.addAll(_filterIdeasByTitle(usableIdeas, filter.title));
    }

    return filteredIdeas.toList().cast<Idea>();
  }

  List<Idea> _filterIdeasByDevStatus(List<Idea> ideas, DevStatus status) =>
      ideas.where((idea) => idea.status == status).toList();

  List<Idea> _filterIdeasByTitle(List<Idea> ideas, String title) {
    return ideas.where((idea) => idea.title.contains(title)).toList();
  }
}

class GetIdeasByFilterParams extends Equatable {
  final String title, projectName, category;
  final DevStatus devStatus;

  GetIdeasByFilterParams(
      {this.title, this.projectName, this.category, this.devStatus})
      : super([title, category, devStatus]);
}
