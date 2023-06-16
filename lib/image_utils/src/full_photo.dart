import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:super_widgets/widgets/src/super_decorated_container.dart';
import 'dart:ui' as ui;

import '../../utils/constants.dart';

class FullPhoto extends StatelessWidget {
  final ImageProvider imgProvider;
  final void Function()? cancelFunc;

  const FullPhoto({Key? key, required this.imgProvider, this.cancelFunc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SuperDecoratedContainer(
          color: Colors.black,
          child: Column(
            children: <Widget>[
              vSpace48,
              InkWell(
                onTap: cancelFunc ??
                    () {
                      Get.back();
                    },
                child: Container(
                  decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                  padding: const EdgeInsets.all(8),
                  // margin: const EdgeInsets.all(8),
                  child: const Center(child: Icon(Icons.close, color: Colors.black)),
                ),
              ),
              Expanded(
                child: PhotoViewGallery.builder(
                  scrollPhysics: const BouncingScrollPhysics(),
                  builder: (BuildContext context, int index) {
                    return PhotoViewGalleryPageOptions(
                      imageProvider: imgProvider,
                      initialScale: PhotoViewComputedScale.contained,
                      minScale: PhotoViewComputedScale.contained,
                      maxScale: PhotoViewComputedScale.covered * 2,
                    );
                  },
                  itemCount: 1,
                  loadingBuilder: (context, event) {
                    return Center(
                      child: SizedBox(
                        width: 20.0,
                        height: 20.0,
                        child: CircularProgressIndicator(value: event == null ? 0 : event.cumulativeBytesLoaded / event.expectedTotalBytes!),
                      ),
                    );
                  },
                  backgroundDecoration: const BoxDecoration(color: Colors.black),
                ),
              ),
            ],
          )),
    );
  }

  static Future<void> showFullPhotoDialog({required ImageProvider imageProvider}) async {
    SmartDialog.show(
      alignment: Alignment.center,
      builder: (_) => FullPhoto(imgProvider: imageProvider),
    );
  }
}

// class UiImage extends ImageProvider<UiImage> {
//   final ui.Image image;
//   final double scale;
//
//   const UiImage(this.image, {this.scale = 1.0});
//
//   @override
//   Future<UiImage> obtainKey(ImageConfiguration configuration) => SynchronousFuture<UiImage>(this);
//
//   @override
//   ImageStreamCompleter load(UiImage key, DecoderCallback decode) => OneFrameImageStreamCompleter(_loadAsync(key));
//
//   Future<ImageInfo> _loadAsync(UiImage key) async {
//     assert(key == this);
//     return ImageInfo(image: image, scale: key.scale);
//   }
//
//   @override
//   bool operator ==(dynamic other) {
//     if (other.runtimeType != runtimeType) return false;
//     final UiImage typedOther = other;
//     return image == typedOther.image && scale == typedOther.scale;
//   }
//
//   @override
//   int get hashCode => hashValues(image.hashCode, scale);
//
//   @override
//   String toString() => '$runtimeType(${describeIdentity(image)}, scale: $scale)';
// }
