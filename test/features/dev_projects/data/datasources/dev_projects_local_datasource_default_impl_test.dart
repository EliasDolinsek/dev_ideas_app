import 'package:dev_ideas/core/errors/exceptions.dart';
import 'package:dev_ideas/core/platform/data_manager.dart';
import 'package:dev_ideas/features/dev_projects/data/datasources/dev_projects_local_datsource.dart';
import 'package:dev_ideas/features/dev_projects/data/models/idea_model.dart';
import 'package:dev_ideas/features/dev_projects/domain/enteties/dev_status.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:matcher/matcher.dart';
import 'package:collection/collection.dart';

import '../../../../fixtures/fixutres_reader.dart';

class MockDataManager extends Mock implements DataManager {}
void main(){

  MockDataManager dataManager;
  DevProjectsLocalDataSourceDefaultImpl localDataSource;

  setUp((){
    dataManager = MockDataManager();
    localDataSource = DevProjectsLocalDataSourceDefaultImpl(dataManager);
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

  group("getAllIdeas", (){
    test("should return a CacheException when there is a problem reading the file content", () async {
      when(dataManager.readContent(any)).thenThrow((_) => Exception());

      final call = localDataSource.getAllIdeas;

      expect(() => call(), throwsA(TypeMatcher<CacheException>()));
    });

    test("should return a list of ideas", () async {
      when(dataManager.readContent(any)).thenAnswer((_) => Future.value(fixture("test/fixtures/ideas_list_fixture.json")));

      final result = await localDataSource.getAllIdeas();

      expect(DeepCollectionEquality().equals(result, ideasList), true);
    });

    test("should write the new list of ideas", () async {
      localDataSource.writeIdeas(ideasList);

      final ideasAsList = IdeaModel.ideaModelsToJSON(ideasList);
      verify(dataManager.writeContent(ideasAsList.toString(), await localDataSource.localDataFile));
    });

    test("should return a empty list when the gotten content is empty", () async {
      when(dataManager.readContent(any)).thenAnswer((_) => Future.value(""));

      final result = await localDataSource.getAllIdeas();

      expect(result, <IdeaModel>[]);
    });
  });
}