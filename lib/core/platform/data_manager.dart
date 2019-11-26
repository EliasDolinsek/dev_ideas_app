import 'dart:io';

import 'package:path_provider/path_provider.dart';

abstract class DataManager {

  Future<void> writeContent(String content, String destination);
  Future<String> readContent(String source);

  Future<String> get getLocalPath async => (await getApplicationDocumentsDirectory()).path;
}

class LocalDataManager extends DataManager{
  @override
  Future<String> readContent(String file) async {
    final fileToRead = File(file);
    return fileToRead.readAsString();
  }

  @override
  Future<void> writeContent(String content, String file) async {
    final fileToWrite = File(file);
    return fileToWrite.writeAsString(content);
  }

}