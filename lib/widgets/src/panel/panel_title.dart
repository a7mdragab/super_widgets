import 'package:flutter/material.dart';

import '../txt.dart';

class PanelTitle extends StatelessWidget {
  final String title;
  final String actionText;
  final Function? seeAll;
  final double padding;

  const PanelTitle(
      {super.key,
      required this.title,
      this.seeAll,
      this.actionText = 'See All',
      this.padding = 16});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: Row(
        children: [
          Expanded(
            child: Txt(
              title,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextButton(
            onPressed: seeAll?.call(),
            child: Txt(
              actionText,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
