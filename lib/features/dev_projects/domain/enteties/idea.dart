import 'package:dev_ideas/features/dev_projects/domain/enteties/dev_status.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Idea extends Equatable {

  final String id;
  final String title, projectName, description, category;
  final List<String> photoURLs;
  final DevStatus status;

  Idea(
      {@required this.id,
      @required this.title,
      @required this.projectName,
      @required this.description,
      @required this.photoURLs,
      @required this.category,
      @required this.status})
      : super([id, title, projectName, description, photoURLs, category, status]);
}
