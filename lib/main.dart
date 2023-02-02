import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:nomaislaoh/boxes.dart';
import 'package:nomaislaoh/pages/HistoricPage.dart';
import 'package:nomaislaoh/pages/TableauScore.dart';
import 'package:nomaislaoh/pages/StatPage.dart';
//import 'boxes.dart';
import 'model/Partie.dart';
import 'pages/addJoueurPage.dart';
import 'model/Joueur.dart';

int numPartie = 0;

int currentIndex = 2;

Joueur j1 = Joueur('', [], [], [], [255, 63, 245, 255]);
Joueur j2 = Joueur('', [], [], [], [255, 63, 245, 255]);
Joueur j3 = Joueur('', [], [], [], [255, 63, 245, 255]);
Joueur j4 = Joueur('', [], [], [], [255, 63, 245, 255]);

List<Joueur> l = [j1, j2, j3, j4];

Future main() async {

  await Hive.initFlutter();
  Hive.registerAdapter(PartieAdapter());
  Hive.registerAdapter(JoueurAdapter());
  await Hive.openBox<Partie>('Parties');
  //await Hive.deleteFromDisk();
  var joueur = Joueur('timothé', [], [], [], []);
  addPartie('p1',[joueur]);

  runApp(const MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {

    const Color colorbutton = Colors.white;

    return Scaffold(
      body: ValueListenableBuilder<Box<Partie>>(
          valueListenable: Boxes.getparties().listenable(),
          builder: (context, box, _) {
            final listePartie = box.values.toList().cast<Partie>();
            final pages = [
              addJoueurPage(listePartie.first,context),
              TableauScore(context),
              HistoricPage(context),
              statisticsPage(numPartie),
            ];
            return pages[currentIndex];
          }),
      bottomNavigationBar: Container(
        color: Colors.blue,
        padding: const EdgeInsets.all(15),
        child: GNav(
          haptic: true,
          gap: 8,
          padding: const EdgeInsets.all(13),
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
              text: 'historique',
            ),
            GButton(
              iconColor: colorbutton,
              iconActiveColor: colorbutton,
              textColor: colorbutton,
              icon: Icons.table_rows_rounded,
              text: 'Statistiques',
            ),
          ],
        ),
      ),
    );
  }
}
