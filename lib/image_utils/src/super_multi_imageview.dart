import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'super_image_class.dart';
import 'super_image_pick_view.dart';

class Super_MultiImageView extends StatefulWidget {
  List<SuperImageClass> imagesList;

  Super_MultiImageView(this.imagesList);

  @override
  _Super_MultiImageViewState createState() => _Super_MultiImageViewState();
}

class _Super_MultiImageViewState extends State<Super_MultiImageView> {
  SuperImageClass? temp;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    temp = SuperImageClass();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 6),
        Wrap(
          runSpacing: 0,
          spacing: 0,
          children: [
            ...widget.imagesList.map((img) => SuperImagePickView(img, width: 0.3)).toList(),
            SizedBox(height: 10),
            InkWell(
                onTap: () async {
                  printInfo(info: 'loadAssets');
                  // await loadAssets();
                },
                child: SizedBox(
                  width: (widget.imagesList.length > 0) ? 100 : null,
                  height: (widget.imagesList.length > 0) ? 80 : null,
                  child: DottedBorder(
                    // color: Get.theme.hintColor.withOpacity(0.6),
                    strokeWidth: 2,
                    borderType: BorderType.RRect,
                    radius: Radius.circular(8),
                    child: Container(
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.all(Radius.circular(8))),
                        child: Center(child: Image.asset('assets/images/attach_pic.svg', height: 100))),
                  ),
                )),
          ],
        ),
      ],
    );
  }
}
