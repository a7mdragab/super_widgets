import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../utils/constants.dart';

class ShadowedCard extends StatelessWidget {
  const ShadowedCard({Key? key, required this.child, this.hasBack = false,this.borderColor , this.opacity = 1}) : super(key: key);
  final Widget child;
  final bool hasBack;
  final double opacity;
  final Color? borderColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        // color: Colors.white.withOpacity(opacity),
        borderRadius: const BorderRadius.all(Radius.circular(36)),
        boxShadow: [
          const BoxShadow(
            color: Colors.white,
            blurRadius: 20,
            spreadRadius: 0.2,
            offset: Offset(0, -0.5),
          ),
          BoxShadow(
            color: borderColor??context.theme.colorScheme.secondary,
            blurRadius: 10,
            // spreadRadius: 2,
            offset: const Offset(0, 1),
          ),
          // BoxShadow(
          //   color: appMainGradientColors[0],
          //   blurRadius: 5,
          //   offset: const Offset(0, 5),
          // ),
        ],
      ),
      child: Card(
        elevation: 10,
        shadowColor: Colors.white,
        borderOnForeground: true,
        color: Colors.white.withOpacity(opacity),
        shape: RoundedRectangleBorder(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            side: BorderSide(
              width: 3,
              strokeAlign: -1,
              color: borderColor??context.theme.colorScheme.secondary,
            )),
        child: hasBack
            ? Column(
                children: [
                  vSpace8,
                  Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                            child: SvgPicture.asset(
                              'assets/images/back_icon.svg',
                              width: context.width,
                              height: context.height * 0.3,
                              fit: BoxFit.fill,
                              // color: Colors.red,
                              // semanticsLabel: 'A red up arrow'
                            ),
                          ),
                        ),
                      )),
                  Expanded(child: child),
                ],
              )
            : child,
      ),
    );
  }
}
