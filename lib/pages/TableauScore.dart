import 'package:flutter/material.dart';
import '../Widgets/ScoreDialog.dart';
import '../main.dart';
import '../model/Joueur.dart';

Widget TableauScore(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('TableauScore'),
    ),
    body: tab(context),
    floatingActionButton: FloatingActionButton(
      heroTag: 'plus_score',
      onPressed: () => {
        showDialog(
          context: context,
          builder: (context) => ScoreDialog(numPartie,context),
        ),
      },
      backgroundColor: Colors.blue,
      child: const Icon(Icons.add_rounded, color: Colors.white),
    ),
  );
}

Widget tab(BuildContext context) {
  var hauteur = 100.0;
  for (int i = 0; i < l[0].scores.length; i++) {
    hauteur = hauteur + 28.88;
  }
  return Padding(
    padding: const EdgeInsets.all(10),
    child: SingleChildScrollView(
      child: SizedBox(
        height: hauteur,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: l.length,
          itemBuilder: (context, index) {
            final j = l[index];
            return Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              const Padding(padding: EdgeInsets.all(5)),
              SizedBox(child: colonne(j, context)),
              const Padding(padding: EdgeInsets.all(5)),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black54,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                width: 2,
              ),
            ]);
          },
        ),
      ),
    ),
  );
}

Column colonne(Joueur j, BuildContext context) {
  return Column(
    children: [
      ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 75),
        child: Text(
          j.nom,
          maxLines: 1,
          style: const TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.bold,
            //color: Color.fromRGBO(j.rgb[0], j.rgb[1], j.rgb[2], 1),
          ),
        ),
      ),
      const Padding(padding: EdgeInsets.all(2)),
      Text(
        j.sommeScore().toString(),
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          //color: Color.fromRGBO(j.rgb[0], j.rgb[1], j.rgb[2], 1),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 7, bottom: 7),
        child: Container(
          width: 60,
          height: 2,
          decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black54,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(10))),
        ),
      ),
      Column(
        children: j.scores
            .map((score) => Padding(
                  padding: const EdgeInsets.all(4),
                  child: Text(
                    score.toString(),
                    style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 18,
                      //fontWeight: FontWeight.bold,
                    ),
                  ),
                ))
            .toList(),
      ),
    ],
  );
}
