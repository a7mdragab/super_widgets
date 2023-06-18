import 'dart:async';
import 'dart:io';

import '../../utils/helpers.dart';

main() {
  DirManage.renameDirContents(dirPath: '');
}

class DirManage {
  static Future<List<FileSystemEntity>> renameDirContents({required String dirPath, String from = 'elshab7', String to = 'super'}) {
    var files = <FileSystemEntity>[];
    if (Platform.isWindows) {
      dirPath = dirPath.replaceAll('/', '\\');
    }
    Directory dir = Directory(dirPath);
    var completer = Completer<List<FileSystemEntity>>();
    var lister = dir.list(recursive: true);
    lister.listen((file) {
      String fullPath = file.path;
      // String newName=fullPath.replaceAll('super', 'super');
      String extension = fullPath.split('.').last;
      String withoutExtension = fullPath.replaceAll('.$extension', '');
      String fileName = withoutExtension.split('\\').last;
      fileName = '$fileName.$extension';
      mPrint('exporting \'$fileName\';');
      if (fileName.contains(from) && fileName.length < 100) {
        String newName = fileName.replaceAll(from, to);
        String newFullPath = fullPath.replaceAll(fileName, newName);
        file.rename(newFullPath);
      }
    },
        // (file) => files.add(file),
        // should also register onError
        onDone: () => completer.complete(files));
    return completer.future;
  }
}
