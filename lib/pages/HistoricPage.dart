import 'package:flutter/material.dart';

import '../boxes.dart';
import '../model/Joueur.dart';


@override
Widget HistoricPage(l,BuildContext context) {
  //List<Partie> l = boxes.getParties('Parties');
  return Scaffold(
      appBar: AppBar(
        title: const Text('Historique des parties'),
      ),
      body: Historicpartie(l, context));
}

Widget Historicpartie(List<Joueur> l, BuildContext context) {
  String nom = '';
  return Column(
    children: [
      Expanded(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: l.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    //partie = index;
                  },
                  child: Card(
                    child: Column(children: [
                      Text(
                        l[index].nom,
                        style: const TextStyle(fontSize: 20),
                      ),
                      SizedBox(
                        height: 100,
                        child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: l.length,
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
                                        l[indice].nom,
                                        style: const TextStyle(fontSize: 20),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                        "${l[indice].sommeScore()}",
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
                                    //addJoueur();
                                    //addJoueur();
                                    //addJoueur();
                                    //addJoueur();

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
