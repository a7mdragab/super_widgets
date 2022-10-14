// import 'dart:math';
//
// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';
// // import 'package:date_util/date_util.dart';
// import 'package:bezier_chart/bezier_chart.dart';
//
// class LineChartSample1 extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() => LineChartSample1State();
// }
//
// class LineChartSample1State extends State<LineChartSample1> {
//   final fromDate = DateTime(2021, 6, 1);
//   final toDate = DateTime.now();
//
//   final date1 = DateTime.now().subtract(Duration(days: 2));
//   final date2 = DateTime.now().subtract(Duration(days: 3));
//
//   final date3 = DateTime.now().subtract(Duration(days: 35));
//   final date4 = DateTime.now().subtract(Duration(days: 36));
//
//   final date5 = DateTime.now().subtract(Duration(days: 65));
//   final date6 = DateTime.now().subtract(Duration(days: 64));
//
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Container(
//         color: Colors.red,
//         height: MediaQuery.of(context).size.height / 2,
//         width: MediaQuery.of(context).size.width,
//         child: BezierChart(
//           bezierChartScale: BezierChartScale.HOURLY,
//           fromDate: fromDate,
//           toDate: toDate,
//           selectedDate: toDate,
//           series: [
//             BezierLine(
//               label: "Duty",
//               onMissingValue: (dateTime) {
//                 if (dateTime.month.isEven) {
//                   return 10.0;
//                 }
//                 return 5.0;
//               },
//               data: [
//                 DataPoint<DateTime>(value: 10, xAxis: date1),
//                 DataPoint<DateTime>(value: 50, xAxis: date2),
//                 DataPoint<DateTime>(value: 20, xAxis: date3),
//                 DataPoint<DateTime>(value: 80, xAxis: date4),
//                 DataPoint<DateTime>(value: 14, xAxis: date5),
//                 DataPoint<DateTime>(value: 30, xAxis: date6),
//               ],
//             ),
//           ],
//           config: BezierChartConfig(
//             verticalIndicatorStrokeWidth: 3.0,
//             verticalIndicatorColor: Colors.black26,
//             showVerticalIndicator: true,
//             verticalIndicatorFixedPosition: false,
//             backgroundColor: Colors.red,
//             footerHeight: 30.0,
//           ),
//         ),
//       ),
//     );
//   }
// }
