import 'package:dartz/dartz.dart';
import 'package:dev_ideas/features/dev_projects/domain/enteties/idea.dart';
import 'package:dev_ideas/features/dev_projects/domain/repositories/dev_projects_repository.dart';
import 'package:dev_ideas/features/dev_projects/domain/usecases/update_idea.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockDevProjectsRepository extends Mock implements DevProjectsRepository {}

void main(){

  MockDevProjectsRepository repository;
  UpdateIdea usecase;
  
  setUp((){
    repository = MockDevProjectsRepository();
    usecase = UpdateIdea(repository);
  });
  
  test("should call the repository to update an idea", () async {
    final tUpdateID = "123";
    final tUpdate = Idea(id: tUpdateID, title: "", projectName: "", description: "", photoURLs: [], category: "", status: DevStatus.IDEA);
    when(repository.updateIdea(any, any)).thenAnswer((_) => Future.value(Right(null)));
    
    final result = await usecase(UpdateIdeaParams(ideaID: "123", update: tUpdate));

    verify(repository.updateIdea(tUpdateID, tUpdate));
    expect(result, Right(null));
  });
  
}