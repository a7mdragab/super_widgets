import 'package:dart_extensions/dart_extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:time/time.dart';
import 'package:list_ext/list_ext.dart';
import '../../utils/constants.dart';
import '../../utils/helpers.dart';
import '../../widgets/src/super_decorated_container.dart';
import '../../widgets/src/txt.dart';
import 'pick_image_controller.dart';
import 'super_image_class.dart';
import 'super_imageview.dart';

// ignore: must_be_immutable
class SuperImagePickView extends StatefulWidget {
  final SuperImageClass imageClass;

  final String pickLabel;

  final bool enableChange;
  final BoxShape shape;
  final double? width, height;
  final Function? onChanged, dismissFunction;

  const SuperImagePickView(this.imageClass,
      {super.key, this.width = 200, this.height = 150, this.shape = BoxShape.rectangle, this.pickLabel = 'Pick Photo', this.enableChange = true, this.onChanged, this.dismissFunction});

  @override
  SuperImagePickViewState createState() => SuperImagePickViewState();
}

class SuperImagePickViewState extends State<SuperImagePickView> {
  // late double mSize;
  int firstPage = 1;
  DateTime lastUpTime = DateTime.now().copyWith(year: 1990);

  @override
  void initState() {
    // mSize = Get.width * widget.widthRatio;
    // mPrint("1 ${widget.imageClass.imgList}");
    // mPrint("2 ${!widget.imageClass.imgString.isNullOrWhiteSpace && widget.imageClass.imgString!.contains(appUploadCenter)}");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // return Container();
    // printInfo(info: 'imgString View: ' + widget.imageClass.imgString!);
    return SuperDecoratedContainer(
      // width: mSize * 1,
      // height: mSize * 1,
      borderColor: Colors.grey[300],
      borderRadius: 16,
      color: Colors.transparent,
      shape: BoxShape.rectangle,
      child: widget.imageClass.imgList.isNullOrEmpty
          ? InkWell(
              onTap: widget.enableChange
                  ? () async {
                      mPrint('Picking image');
                      var src = await showImagePickerDialog();
                      if (src != null) {
                        await PickImageController.instance
                            .cropImageFromFile2(
                          widget.imageClass,
                          imageSource: src,
                        )
                            .then((x) {
                          if (x != null) {
                            mPrint('Image is picked');
                            widget.onChanged?.call();
                            setState(() {});
                          }
                        });
                      }
                    }
                  : null,
              child: !widget.imageClass.imgString.isNullOrWhiteSpace && widget.imageClass.imgString!.contains(appUploadCenter)
                  ? Stack(
                      children: [
                        SuperDecoratedContainer(
                          // width: mSize,
                          // height: mSize,
                          borderRadius: 16,
                          color: Colors.white,
                          shape: widget.shape,
                          width: widget.width,
                          height: widget.height,

                          child: SuperImageView(
                            imgUrl: widget.imageClass.imgString!,
                            fit: BoxFit.fill,
                            shape: widget.shape,
                            // width: mSize,
                            // height: mSize,
                          ),
                        ),
                        clearBtn(),
                      ],
                    )
                  : Stack(
                      children: [
                        Center(
                          child: SuperImageView(
                            icon: Icon(
                              Icons.image,
                              color: Colors.grey[400]!.withOpacity(0.7),
                              size: widget.height ?? widget.width,
                            ),
                            width: widget.width,
                            height: widget.height,
                            borderRadius: 16,
                            color: Colors.white,
                            fit: BoxFit.fill,
                            shape: widget.shape,
                            // width: mSize,
                            // height: mSize,
                          ),
                        ),
                        Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: EdgeInsets.only(top: (widget.height ?? 40) * 0.5),
                              child: Txt(
                                widget.pickLabel,
                                color: context.theme.primaryColor,
                              ),
                            ))
                      ],
                    ),
            )
          : Stack(
              // fit: StackFit.loose,
              children: [
                SuperImageView(
                  uint8list: widget.imageClass.imgList!,
                  shape: widget.shape,
                  borderRadius: 16,
                  width: widget.width,
                  height: widget.height,
                  // width: mSize,
                  // height: mSize,
                  fit: BoxFit.fill,
                ),
                clearBtn(),
              ],
            ),
    );
  }

  clearBtn() {
    // return DecoratedContainer(
    //   color: Colors.black54,
    //   shape: BoxShape.rectangle,
    //   borderRadius: 16,
    //   width: mSize,
    //   child: TextButton.icon(
    //     label: const Txt('Clear', color: Colors.white),
    //     icon: const Icon(Icons.close, color: Colors.white),
    //     onPressed: widget.dismissFunction != null
    //         ? widget.dismissFunction!()
    //         : () {
    //             setState(() {
    //               widget.imageClass.clean();
    //               widget.onChanged?.call();
    //             });
    //           },
    //   ),
    // );
    return Positioned(
      top: 0,
      left: 0,
      // alignment: Alignment.topLeft,
      child: SuperImageView(
        color: Colors.black54,
        shape: widget.shape,
        icon: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: widget.dismissFunction != null
              ? widget.dismissFunction!()
              : () {
                  setState(() {
                    widget.imageClass.clean();
                    widget.onChanged?.call();
                  });
                },
        ),
      ),
    );
  }
}
