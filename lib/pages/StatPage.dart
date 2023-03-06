import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../model/Joueur.dart';

Widget statisticsPage(List<Joueur> l) {
  if (l[0].scores.isEmpty) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Statistiques'),
        ),
        body: const Center(
          child: Text("Aucun score"),
        ));
  } else {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Statistiques'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
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
                ),
                const Padding(padding: EdgeInsets.all(20)),
                SfCircularChart(
                    title: ChartTitle(text: "Pourcentage du score total"),
                    legend: Legend(
                        width: '25%',
                        isVisible: true
                    ),
                    series: <CircularSeries>[
                      PieSeries<PieData, String>(
                          dataSource: listePieData(l),
                          xValueMapper: (PieData data, _) => data.nom,
                          yValueMapper: (PieData data, _) => data.somme,
                          radius: '90%',
                          dataLabelSettings:
                              const DataLabelSettings(isVisible: true))
                    ]),
                const Padding(padding: EdgeInsets.all(20)),
                ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: l.length,
                    itemBuilder: (context, index) {
                      final j = l[index];
                      bool estNomme = true;
                      for(int i = 0; i<l.length;i++){
                        if(l[i].nom == ''){
                          estNomme = false;
                          break;
                        }
                      }
                      if (estNomme) {
                        return TuileFinal(j, l);
                      }else{
                        return const Text("Les Joueurs n'ont pas de noms");
                      }

                    }),
              ],
            ),
          ),
        ));
  }
}

Widget TuileFinal(Joueur j, List<Joueur> l) {
  var isVisible = false;
  if(j.position.last == 0 && j.scores.isNotEmpty){
    isVisible = true;
  }
  return SizedBox(
    height: 200,
    child: Card(
      child: Column(
        children: [
          Row(
            children: [
              //Position final
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                    child: SizedBox(
                  height: 40,
                  width: 40,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      (j.position.last + 1).toString(),
                      style: const TextStyle(
                        fontSize: 27,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )),
              ),
              Visibility(
                  visible: isVisible,
                  child: const Padding(
                    padding: EdgeInsets.only(right: 8),
                    child: Image(
                      image: AssetImage('lib/Assets/crown2.png'),
                      width: 30,
                      height: 25,
                    ),
                  )
              ),
              //Nom
              Expanded(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: 100
                  ),
                  child: Text(
                    j.nom,
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const Text("pt : ",
                  style: TextStyle(
                    fontSize: 18,
                  )),
              Padding(
                padding: const EdgeInsets.only(right: 14),
                child: Text(j.sommeScore().toString(),
                    style: const TextStyle(
                      fontSize: 27,
                      fontWeight: FontWeight.bold,
                    )),
              ),
            ],
          ),
          Text(
              "Score moyen : ${(j.sommeScore() / j.scores.length).round().toInt()}"),
          Text("Pire score : ${pireScore(j).toString()}"),
          Text(
              "Nombre de deutsch : ${j.NbDeutschs()}  deutschs gagnés : ${deutschsGagne(j, l)}"),
          Text("Taux de deutschs : ${j.NbDeutschs() / j.scores.length}"),
          Text("Position Moyenne : ${positionMoyen(j)}"),
          Text(
              "Pire ennemie : ${pireEnnemie(j, l)[0]}  a volé ${pireEnnemie(j, l)[1]} deutschs"),
          Text("Deutschs volés : ${nbDeutschsVole(j, l)}"),
        ],
      ),
    ),
  );
}

nbDeutschsVole(Joueur joueur, List<Joueur> l){
  //combien de deutsch a t'il vole
  int res = 0;
  for (int i =0;i<l.length;i++){//on parcourt tous les autres joueurs
    if(l[i].nom != joueur.nom && joueur.deutschs.isNotEmpty){//si le joueur a deutsch
      for (int j = 0; j<l[i].deutschs.length;j++){ //pour tous les deutsch d'un joueur
        if (l[i].deutschs[j]==2){ //si un joueur a perdu son deutsch
          if(joueur.scores[j] < l[i].scores[j]){ //si le joueur a fait un meilleur score
            res++;
          }
        }
      }
    }
  }
  return res;
}


pireEnnemie(Joueur joueur, List<Joueur> l) {
  //le pire ennemie est le joueur qui a volé le plus de deutschs
  //On regarde quand le joueur a deutsch
  //s'il a deutsch on regarde s'il a été premier
  //si il n'a pas été le premier, la liste de pire énnemies augmente de 1

  Map<String, dynamic> difdeutsch = {
    for (var a = 0; a < l.length; a++)
      if (l[a].nom != joueur.nom) l[a].nom: 0
  };

  //print(ennemies.toString());
  for (int i = 0; i < joueur.deutschs.length; i++) {
    if (joueur.deutschs[i]==2) {
      for (int j = 0; j < l.length; j++) {
        if (l[j].nom != joueur.nom){
          difdeutsch[l[j].nom] = difdeutsch[l[j].nom] + 1;
        }
      }
    }
  }

  String res = difdeutsch.keys.first;

  int voleMax = 0;
  difdeutsch.forEach((key, value) {
    if (voleMax < value) {
      voleMax = value;
      res = key;
    }
  });
  return [res, difdeutsch[res]];
}

int pireScore(Joueur j) {
  int scoreMax = j.scores[0];
  for (int i = 0; i < j.scores.length; i++) {
    if (scoreMax < j.scores[i]) {
      scoreMax = j.scores[i];
    }
  }
  return scoreMax;
}

int positionMoyen(Joueur j) {
  int somme = 0;
  for (int i = 0; i < j.position.length; i++) {
    somme = somme + j.position[i];
  }
  int res;
  if (j.position.length == 1) {
    res = j.position[0];
  } else {
    res = (somme / j.position.length).round().toInt();
  }
  return res + 1;
}

int deutschsGagne(Joueur joueur, List<Joueur> l) {
  int res = 0;
  //retourne le nombre de deutsch gagnés
  for (int j = 0; j < joueur.scores.length; j++) {
    if (joueur.deutschs[j]==1) {
      res++;
    }
  }
  return res;
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
  for (int i = 0; i < j.scores.length+1; i++) {
    chartJouer = chartJouer + [ChartData(j.scoreJusqua(i), i)];
  }
  return chartJouer;
}

class ChartData {
  ChartData(this.score, this.manche);

  final int score;
  final int manche;
}

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
