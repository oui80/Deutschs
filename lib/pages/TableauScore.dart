import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:Dutch/Widgets/ModifyDialog.dart';
import '../Widgets/ScoreDialog2.dart';
import '../boxes.dart';
import '../main.dart';
import '../model/Joueur.dart';
import 'addJoueurPage.dart';

Widget TableauScore(BuildContext context) {
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

        return Scaffold(
          appBar: AppBar(title: const Text('Tableau des Scores'), actions: [
            IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => ModifyDialog(listeCourante));
              },
              icon: const Icon(Icons.more_vert_rounded),
            ),
          ]),
          body: tab(listeCourante, context),
          floatingActionButton: FloatingActionButton(
            heroTag: 'plus_score',
            onPressed: () => {
              showDialog(
                context: context,
                builder: (context) => ScoreDialog2(listeCourante, context),
              ),
            },
            backgroundColor: Colors.blue,
            child: const Icon(Icons.add_rounded, color: Colors.white),
          ),
        );
      });
}

Widget tab(l, BuildContext context) {
  var hauteur = MediaQuery.of(context).size.height - 200;
  for (int i = 0; i < l[0].scores.length; i++) {
    hauteur = hauteur + 28.88;
  }
  bool isVisible = true;
  return Padding(
    padding: const EdgeInsets.only(top: 0, left: 5),
    child: SingleChildScrollView(
      child: SizedBox(
        height: hauteur,
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: l.length,
          itemBuilder: (context, index) {
            final j = l[index];
            if (index == l.length - 1) {
              isVisible = false;
            }
            return Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              const Padding(padding: EdgeInsets.all(3)),
              SizedBox(child: colonne(j, context, l)),
              const Padding(padding: EdgeInsets.all(3)),
              Visibility(
                visible: isVisible,
                child: Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black54,
                        ),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                    width: 2,
                  ),
                ),
              ),
            ]);
          },
        ),
      ),
    ),
  );
}

Widget colonne(Joueur j, BuildContext context, List<Joueur> l) {
  var isVisible = false;
  if (j.position.last == 0 && j.scores.isNotEmpty) {
    isVisible = true;
  }
  return Stack(
    children: [
      Positioned(
        left: 18,
        top: 0,
        child: Visibility(
            visible: isVisible,
            child: const Image(
              image: AssetImage('lib/Assets/crown2.png'),
              width: 30,
              height: 25,
            )),
      ),
      Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 22),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 75),
              child: Text(
                j.nom,
                maxLines: 1,
                style: const TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  //color: Color.fromRGBO(j.rgb[0], j.rgb[1], j.rgb[2], 1),
                ),
              ),
            ),
          ),
          const Padding(padding: EdgeInsets.all(2)),
          Text(
            j.sommeScore().toString(),
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              //color: Color.fromRGBO(j.rgb[0], j.rgb[1], j.rgb[2], 1),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 7, bottom: 7),
            child: Container(
              width: 66,
              height: 2,
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black54,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
            ),
          ),
          Column(
            children: j.scores.asMap().keys.map((index) {
              Color couleur = Colors.black;
              if (j.deutschs[index] == 1) {
                couleur = Colors.green;
              } else {
                if (j.deutschs[index] == 2) {
                  couleur = Colors.red;
                }
              }
              return Padding(
                padding: const EdgeInsets.all(4),
                child: Text(
                  j.scores[index].toString(),
                  style: TextStyle(
                    color: couleur,
                    fontSize: 18,
                    //fontWeight: FontWeight.bold,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    ],
  );
}
