import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as svg_p;

import '../../utils/utils.dart';
import '../../widgets/widgets.dart';
import 'full_photo.dart';

// ignore: must_be_immutable
class SuperImageView extends StatelessWidget {
  final String? imgUrl;
  final Map<String, String>? headers;
  final String? imgAssetPath;

  final File? imgFile;
  final String? imgFilePath;

  final String? svgUrl;
  final String? svgAssetPath;

  final Uint8List? uint8list;
  final String? base64String;

  final Widget? icon;

  final bool? matchTextDirection;
  final double? width;
  final double? height;

  final List<BoxShadow>? boxShadow;
  final BoxFit? fit;
  final double? borderRadius;
  final double? borderWidth;
  final Color? borderColor;
  final BoxBorder? border;
  final bool? hasBorder;
  final bool? enableFullShow;
  final Color? color;

  final void Function()? onPress;
  final BoxShape shape;

  const SuperImageView(
      {super.key,
      this.imgUrl,
      this.headers,
      this.imgAssetPath,
      this.svgUrl,
      this.svgAssetPath,
      this.imgFile,
      this.imgFilePath,
      this.uint8list,
      this.base64String,
      this.icon,
      this.color,
      this.fit = BoxFit.cover,
      this.borderColor,
      this.borderRadius,
      this.borderWidth,
      this.border,
      this.boxShadow,
      this.hasBorder = false,
      this.matchTextDirection = false,
      this.enableFullShow = false,
      this.shape = BoxShape.rectangle,
      this.width,
      this.height,
      this.onPress})
      : assert(imgUrl != null || imgAssetPath != null || svgUrl != null || svgAssetPath != null || imgFile != null || imgFilePath != null || uint8list != null || base64String != null || icon != null);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress ??
          (enableFullShow!
              ? () {
                  ImageProvider? imageProvider = getImageProvider();
                  if (imageProvider != null) {
                    FullPhoto.showFullPhotoDialog(imageProvider: imageProvider);
                  } else {
                    mPrint('Unable to get image provider');
                  }
                }
              : null),
      child: shape == BoxShape.circle
          ? ClipOval(child: _getBorderedImageWidget())
          : ClipRRect(
              borderRadius: shape == BoxShape.circle ? null : BorderRadius.all(Radius.circular(borderRadius ?? 0)),
              child: _getBorderedImageWidget(),
            ),
    );
  }

  Widget _getBorderedImageWidget() => SuperDecoratedContainer(
        height: height,
        width: width,
        borderColor: borderColor,
        borderWidth: borderWidth,
        border: border,
        borderRadius: borderRadius,
        boxShadow: boxShadow,
        shape: shape,
        color: color,
        child: _getImageWidget(),
      );

  Widget _getImageWidget() {
    if (imgUrl != null) {
      return PNetworkImage(
        url: imgUrl!,
        height: height,
        width: width,
        fit: fit,
      );
    } else if (imgAssetPath != null) {
      return Image.asset(
        imgAssetPath!,
        height: height,
        width: width,
        fit: fit,
      );
    } else if (uint8list != null) {
      return Image.memory(
        uint8list!,
        height: height,
        width: width,
        fit: fit,
      );
    } else if (base64String != null) {
      return Image.memory(
        base64Decode(base64String!),
        height: height,
        width: width,
        fit: fit,
      );
    } else if (svgAssetPath != null) {
      return SvgPicture.asset(
        svgAssetPath!,
        height: height,
        width: width,
        fit: fit!,
        matchTextDirection: matchTextDirection!,
      );
    } else if (svgUrl != null) {
      return SvgPicture.network(
        svgUrl!,
        height: height,
        width: width,
        fit: fit!,
      );
    } else if (imgFile != null) {
      return Image.file(
        imgFile!,
        height: height,
        width: width,
        fit: fit,
      );
    } else if (imgFilePath != null) {
      return Image.file(
        File.fromUri(Uri.parse(imgFilePath!)),
        height: height,
        width: width,
        fit: fit,
      );
    }
    return icon ?? const Icon(Icons.image);
  }

  ImageProvider? getImageProvider() {
    if (svgAssetPath != null || svgUrl != null) {
      return svg_p.Svg(
        (svgAssetPath ?? svgUrl)!,
        source: svgAssetPath == null ? svg_p.SvgSource.network : svg_p.SvgSource.asset,
      );
    } else if (imgUrl != null) {
      return CachedNetworkImageProvider(imgUrl!,headers: headers);
    } else if (imgAssetPath != null) {
      return AssetImage(imgAssetPath!);
    } else if (uint8list != null) {
      return MemoryImage(uint8list!);
    } else if (base64String != null) {
      return MemoryImage(base64Decode(base64String!));
    } else if (imgFile != null) {
      return FileImage(imgFile!);
    } else if (imgFilePath != null) {
      return FileImage(File.fromUri(Uri.parse(imgFilePath!)));
    }
    return null;
  }
}
