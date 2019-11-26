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
      : assert(id != null),
        assert(title != null),
        assert(projectName != null),
        assert(description != null),
        assert(photoURLs != null),
        assert(category != null),
        assert(status != null),
        super(
            [id, title, projectName, description, photoURLs, category, status]);
}
