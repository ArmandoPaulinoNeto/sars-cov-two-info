import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:sars_cov_two_info/src/models/historical_country_model.dart';

class HistoricalGraphic{

  HistoricalCountry ?historicalCountry;

  HistoricalGraphic(this.historicalCountry);

  List<Color> colors = [
    Color.fromRGBO(225, 180, 163, 1.0),
  ];

  List<FlSpot>  graphicData = [];

  double maxX = 0;
  double maxY = 0;
  double minY = 0;

  setData() async{

    graphicData = [];
    
    maxX = historicalCountry!.timeline!.deaths.length.toDouble();
    maxY = 0;
    minY = double.infinity;

    for(var numero in historicalCountry!.timeline!.deaths){

      maxY = numero > maxY ? numero : maxY;
      minY = numero < minY ? numero : minY;
    }
    for(int i = 0; i < historicalCountry!.timeline!.deaths.length; i++){
      graphicData.add(FlSpot(i.toDouble(), historicalCountry!.timeline!.deaths[i],));
    }
  }
  Widget getGraphic() {
    setData();
    return Container(
      child: AspectRatio(
        aspectRatio: 2,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Color.fromRGBO(2, 110, 60, 1.0),
                borderRadius: new BorderRadius.only(
                  topLeft: const Radius.circular(10.0),
                  topRight: const Radius.circular(10.0),
                  bottomLeft: const Radius.circular(10.0),
                  bottomRight: const Radius.circular(10.0),
                ),
              ),
              padding: const EdgeInsets.only(left: 25, top: 15, bottom: 20, right: 15),
              child: LineChart(
                getChartData(),
              ),
            ),
          ],
        ),
      ),
    );
  }
  LineChartData getChartData() {
    return LineChartData(
      gridData: FlGridData(show: false),
      titlesData: FlTitlesData(show: false),
      borderData: FlBorderData(show: false),
      minX: 0,
      maxX: maxX,
      minY: minY,
      maxY: maxY,
      lineBarsData: [
        LineChartBarData(
          spots: graphicData,
          isCurved: true,
          colors: colors,
          barWidth: 4,
          dotData: FlDotData(show: true),
          belowBarData: BarAreaData(show: true,
            colors: colors.map((e) => e.withOpacity(0.15)).toList(),
          ),
        ),
      ],
      lineTouchData:
        LineTouchData(
          touchTooltipData: LineTouchTooltipData(
            tooltipBgColor: Color.fromRGBO(149, 206, 157, 1.0),
            getTooltipItems: (number){
              return number.map((item) {
                return LineTooltipItem(
                  item.y.toInt().toString(),
                  TextStyle(
                  color: Color.fromRGBO(137, 92, 56, 1.0),
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  ),
                  children: [
                    TextSpan(
                      text: '\n ${historicalCountry!.timeline!.dayDeaths[item.spotIndex]}',
                      style: TextStyle(
                      color: Color.fromRGBO(137, 92, 56, 0.75),
                      fontSize: 12,
                      )
                    ),
                  ],
                );
              }).toList();
            },
          ),
        ),
    );
  }
}









