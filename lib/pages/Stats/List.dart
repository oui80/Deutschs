import 'package:flutter/material.dart';
import '../../model/Joueur.dart';

class ListScore extends StatefulWidget {
  final List<Joueur> liste;

  const ListScore({Key? key, required this.liste}) : super(key: key);

  @override
  State<ListScore> createState() => _ListScoreState();
}

class _ListScoreState extends State<ListScore> {
  late List<Joueur> l;

  @override
  void initState() {
    super.initState();
    l = widget.liste;
  }

  @override
  Widget build(BuildContext context) {

    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: l.length,
        itemBuilder: (context, index) {
          final j = l[index];
          bool estNomme = true;
          for (int i = 0; i < l.length; i++) {
            if (l[i].nom == '') {
              estNomme = false;
              break;
            }
          }
          if (estNomme) {
            return TuileFinal(j, l, context);
          } else {
            return const Text("Les Joueurs n'ont pas de noms");
          }
        });
  }

  Widget TuileFinal(Joueur j, List<Joueur> l, context) {
    var isVisible = false;
    if (j.position.last == 0 && j.scores.isNotEmpty) {
      isVisible = true;
    }

      return SizedBox(
        height: 200,
        child: Card(
          child: Column(
            children: [
              Row(
                children: [
                  //Position final
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                        child: SizedBox(
                          height: 40,
                          width: 40,
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              (j.position.last + 1).toString(),
                              style: const TextStyle(
                                fontSize: 27,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        )),
                  ),
                  Visibility(
                      visible: isVisible,
                      child: const Padding(
                        padding: EdgeInsets.only(right: 8),
                        child: Image(
                          image: AssetImage('lib/Assets/crown2.png'),
                          width: 30,
                          height: 25,
                        ),
                      )),
                  //Nom
                  Expanded(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(),
                      child: Text(
                        j.nom,
                        maxLines: 1,
                        style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const Text("pt : ",
                      style: TextStyle(
                        fontSize: 18,
                      )),
                  Padding(
                    padding: const EdgeInsets.only(right: 14),
                    child: Text(j.sommeScore().toString(),
                        style: const TextStyle(
                          fontSize: 27,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                ],
              ),
              Text("Score moyen : ${(j.sommeScore() / j.scores.length).round().toInt()}"),
              Text("Pire score : ${pireScore(j).toString()}"),
              Text(
                  "Nombre de dutchs : ${j.NbDeutschs()}  dutchs gagnés : ${deutschsGagne(j, l)}"),
              Text(
                  "Taux de dutchs : ${(j.NbDeutschs() / j.scores.length * 100).round()} %"),
              Text("Position Moyenne : ${positionMoyen(j)}"),
              Row(
                children: [
                  Expanded(child: Container()),
                  const Text("Pire ennemie : "),
                  ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width - 275,
                      ),
                      child: Text(
                        pireEnnemie(j, l)[0],
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      )),
                  Text(" a volé ${pireEnnemie(j, l)[1]} dutchs"),
                  Expanded(child: Container()),
                ],
              ),
              Text("Dutchs volés : ${nbDeutschsVole(j, l)}"),
            ],
          ),
        ),
      );
    }
  }

  nbDeutschsVole(Joueur joueur, List<Joueur> l) {
    //combien de deutsch a t'il vole
    int res = 0;
    for (int i = 0; i < l.length; i++) {
      //on parcourt tous les autres joueurs
      if (l[i].nom != joueur.nom && joueur.deutschs.isNotEmpty) {
        //si le joueur a deutsch
        for (int j = 0; j < l[i].deutschs.length; j++) {
          //pour tous les deutsch d'un joueur
          if (l[i].deutschs[j] == 2) {
            //si un joueur a perdu son deutsch
            if (joueur.deutschs[j] == 3) {
              //si le joueur a fait un meilleur score
              res++;
            }
          }
        }
      }
    }
    return res;
  }

  pireEnnemie(Joueur joueur, List<Joueur> l) {
    //le pire ennemie est le joueur qui a volé le plus de deutschs
    //On regarde quand le joueur a deutsch
    //s'il a deutsch on regarde s'il a été premier
    //si il n'a pas été le premier, la liste de pire énnemies augmente de 1

    Map<String, dynamic> difdeutsch = {
      for (int a = 0; a < l.length; a++)
        if (l[a].nom != joueur.nom) l[a].nom: 0
    };

    for (int i = 0; i < joueur.deutschs.length; i++) {
      if (joueur.deutschs[i] == 2) {
        for (int j = 0; j < l.length; j++) {
          if (l[j].deutschs[i] == 3) {
            difdeutsch[l[j].nom] = difdeutsch[l[j].nom] + 1;
          }
        }
      }
    }

    //on definit le pire ennemie au joueur qui est premier
    int i = 0;
    if (joueur.position.last == 0) {
      while (l[i].position.last != 1) {
        i++;
      }
    } else {
      while (l[i].position.last != 0) {
        i++;
      }
    }
    String res = l[i].nom;

    int voleMax = 0;
    difdeutsch.forEach((key, value) {
      if (voleMax < value) {
        voleMax = value;
        res = key;
      }
    });
    return [res, difdeutsch[res]];
  }

  int pireScore(Joueur j) {
    int scoreMax = j.scores[0];
    for (int i = 0; i < j.scores.length; i++) {
      if (scoreMax < j.scores[i]) {
        scoreMax = j.scores[i];
      }
    }
    return scoreMax;
  }

  int positionMoyen(Joueur j) {
    int somme = 0;
    for (int i = 0; i < j.position.length; i++) {
      somme = somme + j.position[i];
    }
    int res;
    if (j.position.length == 1) {
      res = j.position[0];
    } else {
      res = (somme / j.position.length).round().toInt();
    }
    return res + 1;
  }

  int deutschsGagne(Joueur joueur, List<Joueur> l) {
    int res = 0;
    //retourne le nombre de deutsch gagnés
    for (int j = 0; j < joueur.scores.length; j++) {
      if (joueur.deutschs[j] == 1) {
        res++;
      }
    }
    return res;
  }

