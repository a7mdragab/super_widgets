import 'package:flutter/material.dart';
import 'package:get/get.dart';



import 'txt.dart';
import 'super_dotted_line.dart';

class Super_StepIndictor extends StatefulWidget {
  int curStep = 1;
  Color? color;
  LinearGradient? gradient;
  Super_StepIndictor(this.curStep, {this.color, this.gradient});

  @override
  _Super_StepIndictorState createState() => _Super_StepIndictorState();
}

class _Super_StepIndictorState extends State<Super_StepIndictor> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width * 0.7,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconView(1, 'iconfinder_phone8_216688@3x'),
//                IconView(1, Icons.person),
                Expanded(
                  child: Super_DottedLine(widget.curStep > 1, widget.color!),
                ),
                IconView(2, 'List@3x'),
              ],
            ),
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Txt(
                'البيانات الرئيسية',
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: widget.curStep == 1 ? widget.color : Colors.black,
              ),
              Expanded(
                child: Container(),
              ),
              Txt('تأكيد الرقم',
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: widget.curStep == 2 ? widget.color : Colors.black),
              // Expanded(
              //   child: Container(),
              // ),
              // ArabicText('البيانات الشخصية',
              //     fontSize: 13,
              //     fontWeight: FontWeight.bold,
              //     color: widget.curStep == 3 ? widget.color : Colors.black),
            ],
          ),
        ],
      ),
    );
  }

  Widget IconView(int index, String asset) {
    return Container(
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: widget.curStep == index
                ? [
                    BoxShadow(
                        blurRadius: 5,
                        color: context.theme.primaryColor,
                        offset: const Offset(0, 3))
                  ]
                : null,
            border: Border.all(
                color: widget.curStep <= index
                    ? widget.color!
                    : context.theme.primaryColor),
            color:
                widget.curStep > index ? context.theme.primaryColor : Colors.white,
            gradient: widget.curStep == index ? widget.gradient : null),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: widget.curStep <= index
              ? Image.asset(
                  'assets/images/$asset.svg',
                  color: widget.curStep >= index ? Colors.white : widget.color,
                  height: 20,
                  width: 20,
                  fit: BoxFit.contain,
                )
              : const Icon(
                  Icons.done,
                  color: Colors.white,
                  size: 20,
                ),
        ));
  }
}
