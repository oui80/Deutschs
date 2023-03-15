import 'package:flutter/cupertino.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../model/Joueur.dart';

Widget Pie(List<Joueur> l) => SfCircularChart(
    title: ChartTitle(text: "Pourcentage du score total"),
    legend: Legend(width: '25%', isVisible: true),
    series: <CircularSeries>[
      PieSeries<PieData, String>(
          dataSource: listePieData(l),
          xValueMapper: (PieData data, _) => data.nom,
          yValueMapper: (PieData data, _) => data.somme,
          radius: '90%',
          dataLabelSettings:
          const DataLabelSettings(isVisible: true))
    ]);


List<PieData> listePieData(List<Joueur> l) {
  List<PieData> pieJouer = [];
  for (int i = 0; i < l.length; i++) {
    pieJouer = pieJouer + [PieData(l[i].nom, l[i].sommeScore())];
  }
  return pieJouer;
}

class PieData {
  PieData(this.nom, this.somme);

  final String nom;
  final int somme;
}