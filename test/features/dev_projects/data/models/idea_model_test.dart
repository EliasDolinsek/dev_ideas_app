import 'package:dev_ideas/features/dev_projects/data/models/idea_model.dart';
import 'package:dev_ideas/features/dev_projects/domain/enteties/dev_status.dart';
import 'package:dev_ideas/features/dev_projects/domain/enteties/idea.dart';
import 'package:flutter_test/flutter_test.dart';
import 'dart:convert';
import '../../../../fixtures/fixutres_reader.dart' as fixturesReader;

void main() {
  final tIdeaModel = IdeaModel(
    id: "123",
    title: "Test",
    projectName: "Name",
    description: "Description",
    photoURLs: ["test.com", "test1.com"],
    status: DevStatus.IDEA
  );

  test("should be a subclass of test", () async {
    expect(tIdeaModel, isA<Idea>());
  });

  test("should return a idea model from json", () async {
    final map =
        json.decode(fixturesReader.fixture("test/fixtures/idea_fixture.json"));
    final model = IdeaModel.fromJSON(map);
    expect(model, tIdeaModel);
  });

  test("should return a valid map from a model", (){
    final result = tIdeaModel.toJSON();
    final expectedMap = {
      "id": "123",
      "title": "Test",
      "projectName": "Name",
      "description": "Description",
      "photoURLs": ["test.com", "test1.com"],
      "devStatus": 0
    };

    expect(result, equals(expectedMap));
  });
}
