import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../main.dart';
import '../model/Joueur.dart';

Widget statisticsPage(numPartie) {
  return Scaffold(
      appBar: AppBar(
        title: const Text('Scores'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Card(
          elevation: 4,
          child: Container(
            height: 230,
            decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.transparent,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(10))),
            child: SfCartesianChart(
                primaryXAxis: NumericAxis(),
                legend: Legend(
                    position: LegendPosition.bottom,
                    overflowMode: LegendItemOverflowMode.wrap,
                    width: '100%',
                    height: '30%',
                    isVisible: true),
                series: lineSeriesBuilder(l)),
          ),
        ),
      ));
}

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

List<ChartData> chartJoueur(Joueur j) {
  List<ChartData> chartJouer = [];
  for (int i = 0; i < j.scores.length; i++) {
    chartJouer = chartJouer + [ChartData(j.scoreJusqua(i), i)];
  }
  ;
  return chartJouer;
}

class ChartData {
  ChartData(this.score, this.manche);

  final int score;
  final int manche;
}
