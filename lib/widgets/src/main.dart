import 'dart:async';
import 'dart:io';

main() {
  Directory dir = Directory('E:\\elshab7\\Work\\Flutter_Work\\MyPackages\\super_widgets\\lib\\image_utils');
  renameContents(dir);
}

Future<List<FileSystemEntity>> renameContents(Directory dir) {
  var files = <FileSystemEntity>[];
  var completer = Completer<List<FileSystemEntity>>();
  var lister = dir.list(recursive: true);
  lister.listen((file) {
    String fullPath = file.path;
    // String newName=fullPath.replaceAll('super', 'super');
    String extension = fullPath.split('.').last;
    String withoutExtension = fullPath.replaceAll('.$extension', '');
    String fileName = withoutExtension.split('\\').last;
    fileName = '$fileName.$extension';
    print('export \'$fileName\';');
    if (fileName.contains('elshab7')&&fileName.length<100) {
      String newName = fileName.replaceAll('elshab7', 'super');
      String newFullPath = fullPath.replaceAll(fileName, newName);
      file.rename(newFullPath);
    }
  },
      // (file) => files.add(file),
      // should also register onError
      onDone: () => completer.complete(files));
  return completer.future;
}
