import 'package:flutter/material.dart';
import 'package:Dutch/Widgets/ScoreDialog2.dart';

import '../main.dart';
import '../model/Joueur.dart';
import 'neurimrophic.dart';

class ModifyDialog extends StatelessWidget {
  List<Joueur> l;
  ModifyDialog(this.l, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Edition",style: TextStyle(color: tan1),),
      content: SizedBox(
        height: 130,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: myContainer(
                  Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            tan2,
                            tan1,
                          ],
                        ) ),
                    child: TextButton.icon(
                        onPressed: () {

                          Navigator.of(context).pop();

                          for (int i = 0;i<l.length;i++){
                            l[i].position.removeLast();
                            l[i].deutschs.removeLast();
                            l[i].scores.removeLast();
                          }
                          showDialog(context: context, builder: (context) => ScoreDialog2(l, context));
                        },
                        label: Text("Modifier la dernière manche",style: TextStyle(
                            color: myWhite
                        ),),
                        icon: Icon(Icons.edit_rounded,color: myWhite,),
                    ),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: myContainer(
                  Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            tan2,
                            tan1,
                          ],
                        ) ),
                    child: TextButton.icon(
                      onPressed: () {
                        for (int i = 0;i<l.length;i++){
                          l[i].position.removeLast();
                          l[i].deutschs.removeLast();
                          l[i].scores.removeLast();
                        }
                        Navigator.of(context).pop();
                      },
                      label: Text("Supprimer la dernière manche",style: TextStyle(
                          color: myWhite
                      ),),
                      icon: Icon(Icons.delete_rounded,color: myWhite,),
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
