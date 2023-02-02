import 'package:flutter/material.dart';
import '../boxes.dart';
import '../main.dart';
import '../model/Joueur.dart';
import '../model/Partie.dart';
import 'HistoricPage.dart';

Widget addJoueurPage(Partie partie, context) {

  void addJoueur(String name, List<int> scores, List<bool> deutschs,
    List<int> position, List<int> color) {
    print(partie.l);

    String nom = partie.nom;

    List<Joueur> tempList = partie.l;
    tempList.add(Joueur(name, scores, deutschs, position, color));
    partie.l = tempList;
    partie.nom = nom;
    partie.save();

    final box = Boxes.getparties();
    box.put(partie.id,partie);
    print(box.values.toList().toString());

    //print(partie.l);
    //partie.save();
  }

  void editJoueur(Joueur j, int indexjoueur, String nom, List<int> scores, List<bool> deutschs,
      List<int> position, List<int> color) {
    j.nom = nom;
    j.scores = scores;
    j.deutschs = deutschs;
    j.position = position;
    j.color = color;

    partie.l[indexjoueur] = j;
    partie.save();
    //editPartie(partie, l, nom);
  }

  void deleteJoueur(int index) {
    partie.l.removeAt(index);
  }

  Widget ListeJoueur(Partie p) {
    return Expanded(
      child: SizedBox(
        //height: 200,
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: p.l.length,
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
                                    //cursorColor: Color.fromARGB(p.l[index].color[0],p.l[index].color[1],p.l[index].color[2],p.l[index].color[3]),
                                    cursorHeight: 20,
                                    textAlignVertical:
                                    TextAlignVertical.center,
                                    onChanged: (value) => {
                                      editJoueur(
                                          p.l[index],
                                          index,
                                          value,
                                          p.l[index].scores,
                                          p.l[index].deutschs,
                                          p.l[index].position,
                                          p.l[index].color),
                                      //print(p.l[index].toString()),
                                    },
                                    style: const TextStyle(
                                      //color: Color.fromARGB(p.l[index].color[0], p.l[index].color[1], p.l[index].color[2], p.l[index].color[3]),
                                    ),
                                    decoration: InputDecoration(
                                      border: const OutlineInputBorder(),
                                      hintText: surnom(p.l, index),
                                    ),
                                  )),
                            ),
                          ),
                        ),
                        IconButton(
                            onPressed: () => deleteJoueur(index),
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
        ListeJoueur(partie),
        TextButton.icon(
            onPressed: () {
              addJoueur(
                  'jean',
                  //listeScoresMoyens(partie.l),
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
        title: Text(partie.nom),
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

void setPositionJoueurs(Partie partie) {
  List<List<int>> liste = sommeScoreJ(partie);
  ranger(liste);
  setPosition(liste, partie);
}

void setPosition(List<List<int>> liste, Partie partie) {
  for (int i = 0; i < liste.length; i++) {
    //i index de manche      liste[i] == liste des scores dans partie.l'ordre croissant
    for (int j = 0; j < liste[i].length; j++) {
      //j == index d'une somme de score rangée dans partie.l'ordre croissant
      for (int k = 0; k < partie.l.length; k++) {
        //k index d'un joueur
        if (liste[i][j] == partie.l[k].scoreJusqua(i)) {
          //si la somme du score du joueur à la manche i est a partie.l'index j
          partie.l[k].position = partie.l[k].position + [j];
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

List<List<int>> sommeScoreJ(Partie partie) {
  List<List<int>> sommeScoreJ = [];
  List<int> scoreManche = [];
  for (int j = 0; j < partie.l[0].scores.length; j++) {
    for (int i = 0; i < partie.l.length; i++) {
      scoreManche = scoreManche + [partie.l[i].scoreJusqua(j)];
    }
    sommeScoreJ = sommeScoreJ + [scoreManche];
    scoreManche = [];
  }
  return sommeScoreJ;
}
