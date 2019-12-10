import 'package:dev_ideas/features/dev_projects/domain/enteties/idea.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class DevProjectsState extends Equatable {
  DevProjectsState([List props = const []]) : super([props]);
}

class EmptyDevProjectsBlocState extends DevProjectsState {}

class DevProjectsLoadingState extends DevProjectsState {}

class LoadedDevProjectsState extends DevProjectsState {
  final List<Idea> ideas;

  LoadedDevProjectsState({@required this.ideas}) : super([ideas]);
}

class ErrorDevProjectsState extends DevProjectsState {
  final String error;

  ErrorDevProjectsState({@required this.error}) : super([error]);
}

class LoadedDevProjectsWithFilterState extends DevProjectsState {
  final String title, projectName, category;
  final DevStatus devStatus;
  final List<Idea> ideas;

  LoadedDevProjectsWithFilterState(
      {@required this.title,
      @required this.projectName,
      @required this.category,
      @required this.devStatus,
      @required this.ideas})
      : super([title, projectName, category, devStatus, ideas]);
}