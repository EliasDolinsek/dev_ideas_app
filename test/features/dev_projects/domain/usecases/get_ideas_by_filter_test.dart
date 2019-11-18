import 'package:dartz/dartz.dart';
import 'package:dev_ideas/features/dev_projects/domain/enteties/dev_status.dart';
import 'package:dev_ideas/features/dev_projects/domain/enteties/idea.dart';
import 'package:dev_ideas/features/dev_projects/domain/repositories/dev_projects_repository.dart';
import 'package:dev_ideas/features/dev_projects/domain/usecases/get_idea_by_filter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockDevProjectsRepository extends Mock implements DevProjectsRepository {}

void main() {
  GetIdeasByFilter usecase;
  MockDevProjectsRepository repository;

  setUp(() {
    repository = MockDevProjectsRepository();
    usecase = GetIdeasByFilter(repository);
  });

  final tIdeaFirst = Idea(
      id: "123",
      title: "Test",
      projectName: "Test1",
      description: "",
      photoURLs: [],
      category: "Category1",
      status: DevStatus.FINISHED);

  final tIdeaSecond = Idea(
      id: "234",
      title: "Test1",
      projectName: "Test2",
      description: "",
      photoURLs: [],
      category: "Category2",
      status: DevStatus.DEVELOPMENT);

  final tIdeaThird = Idea(
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

  test("should get a list of all ideas which contain the filtered title",
      () async {
    when(repository.getAllIdeas()).thenAnswer((_) async => Right(ideasList));

    final tFilter = GetIdeasByFilterParams(title: "Test", projectName: null, category: null, devStatus: null);
    final result = await usecase(tFilter);

    expect(result, Right(ideasList));
    verify(usecase(tFilter));
  });
}
