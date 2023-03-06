import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:nomaislaoh/boxes.dart';
import 'package:nomaislaoh/pages/HistoricPage.dart';
import 'package:nomaislaoh/pages/TableauScore.dart';
import 'package:nomaislaoh/pages/StatPage.dart';
import 'pages/addJoueurPage.dart';
import 'model/Joueur.dart';

String partie = "partie 1";
int currentIndex = 0;


Future main() async {

  await Hive.initFlutter();
  Hive.registerAdapter(JoueurAdapter());
  await Hive.openBox<Joueur>('zdfviuvze');
  //await Hive.deleteFromDisk();
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {

    void callback() {
      setState((){

      });
    }

    const Color colorbutton = Colors.white;

    return Scaffold(
      body: ValueListenableBuilder<Box<Joueur>>(
          valueListenable: Boxes.getparties().listenable(),
          builder: (context, box, _) {
            List<Joueur> listeJoueur = box.values.toList().cast<Joueur>();

            print(listeJoueur);

            if(listeJoueur.isEmpty){
              addJoueur('', partie, [], [], [0], []);
              addJoueur('', partie, [], [], [0], []);
              addJoueur('', partie, [], [], [0], []);
              addJoueur('', partie, [], [], [0], []);
            }
            //on prend uniquement les joueurs qui sont de la partie selectionnée
            List<Joueur> listeCourante = [];
            for (int i = 0;i<listeJoueur.length;i++){
              if (listeJoueur[i].partie == partie){
                listeCourante = listeCourante + [listeJoueur[i]];
              }
            }
            print("");
            print("liste courante : "+listeCourante.toString());
            print("");
            List<Widget> pages = [
              addJoueurPage(listeCourante,callbackFunction: callback),
              TableauScore(listeCourante,context),
              Historicpartie(listeJoueur, callbackFunction: callback,),
              statisticsPage(listeCourante),
            ];
            return pages[currentIndex];
          }),
      bottomNavigationBar: Container(
        color: Colors.blue,
        padding: const EdgeInsets.all(12),
        child: GNav(
          haptic: true,
          gap: 8,
          padding: const EdgeInsets.only(left: 10,right: 10,top: 6,bottom: 6),
          tabBackgroundColor: Colors.black12,
          backgroundColor: Colors.blue,
          onTabChange: (index) => setState(() => currentIndex = index),
          tabs: const [
            GButton(
              iconColor: colorbutton,
              iconActiveColor: colorbutton,
              textColor: colorbutton,
              icon: Icons.person_add_alt_1_rounded,
              text: 'Joueur',
            ),
            GButton(
              iconColor: colorbutton,
              iconActiveColor: colorbutton,
              textColor: colorbutton,
              icon: Icons.format_list_numbered_rounded,
              text: 'Scores',
            ),
            GButton(
              iconColor: colorbutton,
              iconActiveColor: colorbutton,
              textColor: colorbutton,
              icon: Icons.history,
              text: 'Historique',
            ),
            GButton(
              iconColor: colorbutton,
              iconActiveColor: colorbutton,
              textColor: colorbutton,
              icon: Icons.query_stats_rounded,
              text: 'Statistiques',
            ),
          ],
        ),
      ),
    );
  }
}
