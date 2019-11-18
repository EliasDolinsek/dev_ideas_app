import 'package:dartz/dartz.dart';
import 'package:dev_ideas/features/core/errors/exceptions.dart';
import 'package:dev_ideas/features/core/errors/failures.dart';
import 'package:dev_ideas/features/dev_projects/data/models/idea_model.dart';
import 'package:dev_ideas/features/dev_projects/data/repositories/dev_projects_repository_default_impl.dart';
import 'package:dev_ideas/features/dev_projects/domain/enteties/dev_status.dart';
import 'package:dev_ideas/features/dev_projects/domain/enteties/idea.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dev_ideas/features/dev_projects/data/datasources/dev_projects_local_datsource.dart';
import 'package:mockito/mockito.dart';

class MockLocalDataSource extends Mock implements DevProjectsLocalDataSource {}

void main(){
  MockLocalDataSource localDataSource;
  DevProjectsRepositoryDefaultImpl repositoryDefaultImpl;

  setUp((){
    localDataSource = MockLocalDataSource();
    repositoryDefaultImpl = DevProjectsRepositoryDefaultImpl(localDataSource: localDataSource);
  });

  final tIdeaFirst = IdeaModel(
      id: "123",
      title: "Test",
      projectName: "Test1",
      description: "",
      photoURLs: [],
      category: "Category1",
      status: DevStatus.FINISHED);

  final tIdeaSecond = IdeaModel(
      id: "234",
      title: "Test1",
      projectName: "Test2",
      description: "",
      photoURLs: [],
      category: "Category2",
      status: DevStatus.DEVELOPMENT);

  final tIdeaThird = IdeaModel(
      id: "345",
      title: "Test2",
      projectName: "Test3",
      description: "",
      photoURLs: [],
      category: "Category3",
      status: DevStatus.IDEA);

  final ideasList = ([
    tIdeaFirst,
    tIdeaSecond,
    tIdeaThird,
  ]);

  test("should return a list of ideas from the local data source", () async {
    when(localDataSource.getAllIdeas()).thenAnswer((_) => Future.value(ideasList));

    final result = await repositoryDefaultImpl.getAllIdeas();
    expect(result, Right(ideasList));

    verify(localDataSource.getAllIdeas());
  });

  test("should return a cache failure when the local data source throws an exception", () async {
    when(localDataSource.getAllIdeas()).thenThrow(CacheException(message: "some error"));

    final result = await repositoryDefaultImpl.getAllIdeas();
    expect(result, equals(Left(CacheFailure())));
    verify(localDataSource.getAllIdeas());
  });
}