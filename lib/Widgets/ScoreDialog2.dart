import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../main.dart';
import '../model/Joueur.dart';
import '../pages/HistoricPage.dart';
import '../pages/addJoueurPage.dart';
import 'neurimrophic.dart';

class ScoreDialog2 extends StatefulWidget {
  final List<Joueur> l;
  final BuildContext context;

  const ScoreDialog2(this.l, this.context, {super.key});

  @override
  _ScoreDialog2State createState() => _ScoreDialog2State();
}

class _ScoreDialog2State extends State<ScoreDialog2> {
  late List<Joueur> l;
  late List<bool> deutschs;
  late List<int> listeScore;

  @override
  void initState() {
    super.initState();
    l = widget.l;
    deutschs = List<bool>.generate(l.length, (i) => false);
    listeScore = List<int>.generate(l.length, (i) => 0);
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: Center(
        child: SingleChildScrollView(
          child: SizedBox(
            child: Column(
              children: [
                Dialog(
                  insetPadding: const EdgeInsets.all(33),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, top: 10, bottom: 10),
                    child: Column(
                      children: [
                        //------------------------TITRE-------------------------------
                        Align(
                          alignment: Alignment.topCenter,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 12, top: 8),
                            child: Text(
                              'Ajout des Scores',
                              style: TextStyle(
                                fontSize: 25,
                                color: tan1,
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topCenter,
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(9),
                                child: Text(
                                  'Dutch',
                                  style: TextStyle(
                                    fontSize: 19,
                                    color: tan1,
                                  ),
                                ),
                              ),
                              Expanded(child: Container()),
                              Padding(
                                padding: const EdgeInsets.only(right: 12),
                                child: Text(
                                  'Score',
                                  style: TextStyle(
                                    fontSize: 19,
                                    color: tan1,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        ConstrainedBox(
                          constraints: BoxConstraints(
                            maxHeight: MediaQuery.of(context).size.height - 470,
                          ),
                          child: ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: l.length,
                              itemBuilder: (context, index) {
                                if (deutschs[index]) {
                                  return DeutschEtScore(
                                      index, context, tan1, 3.0);
                                } else {
                                  return DeutschEtScore(
                                      index, context, mygrey, 1.0);
                                }
                              }),
                        ),
                        //------------------------BUTTONS-----------------------------
                        QuitButtons(context, l, deutschs, listeScore)
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row DeutschEtScore(
      int index, BuildContext context, Color couleur, double epaisseur) {
    return Row(
      children: [
        Expanded(
          flex: 6,
          child: GestureDetector(
            onTap: () {
              for (int i = 0; i < deutschs.length; i++) {
                deutschs[i] = false;
              }
              deutschs[index] = !deutschs[index];
              setState(() {});
            },
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                border: Border.all(color: couleur, width: epaisseur),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  l[index].nom.toString(),
                  maxLines: 1,
                  style: TextStyle(fontSize: 19, color: tan),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 40,
              child: TextField(
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 20),
                onChanged: (value) => {
                  listeScore[index] = int.parse(value),
                },
                cursorColor: tan2,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: mygrey,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: tan1, width: 2.0),
                  ),
                  contentPadding: const EdgeInsets.all(3.0),
                  //hintText: listeScore[index].toString(),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

//------------------------------BUTTONS-----------------------------------------
  Widget QuitButtons(BuildContext context, List<Joueur> l, List<bool> deutschs,
      List<int> score) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 5),
      child: Row(
        children: [
          myContainer(Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                tan2,
                tan1,
              ],
            )),
            child: TextButton.icon(
              onPressed: () {
                Navigator.of(context).pop();
              },
              label: Text(
                "Annuler ",
                style: TextStyle(color: myWhite, fontSize: 12),
              ),
              icon: Icon(
                Icons.delete_rounded,
                color: myWhite,
                size: 16,
              ),
            ),
          )),
          Expanded(
            child: Container(),
          ),
          myContainer(Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                tan2,
                tan1,
              ],
            )),
            child: TextButton.icon(
              onPressed: () {
                //on regarde si quelqu'un a deutsch
                for (int i = 0; i < deutschs.length; i++) {
                  if (deutschs[i]) {
                    setState(() {
                      edition(l, score, deutschs);
                      setPosition(l);
                      Navigator.of(context).pop();
                      upload();
                    });
                  }
                }
              },
              label: Text(
                "Valider ",
                style: TextStyle(color: myWhite, fontSize: 12),
              ),
              icon: Icon(
                Icons.add,
                color: myWhite,
                size: 16,
              ),
            ),
          )),
        ],
      ),
    );
  }

  void edition(List<Joueur> l, List<int> score, List<bool> deutschs) {
    int joueurQuiDeutsch = deutschs.indexOf(true);

    int valide = 1;
    for (int i = 0; i < l.length; i++) {
      l[i].deutschs = l[i].deutschs + [0];
      if (score[i] < score[joueurQuiDeutsch]) {
        valide = 2;
        l[i].deutschs.last = 3;
      }
      editJoueur(l[i], l[i].partie, l[i].nom, l[i].scores + [score[i]],
          l[i].deutschs, l[i].position + [0], l[i].color);
    }

    if (valide == 1) {
      l[joueurQuiDeutsch].scores.last = l[joueurQuiDeutsch].scores.last - 5;
      l[joueurQuiDeutsch].deutschs.last = 1;
    } else {
      l[joueurQuiDeutsch].scores.last = l[joueurQuiDeutsch].scores.last + 5;
      l[joueurQuiDeutsch].deutschs.last = 2;
    }
    editJoueur(
        l[joueurQuiDeutsch],
        l[joueurQuiDeutsch].partie,
        l[joueurQuiDeutsch].nom,
        l[joueurQuiDeutsch].scores,
        l[joueurQuiDeutsch].deutschs,
        l[joueurQuiDeutsch].position,
        l[joueurQuiDeutsch].color);
    printlog(l.toString());
  }
}

void setPosition(List<Joueur> l) {
  List<int> res = [];
  for (int i = 0; i < l.length; i++) {
    if (!res.contains(l[i].sommeScore())) {
      res = res + [l[i].sommeScore()];
    }
  }
  res.sort();

  for (int j = 0; j < l.length; j++) {
    //pour tous les joueurs
    int k = 0;
    while (k < res.length && l[j].sommeScore() != res[k]) {
      //on parcour res tant que qu'on a pas trouver le bon
      k++;
    }
    l[j].position.last = k;
  }
}
