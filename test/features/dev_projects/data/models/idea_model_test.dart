import 'package:dev_ideas/features/dev_projects/data/models/idea_model.dart';
import 'package:dev_ideas/features/dev_projects/domain/enteties/dev_status.dart';
import 'package:dev_ideas/features/dev_projects/domain/enteties/idea.dart';
import 'package:flutter_test/flutter_test.dart';
import 'dart:convert';
import 'package:collection/collection.dart';
import '../../../../fixtures/fixutres_reader.dart' as fixturesReader;

void main() {
  final tIdeaModel = IdeaModel(
    id: "123",
    title: "Test",
    projectName: "Name",
    category: "Category",
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
      "devStatus": 0,
      "category":"Category"
    };

    expect(result, equals(expectedMap));
  });

  final tIdeaFirst = IdeaModel(
      id: "123",
      title: "Test",
      projectName: "Name",
      description: "Description",
      photoURLs: [
        "test.com",
        "test1.com"
      ],
      category: "Category1",
      status: DevStatus.IDEA);

  final tIdeaSecond = IdeaModel(
      id: "234",
      title: "Test",
      projectName: "Name",
      description: "Description",
      photoURLs: [
        "test.com",
        "test1.com"
      ],
      category: "Category2",
      status: DevStatus.IDEA);

  final tIdeaThird = IdeaModel(
      id: "345",
      title: "Test",
      projectName: "Name",
      description: "Description",
      photoURLs: [
        "test.com",
        "test1.com"
      ],
      category: "Category3",
      status: DevStatus.IDEA);

  final ideasList = ([
    tIdeaFirst,
    tIdeaSecond,
    tIdeaThird,
  ]);

  test("should return a valid list of ideas from json", (){
    final jsonMap = json.decode(fixturesReader.fixture("test/fixtures/ideas_list_fixture.json"));

    final result = IdeaModel.ideaModelsFromJSON(jsonMap);

    expect(result.length, 3);
    expect(DeepCollectionEquality().equals(result, ideasList), true);
  });

  test("should return a valid json map of a ideas list", () async {
    final result = IdeaModel.ideaModelsToMap(ideasList);
    expect(result, json.decode(fixturesReader.fixture("test/fixtures/ideas_list_fixture.json")));
  });
}
