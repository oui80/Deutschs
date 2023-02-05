import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../main.dart';
import '../model/Joueur.dart';
import '../pages/addJoueurPage.dart';

class ScoreDialog2 extends StatefulWidget {
final List<Joueur> l;
final BuildContext context;

ScoreDialog2(this.l, this.context);

@override
_ScoreDialog2State createState() => _ScoreDialog2State();
}

class _ScoreDialog2State extends State<ScoreDialog2> {
  late List<Joueur> l;
  late List<bool> deutschs;

  @override
  void initState() {
    super.initState();
    l = widget.l;
    deutschs = List<bool>.generate(widget.l.length, (i) => false);
  }

  @override
  Widget build(BuildContext context) {
    var score = List<int>.generate(l.length, (i) => 0);

    return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Dialog(
          insetPadding: const EdgeInsets.all(25),
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: SizedBox(
              height: MediaQuery
                  .of(context)
                  .size
                  .height / 2.2,
              child: Column(
                children: [
                  //------------------------TITRE-------------------------------
                  const Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 25, top: 10),
                      child: Text(
                        'Ajout des Scores',
                        style: TextStyle(
                          fontSize: 25,
                        ),
                      ),
                    ),
                  ),
                  //------------------------DEUTSCHS----------------------------
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 10,
                    ),
                    child: Column(
                      children: [
                        const Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: EdgeInsets.only(
                              bottom: 5,
                            ),
                            child: Text(
                              'Deutschs',
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: ToggleButtons(
                              isSelected: deutschs,
                              selectedColor: Colors.blue,
                              fillColor: const Color.fromRGBO(33, 150, 255,
                                  0.6),
                              renderBorder: false,
                              children: l.map((joueur) =>
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 6, right: 6),
                                    child: Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                            border: Border.all(width: 2),
                                            borderRadius:
                                            BorderRadius.circular(5)),
                                        child: ConstrainedBox(
                                            constraints: BoxConstraints(
                                                maxWidth:
                                                (MediaQuery
                                                    .of(context)
                                                    .size
                                                    .width -
                                                    210) /
                                                    l.length),
                                            child: Text(
                                              joueur.nom.toString(),
                                              maxLines: 1,
                                              style: const TextStyle(
                                                fontSize: 20,
                                              ),
                                            ))),
                                  ),).toList(),
                              onPressed: (index) {
                                setState(() {
                                  for (int i = 0; i < deutschs.length; i++) {
                                    if (i == index) {
                                      deutschs[i] = !deutschs[i];
                                    } else {
                                      deutschs[i] = false;
                                    }
                                  }
                                });
                              }),
                        )
                      ],
                    ),
                  ),
                  //------------------------SCORES------------------------------
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 10,
                    ),
                    child: Column(
                      children: [
                        const Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: EdgeInsets.only(
                              bottom: 5,
                            ),
                            child: Text(
                              'Scores',
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                        TextFieldsScores(l, score),
                      ],
                    ),
                  ),
                  Expanded(child: Container()),
                  //------------------------BUTTONS-----------------------------
                  QuitButtons(context, l, deutschs, score)
                ],
              ),
            ),
          ),
        ));
  }


//------------------------------SCORES------------------------------------------
  Widget TextFieldsScores(List<Joueur> l, List<int> score) {
    return SizedBox(
      height: 70,
      //width: (MediaQuery.of(context).size.width - 50) / listeJoueur.length,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: l.length,
          itemBuilder: (context, index) {
            return ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: (MediaQuery
                    .of(context)
                    .size
                    .width - 78) / l.length,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  onChanged: (value) =>
                  {
                    score[index] = int.parse(value),
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    //hintText: score[index].toString(),
                  ),
                ),
              ),
            );
          }),
    );
  }

//------------------------------BUTTONS-----------------------------------------
  Widget QuitButtons(BuildContext context, List<Joueur> l, List<bool> deutschs,
      List<int> score) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 5),
          child: TextButton.icon(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.delete_rounded),
            label: const Text('annuler'),
          ),
        ),
        Expanded(
          child: Container(),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 5),
          child: TextButton.icon(
              label: const Text('valider'),
              icon: const Icon(Icons.add),
              onPressed: () {
                setState(() {
                  edition(l, score, deutschs, partie);
                  Navigator.of(context).pop();
                });

                //on regarde si quelqu'un a deutsch
                for (int i = 0; i < deutschs.length; i++) {
                  if (deutschs[i]) {}
                }
              }),
        ),
      ],
    );
  }

  void edition(List<Joueur> l, List<int> score, List<bool> deutschs, String partie) {
    int joueurQuiDeutsch = 0;
    int scoremin = score[0];

    for (int i = 0; i < score.length; i++) {
      if (score[i] < scoremin) {
        scoremin = score[i];
      }
      if (deutschs[i]) {
        joueurQuiDeutsch = i;
      }
      editJoueur(
          l[i],
          partie,
          l[i].nom,
          l[i].scores + [score[i]],
          l[i].deutschs + [deutschs[i]],
          l[i].position,
          l[i].color);
    }

    //on change le dernier score du deutscher
    int last = l[0].scores.length - 1;

    if (score[joueurQuiDeutsch] == scoremin) {
      //si celui qui  a deutsch a le plus petit score
      l[joueurQuiDeutsch].scores[last] = l[joueurQuiDeutsch].scores[last] - 5;
    } else {
      l[joueurQuiDeutsch].scores[last] = l[joueurQuiDeutsch].scores[last] + 5;
    };
    editJoueur(
        l[joueurQuiDeutsch],
        partie,
        l[joueurQuiDeutsch].nom,
        l[joueurQuiDeutsch].scores,
        l[joueurQuiDeutsch].deutschs,
        l[joueurQuiDeutsch].position,
        l[joueurQuiDeutsch].color);
  }
}