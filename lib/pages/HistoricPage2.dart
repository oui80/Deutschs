import 'package:Dutch/model/Utilisateur.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import '../boxes.dart';
import '../main.dart';
import '../model/Joueur.dart';
import 'addJoueurPage.dart';

//ranger liste par postion
List<Joueur> ranger(List<Joueur> l) {
  l.sort((a, b) => a.position.last.compareTo(b.position.last));;
  return l;
}

class HistoricPage2 extends StatefulWidget {

  final Function callbackFunction;

  const HistoricPage2({Key? key, required this.callbackFunction})
      : super(key: key);

  @override
  State<HistoricPage2> createState() => _HistoricPage2State();
}

class _HistoricPage2State extends State<HistoricPage2> {
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

          if (listeJoueur.isEmpty) {
            addJoueur('', partieCourante, [], [], [0], []);
            addJoueur('', partieCourante, [], [], [0], []);
            addJoueur('', partieCourante, [], [], [0], []);
            addJoueur('', partieCourante, [], [], [0], []);
          }

          return Construire(listeJoueur,context);});
  }

  Scaffold Construire(List<Joueur> l, BuildContext context) {

    List<String> nomParties = [];
    for (int i = 0; i < l.length; i++) {
      if (!nomParties.contains(l[i].partie)) {
        nomParties = nomParties + [l[i].partie];
      }
    }

    List<List<Joueur>> listeJoueur = [];
    List<Joueur> temps = [];
    for (int j = 0; j < nomParties.length; j++) {
      temps = [];
      for (int i = 0; i < l.length; i++) {
        if (l[i].partie == nomParties[j]) {
          temps = temps + [l[i]];
        }
      }
      listeJoueur = listeJoueur + [temps];
    }

    String nom = "partie ";
    return Scaffold(
      appBar: AppBar(
        title: const Text('Historique des parties'),
      ),
      body: Column(
        children: [
          Expanded(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: nomParties.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              partieCourante = nomParties[index];
                              currentIndex = 0;
                              callback();
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Card(
                                child: Column(children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      nomParties[index],
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(15),
                                    child: CardPartie(listeJoueur[index]),
                                  )
                                ]),
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) => SupPartieDialog(l,
                                      index, nomParties, context));
                            },
                            icon: const Icon(Icons.more_vert_rounded))
                      ],
                    );
                  }),
            ),
          ),
          TextButton.icon(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text("Nouvelle Partie",
                        style: TextStyle(fontSize: 20)),
                    content: SizedBox(
                      height: 130,
                      child: Column(
                        children: [
                          TextField(
                            onChanged: (value) {
                              nom = value;
                            },
                            decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                hintText: nom),
                          ),
                          Expanded(child: Container()),
                          TextButton.icon(
                            onPressed: () {
                              if (nomParties.contains(nom)) {
                                Navigator.of(context).pop();
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content:
                                        Text("Ce nom existe déjà !!")));
                              } else {
                                Navigator.of(context).pop();
                                partieCourante = nom;
                                setState(() {

                                });
                                addJoueur('', nom, [], [], [0], []);
                                addJoueur('', nom, [], [], [0], []);
                                addJoueur('', nom, [], [], [0], []);
                                addJoueur('', nom, [], [], [0], []);

                                currentIndex = 0;
                                callback();
                              }
                            },
                            label: const Text('valider'),
                            icon: const Icon(Icons.check_rounded),
                          )
                        ],
                      ),
                    ),
                  ));
            },
            label: const Text('Nouvelle partie'),
            icon: const Icon(Icons.add_circle_outline_rounded),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          getliste(listeJoueur);
          setState(() {
          });
        },
        child: const Icon(Icons.download_rounded),
      ),
    );
  }

  AlertDialog SupPartieDialog(l,
      int index, List<String> nomParties, BuildContext context) {
    return AlertDialog(
      content: SizedBox(
        height: 100,
        child: Column(
          children: [
            TextButton.icon(
                onPressed: () {
                  supprimePartie(index, l, nomParties);
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.delete_rounded),
                label: const Text("supprimer")),
            TextButton.icon(
                onPressed: () {
                  Navigator.of(context).pop();
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text(
                          "Les scores vont être remis à zéro",
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        content: SizedBox(
                          height: 30,
                          child: Row(
                            children: [
                              TextButton(
                                  onPressed: () {
                                    scoreZero(index, l, nomParties);
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text("valider")),
                              Expanded(child: Container()),
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text("Annuler")),
                            ],
                          ),
                        ),
                      ));
                },
                label: const Text("Score à 0"),
                icon: const Icon(Icons.refresh_rounded))
          ],
        ),
      ),
    );
  }

  Widget CardPartie(List<Joueur> l) {
    l = ranger(l);
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: l.length,
        itemBuilder: (context, indice) {
          return Padding(
            padding: const EdgeInsets.only(
              left: 12,
              bottom: 10,
              right: 10,
            ),
            child: Row(
              children: [
                Flexible(
                    flex: 3,
                    fit: FlexFit.loose,
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(),
                      child: Text(
                        l[indice].nom,
                        maxLines: 1,
                        style: const TextStyle(fontSize: 20),
                      ),
                    )),
                const Padding(padding: EdgeInsets.all(10)),
                Expanded(
                  flex: 1,
                  child: Text(
                    "${l[indice].sommeScore()}",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
              ],
            ),
          );
        });
  }

  void supprimePartie(int index, List<Joueur> l, List<String> nomParties) {
    if (nomParties.length > 1) {
      String nomTemp = nomParties[index];

      //trouver une autre partie
      if (index == 0) {
        partieCourante = nomParties[index + 1];
      } else {
        partieCourante = nomParties[index - 1];
      }

      for (int i = 0; i < l.length; i++) {
        if (l[i].partie == nomTemp) {
          deleteJoueur(l[i], l);
        }
      }

      nomParties.remove(nomTemp);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: SizedBox(
            height: 30,
            child: TextButton.icon(
              onPressed: () {
                currentIndex = 0;
                callback();
              },
              label: const Text("Modifier la partie courante"),
              icon: const Icon(Icons.edit_rounded),
            ),
          )));
    }
  }

  void scoreZero(int index, List<Joueur> l, List<String> nomParties) {
    for (int i = 0; i < l.length; i++) {
      if (l[i].partie == nomParties[index]) {
        l[i].scores = [];
        l[i].position = [0];
        l[i].deutschs = [];
      }
    }
  }

  void getliste(List<List<Joueur>> l) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = await auth.currentUser;

    var db = await FirebaseFirestore.instance;

    late Utilisateur ut;

    final docRef = db.collection("users").doc(user?.uid);
    docRef.get().then(
          (DocumentSnapshot doc) {
            final res2 = doc.data() as Map<String, dynamic>;
            ut = Utilisateur.fromJson(res2);
            print(ut.toString());
      },
      onError: (e) => print("Error getting document: $e"),
    );





  }
}
