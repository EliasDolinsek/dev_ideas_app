import 'package:dartz/dartz.dart';
import 'package:dev_ideas/features/dev_projects/domain/enteties/idea.dart';
import 'package:dev_ideas/features/dev_projects/domain/usecases/get_specific_idea.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dev_ideas/features/dev_projects/domain/repositories/dev_projects_repository.dart';
import 'package:mockito/mockito.dart';

class MockDevProjectsRepository extends Mock implements DevProjectsRepository {}

void main(){

  GetSpecificIdea usecase;
  MockDevProjectsRepository repository;

  setUp((){
    repository = MockDevProjectsRepository();
    usecase = GetSpecificIdea(repository);
  });

  test("should return the idea with the same id", () async {
    final tId = "123";
    final idea = Idea(id: tId, title: null, projectName: null, description: null, photoURLs: null, category: null, status: null);

    when(repository.getSpecificIdea(tId)).thenAnswer((_) async => Right(idea));

    final result = await usecase(tId);
    expect(result, Right(idea));
  });
}