import 'dart:convert';
import 'dart:io';

import 'package:dev_ideas/core/errors/exceptions.dart';
import 'package:dev_ideas/core/platform/data_manager.dart';
import 'package:dev_ideas/features/dev_projects/data/models/idea_model.dart';
import 'package:dev_ideas/features/dev_projects/domain/enteties/idea.dart';
import 'package:path_provider/path_provider.dart';

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
      final content = await dataManager.readContent(await localDataFile);
      if (content.isEmpty){
        return [];
      } else {
        final jsonMap = json.decode(content);
        return IdeaModel.ideaModelsFromJSON(jsonMap);
      }
    } on Exception {
      throw new CacheException(message: "Error when loading data from file");
    }
  }

  @override
  Future<void> writeIdeas(List<Idea> ideas) async {
    final String ideasAsString = IdeaModel.ideaModelsToJSON(ideas).toString();
    dataManager.writeContent(ideasAsString, await localDataFile);
    return null;
  }

  Future<File> get localDataFile async => File("${(await getApplicationDocumentsDirectory()).path}/data.json");
}