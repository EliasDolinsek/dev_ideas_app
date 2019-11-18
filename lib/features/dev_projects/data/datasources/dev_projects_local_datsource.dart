import 'package:dev_ideas/features/dev_projects/data/models/idea_model.dart';
import 'package:dev_ideas/features/dev_projects/domain/enteties/idea.dart';

abstract class DevProjectsLocalDataSource {

  Future<List<IdeaModel>> getAllIdeas();

  Future<void> writeIdeas(List<Idea> ideas);
}