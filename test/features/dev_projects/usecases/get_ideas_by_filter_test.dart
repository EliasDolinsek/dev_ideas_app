import 'package:dartz/dartz.dart';
import 'package:dev_ideas/features/dev_projects/domain/enteties/dev_status.dart';
import 'package:dev_ideas/features/dev_projects/domain/enteties/idea.dart';
import 'package:dev_ideas/features/dev_projects/domain/repositories/dev_projects_repository.dart';
import 'package:dev_ideas/features/dev_projects/domain/usecases/get_idea_by_filter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockDevProjectsRepository extends Mock implements DevProjectsRepository {}

void main(){
  GetIdeasByFilter usecase;
  MockDevProjectsRepository repository;
  
  setUp((){
    repository = MockDevProjectsRepository();
    usecase = GetIdeasByFilter(repository);
  });
  
  test("should get a list of all ideas which match the filter criteria", () async {
    final tTitle = "Test", tCategory = "Test", tDevStatus = DevStatus.IDEA;
    final expected = [Idea(id: null, title: tTitle, projectName: null, description: null, photoURLs: null, category: tCategory, status: tDevStatus)];

    when(repository.getIdeasByFilter(title: tTitle, category: tCategory, devStatus: tDevStatus)).thenAnswer((_) async => Right(expected));

    final result = await usecase(GetIdeasByFilterParams(title: tTitle, category: tCategory, devStatus: tDevStatus));

    verify(repository.getIdeasByFilter(title: tTitle, category: tCategory, devStatus: tDevStatus));
    expect(result, equals(Right(expected)));
  });
}