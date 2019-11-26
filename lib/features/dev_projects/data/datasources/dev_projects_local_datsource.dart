import 'dart:convert';

import 'package:dev_ideas/core/errors/exceptions.dart';
import 'package:dev_ideas/core/platform/data_manager.dart';
import 'package:dev_ideas/features/dev_projects/data/models/idea_model.dart';
import 'package:dev_ideas/features/dev_projects/domain/enteties/idea.dart';

import '../../../../core/config/config.dart' as config;
abstract class DevProjectsLocalDataSource {

  Future<List<IdeaModel>> getAllIdeas();

  Future<void> writeIdeas(List<Idea> ideas);
}

class DevProjectsLocalDataSourceDefaultImpl extends DevProjectsLocalDataSource {

  final DataManager dataManager;

  DevProjectsLocalDataSourceDefaultImpl(this.dataManager);

  @override
  Future<List<IdeaModel>> getAllIdeas() async {
    try {
      final content = await dataManager.readContent(config.DATA_FILE_NAME);
      final jsonMap = json.decode(content);
      return IdeaModel.ideaModelsFromJSON(jsonMap);
    } on Exception {
      throw new CacheException(message: "Error when loading data from file");
    }
  }

  @override
  Future<void> writeIdeas(List<Idea> ideas) {
    final String ideasAsString = IdeaModel.ideaModelsToJSON(ideas).toString();
    dataManager.writeContent(ideasAsString, config.DATA_FILE_NAME);
    return null;
  }

}