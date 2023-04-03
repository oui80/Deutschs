import 'package:Dutch/main.dart';
import 'package:flutter/material.dart';
import '../../Widgets/neurimrophic.dart';
import '../../generated/l10n.dart';
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
    bool nomValide = true;

    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: l.length,
        itemBuilder: (context, index) {
          final j = l[index];
            if (j.nom == '') {
              return Padding(
                padding: const EdgeInsets.all(25),
                child: Row(
                  children: [
                    Text(S.of(context).Joueur),
                    Text((index +1) as String),
                    Text(S.of(context).pasDeNom),
                  ],
                ),
              );
            }else{
              List names = [];
              for (var element in l) {
                if (names.contains(element.nom)) {
                  nomValide = false ;
                } else {
                  names.add(element.nom);
                }
              }
            }
            if(nomValide) {
              return TuileFinal(j, l, context);
            }else{
              return Padding(
                padding: const EdgeInsets.all(25),
                child: Text(S.of(context).MemeNom),
              );
            }
        });
  }

  Widget TuileFinal(Joueur j, List<Joueur> l, context) {
    var isVisible = false;
    if (j.position.last == 0 && j.scores.isNotEmpty) {
      isVisible = true;
    }

    double pdtop = 3.0;
    double pdleft = 18.0;
    double taille = 16.7;

      return Padding(
        padding: const EdgeInsets.only(top: 25,left: 5,right: 5),
        child: SizedBox(
          height: 250,
          child: myContainer(Column(
              children: [
                Row(
                  children: [
                    //Position final
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: myContainer(
                        SizedBox(
                          height: 40,
                          width: 40,
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              (j.position.last + 1).toString(),
                              style: TextStyle(
                                color: tan1,
                                fontSize: 27,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
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
                          style: TextStyle(
                            color: mygrey,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Text(S.of(context).points,
                        style: TextStyle(
                          fontSize: 18,
                          color: mygrey,
                        )),
                    Padding(
                      padding: const EdgeInsets.only(right: 14),
                      child: Text(j.sommeScore().toString(),
                          style: TextStyle(
                            color: tan1,
                            fontSize: 27,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: pdtop, left: pdleft),
                  child: Row(
                    children: [
                      Text(S.of(context).ScoreMoyen,style: TextStyle(
                        color: mygrey,
                        fontSize: taille,
                      ),),
                      Text("${(j.sommeScore() / j.scores.length).round().toInt()}", style: TextStyle(
                          color: tan1,
                        fontSize: taille,
                      ),),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: pdtop, left: pdleft),
                  child: Row(
                    children: [
                      Text(S.of(context).PositionMoyenne,style: TextStyle(
                        color: mygrey,
                        fontSize: taille,
                      ),),
                      Text("${positionMoyen(j)}",style: TextStyle(
                        color: tan1,
                        fontSize: taille,
                      ),),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: pdtop, left: pdleft),
                  child: Row(
                    children: [
                      Text(S.of(context).PireScore,style: TextStyle(
                          color: mygrey,
                        fontSize: taille,
                      ),),
                      Text("${pireScore(j).toString()}",style: TextStyle(
                          color: tan1,
                        fontSize: taille,
                      ),),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: pdtop, left: pdleft),
                  child: Row(
                    children: [
                      Text(
                         S.of(context).NombreDutchs,style: TextStyle(
                        color: mygrey,
                        fontSize: taille,
                      ),),
                      Text(
                          "${j.NbDeutschs()}/${NbdeutschTot(l)} ",style: TextStyle(
                        color: tan1,
                        fontSize: taille,
                      ),),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: pdtop, left: pdleft),
                  child: Row(
                    children: [
                      Text(
                          S.of(context).DutchsGagnes,style: TextStyle(
                        color: mygrey,
                        fontSize: taille,
                      ),),Text(
                          "${deutschsGagne(j, l)}/${j.NbDeutschs()}",style: TextStyle(
                        color: tan1,
                        fontSize: taille,
                      ),),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: pdtop, left: pdleft),
                  child: Row(
                    children: [
                      Text(
                          S.of(context).TauxDutchs, style: TextStyle(
                        color: mygrey,
                        fontSize: taille,
                      ),),
                      Text(
                          "${(j.NbDeutschs() / j.scores.length * 100).round()} %", style: TextStyle(
                        color: tan1,
                        fontSize: taille,
                      ),),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: pdtop, left: pdleft),
                  child: Row(
                    children: [
                      Text(S.of(context).DutchsVoles,style: TextStyle(color: mygrey,
                        fontSize: taille,),),
                      Text("${nbDeutschsVole(j, l)}",style: TextStyle(color: tan1,
                        fontSize: taille,),),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: pdtop, left: pdleft),
                  child: Row(
                    children: [
                      Text(S.of(context).PireEnnemi,style: TextStyle(color: mygrey,
                        fontSize: taille,),),
                      ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width - 305,
                          ),
                          child: Text(
                            pireEnnemie(j, l)[0],
                            style: TextStyle(color:tan1,
                              fontSize: taille,),
                            maxLines: 1,
                          )),
                      Text(S.of(context).aVole,style: TextStyle(color: mygrey,
                        fontSize: taille,),),
                      Text("${pireEnnemie(j, l)[1]}",style: TextStyle(color: tan1,
                        fontSize: taille,),),
                      Text(S.of(context).dutchs,style: TextStyle(color: mygrey,
                        fontSize: taille,),),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

  int NbdeutschTot(List<Joueur> l) {
    int res = 0;
    l.forEach((element) { element.deutschs.forEach((d) {
      if(d == 1 || d==2){
        res++;
      }
    });
    });
    return res;
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

