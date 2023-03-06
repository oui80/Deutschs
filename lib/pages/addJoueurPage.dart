import 'package:flutter/material.dart';
import '../boxes.dart';
import '../main.dart';
import '../model/Joueur.dart';

class addJoueurPage extends StatefulWidget {
  List<Joueur> listeJoueur;
  final Function callbackFunction;

  addJoueurPage(this.listeJoueur, {Key? key, required this.callbackFunction})
      : super(key: key);

  @override
  State<addJoueurPage> createState() => _addJoueurPageState();
}

class _addJoueurPageState extends State<addJoueurPage> {
  late List<Joueur> listeJoueur;
  late Function callback;

  @override
  void initState() {
    super.initState();
    listeJoueur = widget.listeJoueur;
    callback = widget.callbackFunction;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(listeJoueur[0].partie),
        ),
        body: buildContent(listeJoueur),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            currentIndex = 1;
            callback();
          },
          child: const Icon(Icons.arrow_forward_rounded),
        ));
  }

  Widget buildContent(List<Joueur> l) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 20),
          child: Text("Joueurs", style: TextStyle(
            fontSize: 28,
          ),),
        ),
        Expanded(
          child: SizedBox(
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
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    left: 10,
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
                                        onChanged: (value) =>
                                        {
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
                                onPressed: () {
                                  if (l.length > 1) {
                                    deleteJoueur(l[index], listeJoueur);
                                  } else {
                                    editJoueur(
                                        l[index],
                                        partie,
                                        '',
                                        [],
                                        [],
                                        [0],
                                        []);
                                  };
                                  callback();
                                  setState(() {});
                                },
                                color: Colors.black54,
                                icon: const Icon(Icons.delete_rounded))
                          ]));
                }),
          ),
        ),
        TextButton.icon(
            onPressed: () {
              if(l.length == 1){
                addJoueur(
                    '',
                    partie,
                    l[0].scores,
                    [],
                    [0],
                    [255, 63, 245, 255]);
              }else{
                addJoueur(
                    '',
                    partie,
                    listeScoresMoyens(l),
                    List<int>.generate(l.length, (i) => 0),
                    List<int>.generate(l[0].position.length, (i) => l[0].position.length-1),
                    [255, 63, 245, 255]);
              }
              callback();
              setState(() {

              });
            },
            icon: const Icon(Icons.add_circle_outline_rounded),
            label: const Text('Ajouter joueur'))
      ],
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
    for (int i = 0; i < l.length - 1; i++) {
      somme = somme + l[i].scores[j];
    }
    moyenne = moyenne + [(somme / (l.length - 1)).round()];
    somme = 0;
  }
  return moyenne;
}

void addJoueur(String name, String partie, List<int> scores,
    List<int> deutschs,
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

void deleteJoueur(Joueur j, List<Joueur> l) {
  if (l.length == 1) {
    editJoueur(j, partie, "", [], [], [0], []);
  } else {
    j.delete();

  }
}