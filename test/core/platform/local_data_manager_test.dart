import 'dart:io';

import 'package:dev_ideas/core/platform/data_manager.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:path_provider/path_provider.dart';

class MockFile extends Mock implements File {}

void main(){
  LocalDataManager localDataManager;

  setUp(() async {
    localDataManager = LocalDataManager();

    final tempDir = await Directory.systemTemp.createTemp();
    const MethodChannel("plugins.flutter.io/path_provider").setMockMethodCallHandler((MethodCall call) async {
      if(call.method == "getApplicationDocumentsDirectory") {
        return tempDir.path;
      } else {
        return null;
      }
    });
  });

  test("should return a valid path where data can be written to", () async {
    expect(await localDataManager.getLocalPath, equals((await getApplicationDocumentsDirectory()).path));
  });

  test("should return the content of a file", () async {
    final file = File("test/fixtures/random_text_fixture.txt");
    final contentInFile = file.readAsStringSync();

    final result = await localDataManager.readContent(file.path);

    expect(result, contentInFile);
  });

  test("should write something to a file", () async {
    final file = File("test/fixtures/random_text_fixture.txt");
    final content = DateTime.now().millisecondsSinceEpoch.toString();

    await localDataManager.writeContent(content, file.path);

    final contentInFile = file.readAsStringSync();
    expect(contentInFile, equals(content));
  });
}