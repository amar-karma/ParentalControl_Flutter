import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:pca/utils/constants.dart';

class PieChartMaker extends StatelessWidget {
  final List<int> timeData;
  final int totalTime;

  PieChartMaker({@required this.timeData, @required this.totalTime});

  @override
  Widget build(BuildContext context) {
    List<PieChartSectionData> pieChartSectionDatalist = [];

    int colorindex = 0;

    final List colors = const [
      COLOR_BLUE,
      COLOR_GREEN,
      COLOR_ORANGE,
      // const Color(0xff00c3ff),
      // const Color(0xffFFE000),
    ];

    colorindex = 0;
    pieChartSectionDatalist = [];
    timeData.forEach((t) {
      double val = t / totalTime;
      // double perc = val * 100;
      // var text = (perc > 7.0) ? "${perc.toStringAsFixed(2)}%" : "";
      var text = "";
      pieChartSectionDatalist.add(
        PieChartSectionData(
          color: colors[colorindex++],
          value: val,
          title: "$text",
          radius: 60,
          titleStyle: TextStyle(
            fontSize: 15,
            // fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      );
    });

    return PieChart(
      PieChartData(
        borderData: FlBorderData(show: false),
        sectionsSpace: 2,
        centerSpaceRadius: 50,
        sections: pieChartSectionDatalist,
      ),
    );
  }
}
