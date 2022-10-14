import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';

import 'package:dart_extensions/dart_extensions.dart';

class Super_DottedLine extends StatefulWidget {
  bool active = false;
  Color color;
  Super_DottedLine(this.active, this.color);

  @override
  _Super_DottedLineState createState() => _Super_DottedLineState();
}

class _Super_DottedLineState extends State<Super_DottedLine> {
  @override
  Widget build(BuildContext context) {
    return DottedLine(
      direction: Axis.horizontal,
      lineLength: double.infinity,
      lineThickness: 2.0,
      dashLength: widget.active ? 6.0 : 2.0,
      dashColor: widget.active ? Colors.grey : widget.color,
      dashGapLength: widget.active ? 0 : 3,
      dashGapColor: Colors.transparent,
    );
  }
}
