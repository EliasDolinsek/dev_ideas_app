import 'dart:io';

import 'package:path_provider/path_provider.dart';

abstract class DataManager {

  Future<void> writeContent(String content, File destination);
  Future<String> readContent(File source);

  Future<String> get getLocalPath async => (await getApplicationDocumentsDirectory()).path;
}

class LocalDataManager extends DataManager{
  @override
  Future<String> readContent(File file) async {
    if(!file.existsSync()) file.createSync();
    return file.readAsString();
  }

  @override
  Future<void> writeContent(String content, File file) async {
    if(!file.existsSync()) file.createSync();
    return file.writeAsString(content);
  }

}