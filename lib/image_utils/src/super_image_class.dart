import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker_cross/file_picker_cross.dart';
import 'package:list_ext/list_ext.dart';
import 'package:ready_extensions/ready_extensions.dart';

import '../../utils/constants.dart';

class FileModel {
  String title = '';
  String link = '';
  SuperImageClass file = SuperImageClass();

  FileModel(this.title, this.link);

  FileModel.fromFileClass(this.file) {
    title = file.fileTitle;
    link = file.imgString ?? '';
  }

  FileModel.fromMap(Map<String, dynamic> o) {
    title = o['title'] ?? 'File';
    link = o['link'] ?? 'link';
  }

  static List<FileModel> fromMapList(List<dynamic> data, {bool setDefaultValues = false}) {
    final List<FileModel> objList = <FileModel>[];
    for (final map in data) {
      final obj = FileModel.fromMap(map as Map<String, dynamic>);
      objList.add(obj);
    }
    return objList;
  }

  Map<String, dynamic> toMap() => {'title': title, 'link': link};
}

class SuperImageClass {
  Uint8List? imgList;
  String? imgString;
  String? tempName;
  FilePickerCross? filePickerCross;
  File? file;
  bool uploaded = false;
  bool changed = false;

  SuperImageClass() {
    clean();
  }

  SuperImageClass.fromPickerCrossFile(this.filePickerCross) {
    imgList = filePickerCross!.toUint8List();
    imgString = filePickerCross!.toBase64();
  }

  SuperImageClass.fromFile(this.file) {
    imgList = file!.readAsBytesSync();
    if (imgList.isNotNullOrEmpty) imgString = base64Encode(imgList!);
  }

  SuperImageClass.fromBytes(this.imgList) {
    imgString = null;
    if (imgList != null) imgString = base64Encode(imgList!);
  }

  SuperImageClass.fromString(this.imgString) {
    setImgString(imgString);
  }

  FileModel? get generateFileModel {
    if (filePickerCross != null) {
      return FileModel(fileTitle, imgString ?? '');
    }
    return null;
  }

  bool get isServerUploaded => !imgString.isNullOrEmptyOrWhiteSpace && imgString!.contains(appUploadCenter);

  String get fileTitle {
    if (filePickerCross?.fileName != null) {
      return filePickerCross!.fileName!;
    } else if (isServerUploaded) {
      return imgString!;
    }
    return 'File';
  }

  setFile(File fil) {
    file = fil;
    imgList = file!.readAsBytesSync();
    if (imgList.isNotNullOrEmpty) imgString = base64Encode(imgList!);
    changed = true;
  }

  setFilePickerCross(FilePickerCross fil) {
    filePickerCross = fil;
    imgList = filePickerCross!.toUint8List();
    imgString = filePickerCross!.toBase64();
    changed = true;
  }

  setImgList(Uint8List list) {
    imgList = list;
    imgString = const Base64Encoder().convert(imgList!);

    if (!imgString.isNullOrEmptyOrWhiteSpace && !imgString!.contains(appUploadCenter) && imgString!.length > 200) {
      changed = true;
    }
  }

  setImgString(String? str) {
    imgString = str;

    if (!imgString.isNullOrEmptyOrWhiteSpace && !imgString!.contains(appUploadCenter) && imgString!.length > 200) {
      imgList = base64Decode(imgString!);
      changed = true;
    }
  }

  void clean() {
    imgString = null;
    imgList = null;
    file = null;
    filePickerCross = null;
    tempName = null;
    uploaded = false;
    changed = false;
  }

  bool get hasFile => filePickerCross != null;
}
