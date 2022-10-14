import 'package:flutter/material.dart';

import 'txt.dart';

class LabeledCircularCard extends StatelessWidget {
  final Color? color;
  final IconData? iconData;
  final String? asset;
  final String? label;

  const LabeledCircularCard(
      {this.label, this.asset, this.iconData, this.color, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 24,
          backgroundColor: color,
          child: SizedBox(
            width: 28,
            child: asset != null
                ? Image.asset(
                    asset!,
                    fit: BoxFit.cover,
                  )
                : iconData != null
                    ? Icon(iconData)
                    : const SizedBox(),
          ),
        ),
        if (label != null) Txt(label)
      ],
    );
  }
}
