import 'dart:convert';
import 'dart:io';

import 'package:dev_ideas/core/errors/exceptions.dart';
import 'package:dev_ideas/core/platform/data_manager.dart';
import 'package:dev_ideas/features/dev_projects/data/models/idea_model.dart';
import 'package:dev_ideas/features/dev_projects/domain/enteties/idea.dart';
import 'package:path_provider/path_provider.dart';

abstract class DevProjectsLocalDataSource {

  Future<List<IdeaModel>> getAllIdeas();

  Future<void> writeIdeas(List<IdeaModel> ideas);
}

class DevProjectsLocalDataSourceDefaultImpl extends DevProjectsLocalDataSource {

  static const String DATA_LOADING_ERROR_MESSAGE = "Error when loading data from file";

  final DataManager dataManager;

  DevProjectsLocalDataSourceDefaultImpl(this.dataManager);

  @override
  Future<List<IdeaModel>> getAllIdeas() async {
    try {
      final content = await dataManager.readContent(await localDataFile);
      if (content.isEmpty){
        return <IdeaModel>[];
      } else {
        final jsonMap = json.decode(content);
        return IdeaModel.ideaModelsFromJSON(jsonMap);
      }
    } on Exception {
      throw new CacheException(message: DATA_LOADING_ERROR_MESSAGE);
    }
  }

  @override
  Future<void> writeIdeas(List<IdeaModel> ideas) async {
    final ideasAsMap = IdeaModel.ideaModelsToMap(ideas);
    final jsonContent = jsonEncode(ideasAsMap);
    await dataManager.writeContent(jsonContent, await localDataFile);
    return null;
  }

  Future<File> get localDataFile async => File("${(await getApplicationDocumentsDirectory()).path}/data.json");
}