import 'package:flutter/material.dart';
import 'package:Dutch/Widgets/ScoreDialog2.dart';

import '../model/Joueur.dart';

class ModifyDialog extends StatelessWidget {
  List<Joueur> l;
  ModifyDialog(this.l, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Edition"),
      content: SizedBox(
        height: MediaQuery.of(context).size.height/6,
        child: Column(
          children: [
            TextButton.icon(
                onPressed: () {

                  Navigator.of(context).pop();

                  for (int i = 0;i<l.length;i++){
                    l[i].position.removeLast();
                    l[i].deutschs.removeLast();
                    l[i].scores.removeLast();
                  }
                  showDialog(context: context, builder: (context) => ScoreDialog2(l, context));
                },

                icon: const Icon(Icons.edit_rounded),
                label: const Text("Modifier la dernière manche"),
            ),
            TextButton.icon(
              onPressed: () {
                for (int i = 0;i<l.length;i++){
                  l[i].position.removeLast();
                  l[i].deutschs.removeLast();
                  l[i].scores.removeLast();
                }
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.delete_rounded),
              label: const Text("Supprimer la dernière manche"),
            )
          ],
        ),
      ),
    );
  }
}
