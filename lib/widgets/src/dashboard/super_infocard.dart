import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:super_widgets/utils/my_extensions.dart';

import '../txt.dart';

class SuperInfoCard extends StatelessWidget {
  const SuperInfoCard({super.key, required this.title, this.assetSrc, required this.num, this.color = Colors.green, this.iconData});

  final String title;
  final String? assetSrc;
  final int num;
  final IconData? iconData;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(begin: Alignment.topRight, end: Alignment.bottomLeft, colors: color!.toMaterial.toGradiant),
        border: Border.all(width: 2, color: context.theme.primaryColor.withOpacity(0.15)),
        borderRadius: const BorderRadius.all(Radius.circular(6)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              if (assetSrc != null || iconData != null)
                SizedBox(
                  height: 24,
                  width: 24,
                  child: assetSrc != null ? Image.asset(assetSrc!) : Icon(iconData!, color: Colors.white),
                ),
              const SizedBox(width: 16),
              Txt(
                title,
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                useOverflow: true,
              ),
            ],
          ),
          Txt(
            Intl.withLocale('en', () => NumberFormat().format(num)),
            fontSize: 24,
            color: Colors.white,
            fontWeight: FontWeight.w900,
          )
        ],
      ),
    );
  }
}
