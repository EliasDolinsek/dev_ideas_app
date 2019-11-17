import 'package:dev_ideas/features/dev_projects/domain/enteties/idea.dart';

abstract class DevProjectsLocalDataSource {

  Future<List<Idea>> getAllIdeas();

  Future<void> writeIdeas(List<Idea> ideas);
}