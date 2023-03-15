import 'package:Dutch/pages/Stats/EvolutionsScore.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import '../boxes.dart';
import '../main.dart';
import '../model/Joueur.dart';
import 'HistoricPage.dart';
import 'Stats/List.dart';
import 'Stats/Pie.dart';
import 'addJoueurPage.dart';

class statisticsPage extends StatelessWidget {
  const statisticsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box<Joueur>>(
        valueListenable: Boxes.getparties().listenable(),
        builder: (context, box, _) {
          List<Joueur> listeJoueur = box.values.toList().cast<Joueur>();

          printlog(listeJoueur.toString());

          if (listeJoueur.isEmpty) {
            addJoueur('', partieCourante, [], [], [0], []);
            addJoueur('', partieCourante, [], [], [0], []);
            addJoueur('', partieCourante, [], [], [0], []);
            addJoueur('', partieCourante, [], [], [0], []);
          }
          //on prend uniquement les joueurs qui sont de la partie selectionnée
          List<Joueur> listeCourante = [];
          for (int i = 0; i < listeJoueur.length; i++) {
            if (listeJoueur[i].partie == partieCourante) {
              listeCourante = listeCourante + [listeJoueur[i]];
            }
          }
          if (listeCourante[0].scores.isEmpty) {
            return Scaffold(
                appBar: AppBar(
                  title: const Text('Statistiques'),
                ),
                body: const Center(
                  child: Text("Aucun score"),
                ));
          } else {
            return Construire(listeCourante);
          }
        });
  }
}

Scaffold Construire(List<Joueur> l) {
  l = ranger(l);
  return Scaffold(
      appBar: AppBar(
        title: const Text('Statistiques'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Evolution(l),
              const Padding(padding: EdgeInsets.all(20)),
              Pie(l),
              const Padding(padding: EdgeInsets.all(20)),
              ListScore(liste: l),
            ],
          ),
        ),
      ));
}

