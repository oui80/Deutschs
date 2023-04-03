import 'package:Dutch/Widgets/neurimrophic.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import '../boxes.dart';
import '../generated/l10n.dart';
import '../main.dart';
import '../model/Joueur.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

void addJoueur(String name, String partie, List<int> scores, List<int> deutschs,
    List<int> position, List<int> color) {
  Joueur j = Joueur(name, partie, scores, deutschs, position, color);

  final box = Boxes.getparties();
  box.add(j);
}

void editJoueur(Joueur j, String partie, String nom, List<int> scores,
    List<int> deutschs, List<int> position, List<int> color) {
  j.nom = nom;
  j.partie = partie;
  j.scores = scores;
  j.deutschs = deutschs;
  j.position = position;
  j.color = color;

  j.save();
}

void deleteJoueur(Joueur j, List<Joueur> l,Function callback) {
    j.delete();
    if(Boxes.getliste().isEmpty){
      currentIndex = 2;
      callback();
    }
}


class addJoueurPage extends StatefulWidget {
  final Function callbackFunction;

  addJoueurPage({Key? key, required this.callbackFunction}) : super(key: key);

  @override
  State<addJoueurPage> createState() => _addJoueurPageState();
}

class _addJoueurPageState extends State<addJoueurPage> {
  late Function callback;

  @override
  void initState() {
    super.initState();
    callback = widget.callbackFunction;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box<Joueur>>(
        valueListenable: Boxes.getparties().listenable(),
        builder: (context, box, _) {
          List<Joueur> listeJoueur = box.values.toList().cast<Joueur>();



          printlog(listeJoueur.toString());

          //on prend uniquement les joueurs qui sont de la partie selectionnée
          List<Joueur> listeCourante = [];
          for (int i = 0; i < listeJoueur.length; i++) {
            if (listeJoueur[i].partie == partieCourante) {
              listeCourante = listeCourante + [listeJoueur[i]];
            }
          }
          return Scaffold(
              appBar: AppBar(
                toolbarHeight: 70,
                title: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(S.of(context).Joueurs,
                    style: TextStyle(
                        color: tan2,
                        fontSize: 25,
                        letterSpacing: 1.5,
                        fontWeight: FontWeight.normal),
                  ),
                ),
                backgroundColor: myWhite,
              ),
              backgroundColor: myWhite,
              body: buildContent(listeCourante)
          );
        });
  }

  Widget buildContent(List<Joueur> l) {
    return SafeArea(
      child: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top:15.0),
                child: Text(
                  partieCourante,
                  style: TextStyle(
                      color: mygrey1,
                      fontSize: 18,
                      letterSpacing: 1.5,
                      fontWeight: FontWeight.normal),
                ),
              ),
              Expanded(
                child: SizedBox(
                  child: ScrollConfiguration(
                    behavior: MyBehavior(),
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: l.length+1,
                        itemBuilder: (context, index) {
                          if (index != l.length ) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                  left: 8, top: 8, right: 8),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Expanded(
                                      child: SizedBox(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                            left: 10,
                                            top: 13,
                                            right: 5,
                                          ),
                                          child: myContainer(TextField(
                                            style: TextStyle(color: mygrey),
                                            inputFormatters: [
                                              FilteringTextInputFormatter.allow(RegExp(r'^[^$]*$'))
                                            ],
                                            //cursorColor: Color.fromARGB(l[index].color[0],l[index].color[1],l[index].color[2],l[index].color[3]),
                                            onChanged: (value) => {
                                              editJoueur(
                                                  l[index],
                                                  l[index].partie,
                                                  value,
                                                  l[index].scores,
                                                  l[index].deutschs,
                                                  l[index].position,
                                                  l[index].color),
                                            },

                                            decoration: InputDecoration(
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: myWhite),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: myWhite),
                                                ),
                                                fillColor: myWhite,
                                                filled: true,
                                                hintText:
                                                    "  ${surnom(l, index)}",
                                                hintStyle:
                                                    TextStyle(color: mygrey1)),
                                          )),
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          deleteJoueur(l[index], l,callback);

                                        },
                                        color: tan2,
                                        icon: NeumorphicIcon(
                                          Icons.delete_rounded,
                                          style: NeumorphicStyle(
                                            intensity: 1,
                                            surfaceIntensity: 0.04,
                                            depth: 4,
                                            shape: NeumorphicShape.flat,
                                            color: mygrey,
                                          ),
                                          size: 28,
                                        ))
                                  ]));
                          } else {
                            return const SizedBox(height: 80);
                          }
                        }),
                  ),
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: myContainer(
                Container(
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
                        if (l.length <= 1) {
                          addJoueur('', partieCourante, [], [], [], []);
                        } else {
                          addJoueur(
                              '',
                              partieCourante,
                              listeScoresMoyens(l),
                              List<int>.generate(
                                  l[0].deutschs.length, (i) => 0),
                              List<int>.generate(
                                  l[0].position.length, (j) => l.length),
                              [255, 63, 245, 255]);
                        }
                      },
                      icon: Icon(
                        Icons.add_circle_outline_rounded,
                        color: myWhite,
                      ),
                      label: Text('Ajouter joueur',
                          style: TextStyle(color: myWhite))),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

String surnom(List<Joueur> l, int index) {
  if (l[index].nom == '') {
    return 'Surnom ${index + 1}';
  } else {
    return l[index].nom;
  }
}

List<int> listeScoresMoyens(List<Joueur> l) {
  List<int> moyenne = [];
  double somme = 0;
  for (int j = 0; j < l[0].scores.length; j++) {
    for (int i = 0; i < l.length; i++) {
      somme = somme + l[i].scores[j];
    }
    moyenne = moyenne + [(somme / (l.length - 1)).round()];
    somme = 0;
  }
  return moyenne;
}
