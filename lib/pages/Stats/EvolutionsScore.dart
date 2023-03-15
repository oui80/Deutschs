import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../model/Joueur.dart';

Widget Evolution(List<Joueur> l) =>
    Card(
      elevation: 4,
      child: Container(
        height: 230,
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.transparent,
            ),
            borderRadius:
            const BorderRadius.all(Radius.circular(10))),
        child: SfCartesianChart(
            primaryXAxis: NumericAxis(),
            title: ChartTitle(text: "Evolution des scores"),
            legend: Legend(
                position: LegendPosition.bottom,
                overflowMode: LegendItemOverflowMode.wrap,
                width: '100%',
                height: '35%',
                isVisible: true),
            series: lineSeriesBuilder(l)),
      ),
    );

List<ChartSeries> lineSeriesBuilder(List<Joueur> l) {
  List<ChartSeries<dynamic, dynamic>> res = [];
  for (int i = 0; i < l.length; i++) {
    res = res +
        [
          LineSeries<ChartData, int>(
            dataSource: chartJoueur(l[i]),
            xValueMapper: (ChartData data, _) => data.manche,
            yValueMapper: (ChartData data, _) => data.score,
            name: l[i].nom,
          )
        ];
  }
  return res;
}

class ChartData {
  ChartData(this.score, this.manche);

  final int score;
  final int manche;
}

List<ChartData> chartJoueur(Joueur j) {
  List<ChartData> chartJouer = [];
  for (int i = 0; i < j.scores.length + 1; i++) {
    chartJouer = chartJouer + [ChartData(j.scoreJusqua(i), i)];
  }
  return chartJouer;
}