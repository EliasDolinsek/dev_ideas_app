import 'package:dev_ideas/features/dev_projects/domain/enteties/dev_status.dart';
import 'package:dev_ideas/features/dev_projects/domain/enteties/idea.dart';
import 'package:meta/meta.dart';

class IdeaModel extends Idea {

  IdeaModel(
      {@required String id,
      @required String title,
      @required String description,
      @required DevStatus status})
      : super(
            id: id,
            title: title,
            description: description,
            status: status);

  factory IdeaModel.fromIdea(Idea idea){
    return IdeaModel(
      id: idea.id,
      title: idea.title,
      description: idea.description,
      status: idea.status
    );
  }

  factory IdeaModel.fromJSON(Map<String, dynamic> json) {
    return IdeaModel(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        status: DevStatusHelper.fromValue(json["devStatus"]));
  }

  Map<String, dynamic> toJSON() {
    return <String, dynamic>{
      "id": id,
      "title": title,
      "description": description,
      "devStatus": DevStatusHelper.value(status)
    };
  }

  static List<IdeaModel> ideaModelsFromJSON(Map<String, dynamic> json){
    final List ideasList = json["ideas"];
    return ideasList.map((ideaJson) => IdeaModel.fromJSON(ideaJson)).toList();
  }

  static Map<String, dynamic> ideaModelsToMap(List<IdeaModel> models){
    final Map<String, dynamic> map = {};
    List<Map<String, dynamic>> modelsAsList = models.map((m) => m.toJSON()).toList();
    map["ideas"] = modelsAsList;
    return map;
  }
}
