import 'package:flutter/material.dart';
import 'package:draggable_scrollbar/draggable_scrollbar.dart';
import 'package:get/get.dart';

class ScrolledBarWidget extends StatefulWidget {
  final BoxScrollView Function(ScrollController controller) builder;
  const ScrolledBarWidget({
    Key? key,
    required this.builder,
  }) : super(key: key);

  @override
  State<ScrolledBarWidget> createState() => _ScrolledBarWidgetState();
}

class _ScrolledBarWidgetState extends State<ScrolledBarWidget> {
  late ScrollController controller;

  @override
  void initState() {
    controller = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
            right: 0,
            // top: 8,
            child: Container(
              width: 18,
              height: context.height,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(16)),
              ),
            )),
        Padding(
          padding: const EdgeInsets.only(right: 1, top: 2),
          // padding: const EdgeInsets.all(0),
          child: DraggableScrollbar.rrect(
            alwaysVisibleScrollThumb: true,
            controller: controller,
            heightScrollThumb: 80,
            backgroundColor: context.theme.colorScheme.secondary,
            // scrollThumbBuilder: scrollThumbBuilder,
            child: widget.builder(controller),
          ),
        ),
      ],
    );
  }

  Widget scrollThumbBuilder(Color backgroundColor, Animation<double> thumbAnimation, Animation<double> labelAnimation, double height, {BoxConstraints? labelConstraints, Text? labelText}) {
    return Container(
      height: height,
      width: 12,
      color: backgroundColor,
    );
  }
}
