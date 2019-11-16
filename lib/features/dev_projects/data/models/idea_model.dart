import 'package:dev_ideas/features/dev_projects/domain/enteties/dev_status.dart';
import 'package:dev_ideas/features/dev_projects/domain/enteties/idea.dart';
import 'package:meta/meta.dart';

class IdeaModel extends Idea {
  IdeaModel({@required String id,
    @required String title,
    @required String projectName,
    @required String description,
    @required List<String> photoURLs,
    @required String category,
    @required DevStatus status})
      : super(
      id: id,
      title: title,
      projectName: projectName,
      description: description,
      photoURLs: photoURLs,
      category: category,
      status: status);

  factory IdeaModel.fromJSON(Map<String, dynamic> json) {
    return IdeaModel(
        id: json["id"],
        title: json["title"],
        projectName: json["projectName"],
        description: json["description"],
        photoURLs: json["photoURLs"].cast<String>(),
        category: json["category"],
        status: DevStatusHelper.fromValue(json["devStatus"]));
  }

  Map<String, dynamic> toJSON() {
    return <String, dynamic>{
      "id": id,
      "title": title,
      "projectName": projectName,
      "description": description,
      "photoURLs": photoURLs,
      "devStatus": DevStatusHelper.value(status)
    };
  }
}
