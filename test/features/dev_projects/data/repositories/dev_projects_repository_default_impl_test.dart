import 'package:dev_ideas/features/dev_projects/data/repositories/dev_projects_repository_default_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dev_ideas/features/dev_projects/data/datasources/dev_projects_local_datsource.dart';
import 'package:mockito/mockito.dart';

class MockLocalDataSource extends Mock implements DevProjectsLocalDataSource {}

void main(){
  MockLocalDataSource localDataSource;
  DevProjectsRepositoryDefaultImpl repositoryDefaultImpl;

  setUp((){
    repositoryDefaultImpl = DevProjectsRepositoryDefaultImpl(localDataSource: localDataSource);
  });
}