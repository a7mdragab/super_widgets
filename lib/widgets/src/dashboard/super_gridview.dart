import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';


class SuperGridView extends StatelessWidget {
  final List<Widget> children;
  const SuperGridView({Key? key, required this.children}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return InfoCardGridView(
      crossAxisCount: _size.width < 700 ? 4 : 5,
      childAspectRatio: _size.width < 1400 ? 1.2 : 1.5,
      children: children,
    );
  }
}

class SuperDataGridView extends StatelessWidget {
  final List<Widget> children;
  const SuperDataGridView({Key? key, required this.children}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InfoCardGridViewColored(
      crossAxisCount: context.responsiveValue<int>(desktop: 8, tablet: 6, mobile: 4),
      childAspectRatio: context.responsiveValue<double>(desktop: 1.2, tablet: 1.1, mobile: 1.0),
      children: children,
    );
  }
}

class InfoCardGridView extends StatelessWidget {
  final List<Widget> children;

  const InfoCardGridView({
    Key? key,
    required this.children,
    this.crossAxisCount = 4,
    this.childAspectRatio = 1,
  }) : super(key: key);

  final int crossAxisCount;
  final double childAspectRatio;

  @override
  Widget build(BuildContext context) {
    return GridView(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: childAspectRatio,
        ),
        children: children);
  }
}

class InfoCardGridViewColored extends StatelessWidget {
  final List<Widget> children;

  const InfoCardGridViewColored({
    Key? key,
    required this.children,
    this.crossAxisCount = 4,
    this.childAspectRatio = 1,
  }) : super(key: key);

  final int crossAxisCount;
  final double childAspectRatio;

  @override
  Widget build(BuildContext context) {
    return GridView(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: childAspectRatio,
        ),
        children: children
            .map((e) => Container(
                decoration: BoxDecoration(
                    border: Border.all(color: context.theme.primaryColor
                        // color: Color((Random().nextDouble() * 0xFFFFFF).toInt())
                        //     .withOpacity(1.0),
                        )),
                child: Center(child: e)))
            .toList());
  }
}
