import 'package:dartz/dartz.dart';
import 'package:dev_ideas/features/dev_projects/domain/repositories/dev_projects_repository.dart';
import 'package:dev_ideas/features/dev_projects/domain/usecases/remove_idea.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockDevProjectsRepository extends Mock implements DevProjectsRepository {}

void main(){

  MockDevProjectsRepository repository;
  RemoveIdea usecase;

  setUp((){
    repository = MockDevProjectsRepository();
    usecase = RemoveIdea(repository);
  });

  test("should call the repository to remove the required id", () async {
    final String tIdeaID = "123";
    when(repository.removeIdea(tIdeaID)).thenAnswer((_) => Future.value(Right(null)));

    final result = await usecase(RemoveIdeaParams(ideaID: tIdeaID));

    verify(repository.removeIdea(tIdeaID));
    expect(result, Right(null));
  });
}