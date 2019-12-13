import 'package:dev_ideas/features/dev_projects/domain/enteties/dev_status.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

export 'dev_status.dart';

class Idea extends Equatable {
  final String id;
  String title, description;
  DevStatus status;

  Idea(
      {@required this.id,
      @required this.title,
      @required this.description,
      @required this.status})
      : assert(id != null),
        assert(title != null),
        assert(description != null),
        assert(status != null),
        super(
            [id, title, description, status]);

  factory Idea.withRandomID(
          {@required String title,
          @required String description,
          @required String category,
          @required DevStatus status}) =>
      Idea(
          id: Uuid().v4(),
          title: title,
          description: description,
          status: status);
}
