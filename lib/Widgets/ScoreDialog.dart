import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../main.dart';
import '../model/Joueur.dart';

Widget ScoreDialog(numPartie,context) {
  var score = List<int>.generate(l.length, (i) => 0);
  var deutschs = List<bool>.generate(l.length, (i) => false);

  void editJoueur(Joueur j, String nom, List<int> scores, List<bool> deutschs,
      List<int> position, List<int> color) {
    j.nom = nom;
    j.scores = scores;
    j.deutschs = deutschs;
    j.position = position;
    j.color = color;

    j.save();
  }

  List<String> liste_nom(List<Joueur> l) {
    List<String> res = [];
    for (int i = 0; i < l.length; i++) {
      res = res + [l[i].nom];
    }
    return res;
  }

  void edition(List<Joueur> l) {
    int joueur_qui_deutsch = 0;
    int scoremin = score[0];
    for (int i = 0; i < score.length; i++) {
      if (score[i] < scoremin) {
        scoremin = score[i];
      }
      ;
      if (deutschs[i]) {
        joueur_qui_deutsch = i;
      }
      ;
      editJoueur(l[i], l[i].nom, l[i].scores + [score[i]],
          l[i].deutschs + [deutschs[i]], l[i].position, l[i].color);
    }
    ;

    //on change le dernier score du deutscher
    int last = l[0].scores.length - 1;

    if (score[joueur_qui_deutsch] == scoremin) {
      //si celui qui  a deutsch a le plus petit score
      l[joueur_qui_deutsch].scores[last] =
          l[joueur_qui_deutsch].scores[last] - 5;
    } else {
      l[joueur_qui_deutsch].scores[last] =
          l[joueur_qui_deutsch].scores[last] + 5;
    }
    ;
    //l[joueur_qui_deutsch].scores[last] = score[joueur_qui_deutsch];
    //editJoueur(l[joueur_qui_deutsch],l[joueur_qui_deutsch].nom, l[joueur_qui_deutsch].scores,l[joueur_qui_deutsch].deutschs,l[joueur_qui_deutsch].position,l[joueur_qui_deutsch].color);
  }


  List<String> listeNoms = liste_nom(l);

  //print(score.toString());
  bool adeutsch = false;
  return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: Dialog(
          insetPadding: const EdgeInsets.all(25),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0)),
          child: SizedBox(
            height: 485,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 2, bottom: 5),
                    child: Text(
                      'Ajout Score',
                      style: TextStyle(
                        fontSize: 23,
                      ),
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      width: (MediaQuery
                          .of(context)
                          .size
                          .width - 40),
                      child: Column(
                        children: [
                          Column(
                            children: [
                              const Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'Deutsch',
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ToggleButtons(
                                  isSelected: deutschs,
                                  selectedColor: Colors.black,
                                  fillColor: const Color.fromRGBO(
                                      33, 150, 220, 0.5),
                                  renderBorder: false,
                                  children: l
                                      .map(
                                        (joueur) =>
                                        Padding(
                                          padding:
                                          const EdgeInsets.all(3),
                                          child: Container(
                                              padding:
                                              const EdgeInsets.all(6),
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      width: 2),
                                                  borderRadius:
                                                  BorderRadius
                                                      .circular(5)),
                                              child: ConstrainedBox(
                                                  constraints: BoxConstraints(
                                                      maxWidth: (MediaQuery
                                                          .of(
                                                          context)
                                                          .size
                                                          .width -
                                                          210) /
                                                          l.length),
                                                  child: Text(
                                                    joueur.nom.toString(),
                                                    maxLines: 1,
                                                    //overflow: TextOverflow,
                                                    style:
                                                    const TextStyle(
                                                      fontSize: 20,
                                                    ),
                                                  ))),
                                        ),
                                  )
                                      .toList(),
                                  onPressed: (int index) {
                                    for (int i = 0;
                                    i < deutschs.length;
                                    i++) {
                                      if (i == index) {
                                        deutschs[i] = !deutschs[i];
                                        adeutsch = deutschs[i];
                                      } else {
                                        deutschs[i] = false;
                                      }
                                    }
                                    ;
                                  },
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              const Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'Scores',
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 80,
                                //width: (MediaQuery.of(context).size.width - 50) / l.length,
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    physics:
                                    const NeverScrollableScrollPhysics(),
                                    itemCount: l.length,
                                    itemBuilder: (context, index) {
                                      return ConstrainedBox(
                                        constraints: BoxConstraints(
                                          maxWidth:
                                          (MediaQuery
                                              .of(context)
                                              .size
                                              .width -
                                              78) /
                                              l.length,
                                        ),
                                        child: Padding(
                                          padding:
                                          const EdgeInsets.all(8.0),
                                          child: TextField(
                                            keyboardType:
                                            TextInputType.number,
                                            inputFormatters: [
                                              FilteringTextInputFormatter
                                                  .digitsOnly
                                            ],
                                            onChanged: (value) =>
                                            {
                                              score[index] =
                                                  int.parse(value),
                                            },
                                            decoration:
                                            const InputDecoration(
                                              border:
                                              OutlineInputBorder(),
                                              //hintText: score[index].toString(),
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                              ),
                            ],
                          ),
                          Expanded(child: Container()),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 5, left: 5),
                                child: TextButton.icon(
                                  onPressed: () =>
                                      Navigator.of(context).pop(),
                                  icon: const Icon(Icons.delete_rounded),
                                  label: const Text('annuler'),
                                ),
                              ),
                              Expanded(
                                child: Container(),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 5, right: 5),
                                child: TextButton.icon(
                                    label: const Text('valider'),
                                    icon: const Icon(Icons.add),
                                    onPressed: () {
                                      edition(l);
                                      Navigator.of(context).pop();
                                      if (adeutsch) {}
                                      ;
                                    }),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
      )
  );
}