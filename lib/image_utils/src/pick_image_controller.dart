import 'dart:async';
// import 'package:universal_html/html.dart';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:file_picker_cross/file_picker_cross.dart';
import 'package:image_picker/image_picker.dart';
import 'package:super_widgets/image_utils/src/super_image_class.dart';
import 'package:super_widgets/super_widgets.dart';


class PickImageController {
  static PickImageController get instance => PickImageController();

  Future<String> pickDirectory({String dialogTitle='Pick a directory',bool lockParentWindow=true,String? initialDirectory}) async {
    try {
      return await FilePicker.platform.getDirectoryPath(dialogTitle: dialogTitle,lockParentWindow: lockParentWindow,initialDirectory: initialDirectory)??'';
    } on Exception catch (e) {
      mPrintError('pickDirectory Exception $e');
      return '';
    }
  }
  Future<FilePickerCross?> cropImageFromFileWeb(SuperImageClass imageClass, {String? barTitle}) async {
    // show a dialog to open a file
    FilePickerCross? myFile = await FilePickerCross.importFromStorage(
            type: FileTypeCross.any, // Available: `any`, `audio`, `image`, `video`, `custom`. Note: not available using FDE
            fileExtension: 'png, jpg, jpeg' // Only if FileTypeCross.custom. May be any file extension like `dot`, `ppt,pptx,odp`
            )
        .catchError((onError, _) {
      print('Error FilePickerCross');
    });

    if (myFile != null) {
      // mShowLoading();
      // print('Img len before = ${myFile.toUint8List().length}');
      // Uint8List img = (await ImgUtils.compressImage(myFile.toUint8List()))!;
      // print('Img len after = ${img.length}');
      // mHide();
      // CompressObject compressObject = CompressObject(
      //   imageFile: imageFile, //image
      //   quality: 50, //first compress quality, default 80
      //   step:
      //       9, //compress quality step, The bigger the fast, Smaller is more accurate, default 6
      //   mode: CompressMode.LARGE2SMALL, //default AUTO
      // );
      // Luban.compressImage(compressObject).then((_path) {
      //   print(_path);
      // });

      imageClass.setImgList(myFile.toUint8List());
      return myFile;
    }
    return null;

    // html.File imageFile =
    //     await ImagePickerWeb.getImage(outputType: ImageType.file);

    // print('imageFile path = ${imageFile.relativePath}');
    // imageClass.setFile(imageFile);

    // File croppedFile = (await ImageCropper.cropImage(
    //     sourcePath: imageFile.relativePath!,
    //     compressQuality: 75,
    //     aspectRatioPresets: [
    //       CropAspectRatioPreset.square,
    //       CropAspectRatioPreset.ratio3x2,
    //       CropAspectRatioPreset.original,
    //       CropAspectRatioPreset.ratio4x3,
    //       CropAspectRatioPreset.ratio16x9,
    //     ],
    //     androidUiSettings: AndroidUiSettings(
    //         toolbarTitle: barTitle,
    //         toolbarColor: Get.theme.primaryColor,
    //         toolbarWidgetColor: Colors.white,
    //         initAspectRatio: CropAspectRatioPreset.original,
    //         lockAspectRatio: false),
    //     iosUiSettings: IOSUiSettings(
    //       title: barTitle,
    //       minimumAspectRatio: 1.0,
    //     )))!;

    // Uint8List plainImageList = imageFile.readAsBytesSync();
    // return Uint8List.fromList(plainImageList);
  }

  Future<File?> cropImageFromFile(SuperImageClass imageClass, {String? barTitle}) async {
    // show a dialog to open a file
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      dialogTitle: barTitle,
      withData: true,
      type: FileType.image,
      // allowedExtensions: ['png', 'jpg', 'jpeg'],
    );
    File? file;

    if (result?.files.single != null) {
      file = File(result!.files.single.path!);
    } else {
      // User canceled the picker
      mPrint('User canceled the picker');
    }

    if (file != null) {
      if (result!.files.single.bytes != null) {
        imageClass.setImgList(result.files.single.bytes!);
      }
      return file;
    }
    return null;
  }

  Future<File?> cropImageFromFile2(
    SuperImageClass imageClass, {
    ImageSource imageSource = ImageSource.gallery,
  }) async {
    final ImagePicker picker = ImagePicker();

    final XFile? image = await picker.pickImage(source: imageSource);
    File? file;

    if (image != null) {
      file = File(image.path);
      imageClass.setImgList(await file.readAsBytes());
    } else {
      // User canceled the picker
      mPrintError('User canceled the picker');
    }

    return file;
  }
}
