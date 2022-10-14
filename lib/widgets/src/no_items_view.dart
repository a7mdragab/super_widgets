import 'package:flutter/material.dart';
import 'package:get/get.dart';



import '../../utils/constants.dart';
import 'txt.dart';

class NoItemsView extends StatelessWidget {
  final Function? function;
  final  String txt;
  const NoItemsView(this.txt, [this.function,Key? key]):super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.height,
      child: Center(
        child: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                const SizedBox(height: 80),
                Center(child: Txt(txt)),
                const SizedBox(height: 36),
                // IconButton(
                //     icon: Icon(Icons.refresh), onPressed: () => function ?? () {}),
                // SizedBox(height: 36),
                // appIcon
              ],
            ),
          ],
        ),
      ),
    );
  }
}
