import 'package:dartz/dartz.dart';
import 'package:dev_ideas/core/errors/exceptions.dart';
import 'package:dev_ideas/core/errors/failures.dart';
import 'package:dev_ideas/features/dev_projects/data/models/idea_model.dart';
import 'package:dev_ideas/features/dev_projects/data/repositories/dev_projects_repository_default_impl.dart';
import 'package:dev_ideas/features/dev_projects/domain/enteties/dev_status.dart';
import 'package:dev_ideas/features/dev_projects/domain/enteties/idea.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dev_ideas/features/dev_projects/data/datasources/dev_projects_local_datsource.dart';
import 'package:mockito/mockito.dart';
import 'package:collection/collection.dart';

class MockLocalDataSource extends Mock implements DevProjectsLocalDataSource {}

void main() {
  MockLocalDataSource localDataSource;
  DevProjectsRepositoryDefaultImpl repositoryDefaultImpl;

  setUp(() {
    localDataSource = MockLocalDataSource();
    repositoryDefaultImpl =
        DevProjectsRepositoryDefaultImpl(localDataSource: localDataSource);
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

  group("getAllIdeas", () {
    test("should return a list of ideas from the local data source", () async {
      when(localDataSource.getAllIdeas())
          .thenAnswer((_) => Future.value(ideasList));

      final result = await repositoryDefaultImpl.getAllIdeas();
      expect(result, Right(ideasList));

      verify(localDataSource.getAllIdeas());
    });

    test(
        "should return a cache failure when the local data source throws an exception",
        () async {
      when(localDataSource.getAllIdeas())
          .thenThrow(CacheException(message: "some error"));

      final result = await repositoryDefaultImpl.getAllIdeas();
      expect(result, equals(Left(CacheFailure())));
      verify(localDataSource.getAllIdeas());
    });
  });

  group("addIdea", () {
    test("should add a new idea", () async {
      final tIdeaToAdd = IdeaModel(
          id: "ranid",
          title: "TestTitle",
          projectName: "",
          description: "",
          photoURLs: [],
          category: "",
          status: DevStatus.IDEA);

      when(localDataSource.getAllIdeas()).thenAnswer((_) => Future.value(ideasList));

      final result = await repositoryDefaultImpl.addIdea(tIdeaToAdd);
      
      expect(result, Right(null));
      verify(localDataSource.writeIdeas(any));
      verify(localDataSource.getAllIdeas());
    });

    test("should remove an idea", () async {
      when(localDataSource.getAllIdeas()).thenAnswer((_) => Future.value(ideasList));

      final result = await repositoryDefaultImpl.removeIdea(tIdeaFirst.id);

      expect(result, Right(null));
      verify(localDataSource.writeIdeas(ideasList..remove(tIdeaFirst)));
      verify(localDataSource.getAllIdeas());
    });

    test("should return a failure when the idea to remove doesn't exist", () async {
      when(localDataSource.getAllIdeas()).thenAnswer((_) => Future.value(ideasList..remove(tIdeaFirst)));

      final result = await repositoryDefaultImpl.removeIdea(tIdeaFirst.id);

      expect(result, Left(IdeaNotFoundFailure()));
      verify(localDataSource.getAllIdeas());
      verifyNever(localDataSource.writeIdeas(any));
    });

    test("should update a idea", () async {
      when(localDataSource.getAllIdeas()).thenAnswer((_) => Future.value(ideasList));

      final result = await repositoryDefaultImpl.updateIdea(tIdeaFirst.id, tIdeaSecond);

      expect(result, Right(null));
      verify(localDataSource.getAllIdeas());

      final expectedInsertedItem = ideasList..remove(tIdeaFirst)..insert(0, tIdeaSecond);
      final expectedListToWrite = localDataSource.writeIdeas(expectedInsertedItem);
      expect(result, Right(expectedListToWrite));
    });

    test("should return a failure when the idea to update doesn't exitst", () async {
      when(localDataSource.getAllIdeas()).thenAnswer((_) => Future.value(ideasList));

      final tIdeaId = "5463673567547";
      final result = await repositoryDefaultImpl.updateIdea(tIdeaId, tIdeaFirst);

      verify(localDataSource.getAllIdeas());
      verifyNever(localDataSource.writeIdeas(any));
      expect(result, Left(IdeaNotFoundFailure()));
    });

    test("should only add a new idea if the id of the new idea isn't forgiven", () async {
      when(localDataSource.getAllIdeas()).thenAnswer((_) => Future.value(ideasList));

      final result = await repositoryDefaultImpl.addIdea(tIdeaFirst);

      expect(result, Left(IdeaAlreadyExistsFailure()));
      verifyNever(localDataSource.writeIdeas(any));
      verify(localDataSource.getAllIdeas());
    });
  });

  test("should add an idea", () async {
    when(localDataSource.getAllIdeas()).thenAnswer((_) => Future.value(ideasList));

    final tIdea = Idea.withRandomID(title: "", projectName: "", description: "", photoURLs: [], category: "", status: DevStatus.IDEA);
    final result = await repositoryDefaultImpl.addIdea(tIdea);

    expect(result, Right(null));
    verify(localDataSource.getAllIdeas());
  });
}
