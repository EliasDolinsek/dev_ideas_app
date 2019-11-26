import 'package:dartz/dartz.dart';
import 'package:dev_ideas/core/usecases/usecase.dart';
import 'package:dev_ideas/features/dev_projects/domain/enteties/idea.dart';
import 'package:dev_ideas/features/dev_projects/domain/repositories/dev_projects_repository.dart';
import 'package:dev_ideas/features/dev_projects/domain/usecases/get_all_ideas.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockDevProjectsRepository extends Mock implements DevProjectsRepository {}

void main() {
  GetAllIdeas usecase;
  MockDevProjectsRepository repository;

  setUp(() {
    repository = MockDevProjectsRepository();
    usecase = GetAllIdeas(repository);
  });

  test("should return a list of all ideas", () async {
    final List<Idea> ideas = [
      Idea(
          id: null,
          title: null,
          projectName: null,
          description: null,
          photoURLs: null,
          category: null,
          status: null),
      Idea(
          id: null,
          title: null,
          projectName: null,
          description: null,
          photoURLs: null,
          category: null,
          status: null)
    ];

    when(repository.getAllIdeas()).thenAnswer((_) async => Right(ideas));

    final result = await usecase(NoParams());
    expect(result, Right(ideas));
  });
}
