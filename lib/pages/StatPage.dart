import 'package:Dutch/pages/Stats/EvolutionsScore.dart';
import 'package:flutter/material.dart';
import '../boxes.dart';
import '../main.dart';
import '../model/Joueur.dart';
import 'HistoricPage.dart';
import 'Stats/List.dart';
import 'Stats/Pie.dart';

class statisticsPage extends StatelessWidget {
  const statisticsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return stats(context);
  }
}


Widget stats(BuildContext context) {
  List<Joueur> listeJoueur = Boxes.getliste();
  //printlog(listeJoueur.toString());

  //on prend uniquement les joueurs qui sont de la partie selectionnée
  List<Joueur> listeCourante = [];
  for (int i = 0; i < listeJoueur.length; i++) {
    if (listeJoueur[i].partie == partieCourante) {
      listeCourante = listeCourante + [listeJoueur[i]];
    }
  }
  if (listeCourante.isNotEmpty) {
    if(listeCourante[0].scores.length > 1){
      return Construire(listeCourante,context);
    }else{
      return SafeArea(
          child: Scaffold(
              backgroundColor: myWhite,
              appBar: AppBar(
                toolbarHeight: 70,
                title: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Statistiques',
                    style: TextStyle(
                        color: tan2,
                        fontSize: 25,
                        letterSpacing: 1.5,
                        fontWeight: FontWeight.normal),
                  ),
                ),
                backgroundColor: myWhite,
              ),
              body: Center(
                  child:
                      Text("Les Joueurs doivent avoir au \nmoins deux scores", style: TextStyle(
                          color: mygrey,
                          fontSize: 18
                      ),),
              )

          ));
    }

  } else {
    return SafeArea(
        child: Scaffold(
      backgroundColor: myWhite,
      appBar: AppBar(
        toolbarHeight: 70,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Statistiques',
            style: TextStyle(
                color: tan2,
                fontSize: 25,
                letterSpacing: 1.5,
                fontWeight: FontWeight.normal),
          ),
        ),
        backgroundColor: myWhite,
      ),
          body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Appuyer sur le bouton", style: TextStyle(
                      color: mygrey,
                      fontSize: 18
                  ),),
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Text("Nouvelle partie", style: TextStyle(
                        color: mygrey,
                        fontSize: 18
                    ),),
                  ),
                  Text("pour créez votre première partie", style: TextStyle(
                      color: mygrey,
                      fontSize: 18
                  ),),
                ],
              ))

    ));
  }
}

SafeArea Construire(List<Joueur> l,BuildContext context) {
  l = ranger(l);
  return SafeArea(
    child: Scaffold(
        backgroundColor: myWhite,
        appBar: AppBar(
          toolbarHeight: 70,
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Statistiques",
              style: TextStyle(
                  color: tan2,
                  fontSize: 25,
                  letterSpacing: 1.5,
                  fontWeight: FontWeight.normal),
            ),
          ),
          backgroundColor: myWhite,
        ),
        body: ScrollConfiguration(
          behavior: MyBehavior(),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Evolution(l,context),
                  ),
                  const Padding(padding: EdgeInsets.all(20)),
                  Pie(l,context),
                  ListScore(liste: l),
                ],
              ),
            ),
          ),
        )),
  );
}
