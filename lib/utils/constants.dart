import 'package:flutter/material.dart';

const String appUploadCenter = 'UploadCenter';

const hSpace4 = SizedBox(width: 4);
const hSpace8 = SizedBox(width: 8);
const hSpace16 = SizedBox(width: 16);
const hSpace24 = SizedBox(width: 24);
const hSpace32 = SizedBox(width: 32);
const hSpace48 = SizedBox(width: 48);
const hSpace64 = SizedBox(width: 64);
const vSpace4 = SizedBox(height: 4);
const vSpace8 = SizedBox(height: 8);
const vSpace16 = SizedBox(height: 16);
const vSpace24 = SizedBox(height: 24);
const vSpace32 = SizedBox(height: 32);
const vSpace48 = SizedBox(height: 48);
const vSpace64 = SizedBox(height: 64);
const vSpace96 = SizedBox(height: 96);

class hSpace extends StatelessWidget {
  final double? x;

  const hSpace(this.x, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: x ?? 8);
  }
}

class vSpace extends StatelessWidget {
  final double? x;

  const vSpace(this.x, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: x ?? 8);
  }
}

const List<String> arabicCharacters = ["أ", "ؤ", "إ", "ئ", "ا", "ب", "ة", "ت", "ث", "ج", "ح", "خ", "د", "ذ", "ر", "ز", "س", "ش", "ص", "ض", "ط", "ظ", "ع", "غ", "ػ", "ؼ", "ؽ", "ؾ", "ؿ"];

const daysNames = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
const daysFullNames = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
const monthsNames = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
const monthsFullNames = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];
