import 'dart:io';

String fixture(String filename) {
  return File(filename).readAsStringSync();
}
