import 'package:dartz/dartz.dart';
import 'package:dev_ideas/features/dev_projects/domain/enteties/idea.dart';
import 'package:dev_ideas/features/dev_projects/domain/repositories/dev_projects_repository.dart';
import 'package:dev_ideas/features/dev_projects/domain/usecases/add_idea.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockDevProjectsRepository extends Mock implements DevProjectsRepository {}

void main(){
  
  MockDevProjectsRepository repository;
  AddIdea usecase;

  setUp(() {
    repository = MockDevProjectsRepository();
    usecase = AddIdea(repository);
  });

  final tIdea = Idea(
    id: "345",
    status: DevStatus.IDEA,
    description: "",
    projectName: "",
    title: "",
    category: "",
    photoURLs: []
  );

  test("should add a idea", () async {
    when(repository.addIdea(any)).thenAnswer((_) => Future.value(Right(null)));
    final result = await usecase(AddIdeaParams(idea: tIdea));

    expect(result, Right(null));
    verify(repository.addIdea(tIdea));
  });
}