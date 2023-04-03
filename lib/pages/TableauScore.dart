import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:Dutch/Widgets/ModifyDialog.dart';
import '../Widgets/ScoreDialog2.dart';
import '../Widgets/neurimrophic.dart';
import '../boxes.dart';
import '../main.dart';
import '../model/Joueur.dart';
import 'addJoueurPage.dart';

Widget TableauScore() {
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

        if(listeCourante.isEmpty){
          return SafeArea(
            child: Scaffold(
              backgroundColor: myWhite,
              appBar: AppBar(
                toolbarHeight: 70,
                title: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                        'Tableau des Scores',
                        style: TextStyle(
                            color: tan2,
                            fontSize: 25,
                            letterSpacing: 1.5,
                            fontWeight: FontWeight.normal),
                      ),
                      Expanded(child: Container()),
                      Align(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                          color: mygrey,
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) => ModifyDialog(listeCourante));
                          },
                          icon: const Icon(Icons.more_vert_rounded,size: 30,),
                        ),
                      ),
                    ],
                  ),
                ),
                backgroundColor: myWhite,
              ),
              body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Appuyer sur le bouton", style: TextStyle(
                          color: mygrey,
                          fontSize: 18
                      ),),
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text("Nouvelle partie", style: TextStyle(
                            color: mygrey,
                            fontSize: 18
                        ),),
                      ),
                      Text("pour créez votre première partie", style: TextStyle(
                          color: mygrey,
                          fontSize: 18
                      ),),
                    ],
                  )),
            ),
          );
        }else{
          return SafeArea(
            child: Scaffold(
              backgroundColor: myWhite,
              appBar: AppBar(
                toolbarHeight: 70,
                title: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child:
                      Text(
                        'Tableau des Scores',
                        style: TextStyle(
                            color: tan2,
                            fontSize: 25,
                            letterSpacing: 1.5,
                            fontWeight: FontWeight.normal),
                  ),
                ),
                backgroundColor: myWhite,
              ),
              body: tab(listeCourante, context),

              floatingActionButton: Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15.0,bottom: 2),
                      child: ClipOval(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 1.5, sigmaY: 1.5),
                          child: SizedBox(
                            height: 70,
                            width: 70,
                            child: IconButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) => ModifyDialog(listeCourante));
                                },
                                icon: NeumorphicIcon(
                                  Icons.more_vert_rounded,
                                  style: NeumorphicStyle(
                                    intensity: 1,
                                    surfaceIntensity: 0.04,
                                    depth: 4,
                                    shape: NeumorphicShape.flat,
                                    color: tan2,
                                  ),
                                  size: 48,
                                )),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 12.0,bottom: 2),
                      child: ClipOval(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 1.5, sigmaY: 1.5),
                          child: SizedBox(
                            height: 70,
                            width: 70,
                            child: IconButton(
                                onPressed: () => {
                                  showDialog(
                                    context: context,
                                    builder: (context) =>
                                        ScoreDialog2(listeCourante, context),
                                  ),
                                },
                                icon: NeumorphicIcon(
                                  Icons.add_rounded,
                                  style: NeumorphicStyle(
                                    intensity: 1,
                                    surfaceIntensity: 0.04,
                                    depth: 4,
                                    shape: NeumorphicShape.flat,
                                    color: tan2,
                                  ),
                                  size: 57,
                                )),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              ),
          );
        }


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
    child: ScrollConfiguration(
      behavior: MyBehavior(),
      child: SingleChildScrollView(
        child: SizedBox(
          height: hauteur,
          child: ScrollConfiguration(
            behavior: MyBehavior(),
            child: ListView.builder(
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
                      child: myContainer(
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: mygrey,
                              ),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10))),
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                ]);
              },
            ),
          ),
        ),
      ),
    ),
  );
}

Widget colonne(Joueur j, BuildContext context, List<Joueur> l) {
  var isVisible = false;
  if (j.position.isNotEmpty) {
    if (j.position.last == 0 && j.scores.isNotEmpty) {
      isVisible = true;
    }
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
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: tan1,
                  fontSize: 19,
                  letterSpacing: 2,
                  //color: Color.fromRGBO(j.rgb[0], j.rgb[1], j.rgb[2], 1),
                ),
              ),
            ),
          ),
          const Padding(padding: EdgeInsets.all(2)),
          Text(
            j.sommeScore().toString(),
            style: TextStyle(
              color: mygrey,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              //color: Color.fromRGBO(j.rgb[0], j.rgb[1], j.rgb[2], 1),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 7, bottom: 7),
            child: myContainer(
              Container(
                width: 66,
                height: 2,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: mygrey,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
              ),
            ),
          ),
          Column(
            children: j.scores.asMap().keys.map((index) {
              Color couleur = mygrey;
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
