import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'super_decorated_container.dart';
import 'txt.dart';

// ignore: must_be_immutable
class SuperPlusMinusBtn extends StatelessWidget {
  late Rx<double> curNum;
  final double num, min, max, step;
  final double? borderRadius;
  final bool hasBtnBorders, hasBorder;
  Color? btnColor, borderColor, txtColor;
  final void Function(double)? onChanged;
  dynamic Function(double)? displayAs;
  final EdgeInsets padding;

  SuperPlusMinusBtn(
      {Key? key,
      this.num = 1,
      this.step = 1,
      this.min = 0,
      this.max = 1000,
      this.onChanged,
      this.displayAs,
      this.borderRadius,
      this.hasBorder = false,
      this.hasBtnBorders = true,
      this.padding = const EdgeInsets.all(8),
      this.btnColor,
      this.txtColor,
      this.borderColor})
      : super(key: key) {
    curNum = num.obs;
    txtColor ??= Get.theme.primaryColor;
    displayAs ??= (s) => s;
    // borderColor ??= Get.theme.primaryColor;
    // btnColor ??= Get.theme.primaryColor;
  }

  @override
  Widget build(BuildContext context) {
    return SuperDecoratedContainer(
      borderRadius: borderRadius,
      borderWidth: hasBorder ? 1 : 0,
      borderColor: hasBorder ? borderColor : Colors.transparent,
      padding: padding,
      child: Obx(() {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SuperDecoratedContainer(
              borderWidth: hasBtnBorders ? 1 : null,
              borderColor: curNum > min ? borderColor : Colors.grey,
              shape: BoxShape.circle,
              child: IconButton(
                  icon: Icon(Icons.remove, color: curNum > min ? btnColor : Colors.grey),
                  onPressed: curNum > min
                      ? () {
                          curNum -= step;
                          onChanged?.call(curNum.value);
                        }
                      : null),
            ),
            Txt('${displayAs!.call(curNum.value)}', color: txtColor, fontSize: 20, fontWeight: FontWeight.bold),
            SuperDecoratedContainer(
              borderWidth: hasBtnBorders ? 1 : null,
              borderColor: curNum < max ? borderColor : Colors.grey,
              shape: BoxShape.circle,
              child: Center(
                child: IconButton(
                    icon: Icon(Icons.add, color: curNum < max ? btnColor : Colors.grey),
                    onPressed: curNum < max
                        ? () {
                            curNum += step;
                            onChanged?.call(curNum.value);
                          }
                        : null),
              ),
            ),
          ],
        );
      }),
    );
  }
}
