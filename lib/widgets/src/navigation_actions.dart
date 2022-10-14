import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';


import 'txt.dart';

class NavigationActions extends StatelessWidget {
  int step = 1;
  Function? prevFunction;
  Function? nextFunction;
  bool isLast;
  NavigationActions(this.step,
      {this.prevFunction, this.nextFunction, this.isLast = false});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (step > 1 && (!isLast)) ...[
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.3,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        side: BorderSide(
                            width: 1, color: context.theme.primaryColorDark),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(16)))),
                  ),
                  onPressed: () {
                    if (prevFunction != null) prevFunction!();
                  },
                  child: Txt('رجوع',
                      color: context.theme.primaryColorDark,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(width: 10),
            ],
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.3,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(context.theme.primaryColorDark),
                  shape: MaterialStateProperty.all(const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16)))),
                ),
                onPressed: () {
                  // if (formKey.currentState.validate())
                  nextFunction!();
                },
                child: Txt(step == 3 ? 'اضافة' : 'التالي',
                    fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}

class SubmitActions extends StatelessWidget {
  Function? prevFunction;
  Function? nextFunction;
  String? nextTitle, prevTitle;
  SubmitActions(
      {this.nextFunction, this.nextTitle, this.prevTitle, this.prevFunction});
  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.spaceEvenly,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        if (prevFunction != null)
          Container(
            width: context.width * 0.4,
            margin: const EdgeInsets.symmetric(horizontal: 8),
            child: ElevatedButton(
              style: ButtonStyle(
                elevation: MaterialStateProperty.all(0),
                backgroundColor: MaterialStateProperty.all(Colors.white),
                shape: MaterialStateProperty.all(const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(36)))),
              ),
              onPressed: () {
                if (prevFunction != null) prevFunction!();
              },
              child: Txt(prevTitle ?? 'إعادة',
                  color: context.theme.primaryColorDark,
                  fontWeight: FontWeight.bold),
            ),
          ),
        if (nextFunction != null)
          SizedBox(
            width: context.width * 0.4,
            child: ElevatedButton(
              style: ButtonStyle(
                elevation: MaterialStateProperty.all(0),
                backgroundColor:
                    MaterialStateProperty.all(context.theme.primaryColorDark),
                shape: MaterialStateProperty.all(const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(36)))),
              ),
              onPressed: () {
                nextFunction!();
              },
              child: Txt(nextTitle ?? 'تطبيق',
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
      ],
    );
  }
}
