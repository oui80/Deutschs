import 'package:flutter/material.dart';
import '../main.dart';
import '../model/Joueur.dart';
import 'addJoueurPage.dart';

@override
Widget HistoricPage(l, BuildContext context) {
  //List<Partie> l = boxes.getParties('Parties');
  return Scaffold(
      appBar: AppBar(
        title: const Text('Historique des parties'),
      ),
      body: Historicpartie(l, context));
}

Widget Historicpartie(List<Joueur> l, BuildContext context) {
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

  String nom = '';
  return Column(
    children: [
      Expanded(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: nomParties.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      partie = nomParties[index];
                      currentIndex = 0;
                    },
                    child: Card(
                      child: Column(children: [
                        Text(
                          nomParties[index],
                          style: const TextStyle(fontSize: 20),
                        ),
                        SizedBox(
                            height: 100, child: CardPartie(listeJoueur[index])),
                      ]),
                    ),
                  );
                }),
          ),
        ),
      ),
      TextButton.icon(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
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
                            print(nom);
                            addJoueur('', nom, [], [], [], []);
                            partie = nom;
                            currentIndex = 0;
                            //addJoueur();
                            //addJoueur();
                            //addJoueur();
                          },
                          label: const Text('valider'),
                          icon: const Icon(Icons.check_rounded),
                        )
                      ],
                    ),
                  ));
        },
        label: const Text('Nouvelle partie'),
        icon: const Icon(Icons.add_circle_outline_rounded),
      )
    ],
  );
}

Widget CardPartie(List<Joueur> l) {
  return ListView.builder(
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
                      fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
            ],
          ),
        );
      });
}
