import 'package:dev_ideas/features/dev_projects/domain/enteties/idea.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class DevProjectsEvent extends Equatable {
  DevProjectsEvent([List props = const []]) : super(props);
}

class LoadDevProjectsEvent extends DevProjectsEvent {}

class LoadDevProjectsWithFilterEvent extends DevProjectsEvent {
  final String title, projectName, category;
  final DevStatus devStatus;

  LoadDevProjectsWithFilterEvent(
      {@required this.title,
      @required this.projectName,
      @required this.category,
      @required this.devStatus});
}

class LoadSpecificDevProject extends DevProjectsEvent {
  final String ideaID;

  LoadSpecificDevProject({@required this.ideaID});
}