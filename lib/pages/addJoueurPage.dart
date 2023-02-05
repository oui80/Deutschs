import 'package:flutter/material.dart';
import '../boxes.dart';
import '../main.dart';
import '../model/Joueur.dart';

Widget addJoueurPage(List<Joueur> listeJoueur, context) {

  Widget ListeJoueur(List<Joueur> l) {

    return Expanded(
      child: SizedBox(
        //height: 200,
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: l.length,
            itemBuilder: (context, index) {
              return Padding(
                  padding: const EdgeInsets.only(left: 8, top: 8, right: 8),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Expanded(
                          child: SizedBox(
                            //width: MediaQuery.of(context).size.width-50,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                left: 5,
                                top: 5,
                                right: 5,
                              ),
                              child: Card(
                                  elevation: 3,
                                  shadowColor: Colors.grey,
                                  child: TextField(
                                    //cursorColor: Color.fromARGB(l[index].color[0],l[index].color[1],l[index].color[2],l[index].color[3]),
                                    cursorHeight: 20,
                                    textAlignVertical:
                                    TextAlignVertical.center,
                                    onChanged: (value) => {
                                      editJoueur(
                                          l[index],
                                          partie,
                                          value,
                                          l[index].scores,
                                          l[index].deutschs,
                                          l[index].position,
                                          l[index].color),
                                      //print(p.l[index].toString()),
                                    },
                                    style: const TextStyle(
                                      //color: Color.fromARGB(l[index].color[0], l[index].color[1], l[index].color[2], l[index].color[3]),
                                    ),
                                    decoration: InputDecoration(
                                      border: const OutlineInputBorder(),
                                      hintText: surnom(l, index),
                                    ),
                                  )),
                            ),
                          ),
                        ),
                        IconButton(
                            onPressed: () => deleteJoueur(l[index],listeJoueur),
                            color: Colors.black54,
                            icon: const Icon(Icons.delete_rounded))
                      ]));
            }),
      ),
    );
  }

  Widget buildContent() {

    return Column(
      children: [
        ListeJoueur(listeJoueur),
        TextButton.icon(
            onPressed: () {
              addJoueur(
                  '',
                  //listeScoresMoyens(partie.l),
                  partie,
                  [],
                  //List<bool>.generate(Boxes.getparties().length, (i) => false),
                  [],
                  [],
                  [255, 63, 245, 255]);
            },
            icon: const Icon(Icons.add_circle_outline_rounded),
            label: const Text('Ajouter joueur'))
      ],
    );
  }

  return Scaffold(
      appBar: AppBar(
        title: Text(listeJoueur[0].partie),
      ),
      body: buildContent(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          currentIndex = 1;
        },
        child: const Icon(Icons.arrow_forward_rounded),
      ));
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
    for (int i = 0; i < l.length - 1; i++) {
      somme = somme + l[i].scores[j];
    }
    moyenne = moyenne + [(somme / (l.length - 1)).round()];
    somme = 0;
  }
  return moyenne;
}

void setPositionJoueurs(List<Joueur> l) {
  List<List<int>> liste = sommeScoreJ(l);
  ranger(liste);
  setPosition(liste, l);
}

void setPosition(List<List<int>> liste, List<Joueur> l) {
  for (int i = 0; i < liste.length; i++) {
    //i index de manche      liste[i] == liste des scores dans partie.l'ordre croissant
    for (int j = 0; j < liste[i].length; j++) {
      //j == index d'une somme de score rangée dans partie.l'ordre croissant
      for (int k = 0; k < l.length; k++) {
        //k index d'un joueur
        if (liste[i][j] == l[k].scoreJusqua(i)) {
          //si la somme du score du joueur à la manche i est a partie.l'index j
          l[k].position = l[k].position + [j];
        }
      }
    }
  }
}

void ranger(List<List<int>> liste) {
  for (int i = 0; i < liste.length; i++) {
    liste[i].sort();
  }
}

List<List<int>> sommeScoreJ(List<Joueur> l) {
  List<List<int>> sommeScoreJ = [];
  List<int> scoreManche = [];
  for (int j = 0; j < l[0].scores.length; j++) {
    for (int i = 0; i < l.length; i++) {
      scoreManche = scoreManche + [l[i].scoreJusqua(j)];
    }
    sommeScoreJ = sommeScoreJ + [scoreManche];
    scoreManche = [];
  }
  return sommeScoreJ;
}

void addJoueur(String name, String partie, List<int> scores, List<bool> deutschs,
    List<int> position, List<int> color) {

  Joueur j = Joueur(name,partie, scores, deutschs, position, color);

  final box = Boxes.getparties();
  box.add(j);
  print(box.values.toList().toString());

  //print(partie.l);
  //partie.save();
}

void editJoueur(Joueur j, String partie, String nom, List<int> scores, List<bool> deutschs, List<int> position, List<int> color) {
  j.nom = nom;
  j.partie = partie;
  j.scores = scores;
  j.deutschs = deutschs;
  j.position = position;
  j.color = color;

  j.save();
}

void deleteJoueur(Joueur j,List<Joueur> l) {
  if(l.length > 1){
    j.delete();
  }else{
    addJoueur('', partie, [], [], [], []);
    j.delete();
  }
}