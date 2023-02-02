import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:nomaislaoh/main.dart';

import '../boxes.dart';
import '../model/Joueur.dart';
import '../model/Partie.dart';

@override
Widget HistoricPage(BuildContext context) {
  //List<Partie> l = boxes.getParties('Parties');
  return Scaffold(
      appBar: AppBar(
        title: const Text('Historique des parties'),
      ),
      body: ValueListenableBuilder<Box<Partie>>(
          valueListenable: Boxes.getparties().listenable(),
          builder: (context, box, _) {
            final listePartie = box.values.toList().cast<Partie>();
            return Historicpartie(listePartie, context);
          }));
}

Future addPartie(String name, List<Joueur> l) async {
  final partie = Partie()
    ..nom = name
    ..l = l;
  if (Boxes.getparties().isEmpty) {
    partie.id = "0";
  } else {
    partie.id = Boxes.getparties().length.toString();
  }
  final box = Boxes.getparties();
  box.put(partie.nom, partie);
}

void editPartie(Partie partie, List<Joueur> l, String nom) {
  partie.l = l;
  partie.nom = nom;
  partie.id = partie.id;

  partie.save();

  final box = Boxes.getparties();
  box.put(partie.id, partie);
}

void deletePartie(Partie partie) {
  final box = Boxes.getparties();
  box.delete(partie.id);
}

Widget Historicpartie(List<Partie> listePartie, BuildContext context) {
  String nom = '';
  return Column(
    children: [
      Expanded(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: listePartie.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    numPartie = index;
                  },
                  child: Card(
                    child: Column(children: [
                      Text(
                        listePartie[index].nom,
                        style: const TextStyle(fontSize: 20),
                      ),
                      SizedBox(
                        height: 100,
                        child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: listePartie[index].l.length,
                            itemBuilder: (context, indice) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                  left: 12,
                                  top: 10,
                                  right: 10,
                                ),
                                child: Row(
                                  children: [
                                    Flexible(
                                      flex: 3,
                                      fit: FlexFit.loose,
                                      child: Text(
                                        listePartie[index].l[indice].nom,
                                        style: const TextStyle(fontSize: 20),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                        "${listePartie[index].l[indice].sommeScore()}",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                      ),
                    ]),
                  ),
                );
              }),
        ),
      ),
      TextButton.icon(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) => StatefulBuilder(
                  builder: (context, setState) =>
                      LayoutBuilder(builder: (context, constraints) {
                        return Column(children: [
                          const Material(
                            color: Colors.transparent,
                            child: Text(
                              "Extra text will be here",
                              textAlign: TextAlign.center,
                            ),
                          ),
                          AlertDialog(
                            title: const Text("Nouvelle Partie",
                                style: TextStyle(fontSize: 20)),
                            content: Column(
                              children: [
                                TextField(
                                  onChanged: (value) {
                                    nom = value;
                                  },
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: "nom nouvelle partie"),
                                ),
                                TextButton.icon(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    addPartie(nom, [
                                      Joueur('pierre', [], [], [],
                                          [255, 63, 245, 255]),
                                      Joueur('bob', [], [], [],
                                          [255, 63, 245, 255]),
                                      Joueur('saol', [], [], [],
                                          [255, 63, 245, 255]),
                                      Joueur('ppola', [], [], [],
                                          [255, 63, 245, 255])
                                    ]);
                                  },
                                  label: const Text('valider'),
                                  icon: const Icon(Icons.check_rounded),
                                )
                              ],
                            ),
                          ),
                        ]);
                      })));
        },
        label: const Text('Nouvelle partie'),
        icon: const Icon(Icons.add_circle_outline_rounded),
      )
    ],
  );
}
