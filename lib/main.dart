import 'package:Dutch/model/Utilisateur.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:Dutch/pages/HistoricPage.dart';
import 'package:Dutch/pages/TableauScore.dart';
import 'package:Dutch/pages/StatPage.dart';
import 'boxes.dart';
import 'pages/addJoueurPage.dart';
import 'model/Joueur.dart';
import 'package:firebase_core/firebase_core.dart';

String partieCourante = "partie 1";
int currentIndex = 0;

bool imprime = false;

void printlog(String chaine) {
  if (imprime) {
    print(chaine);
  }
}

Future main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(JoueurAdapter());
  await Hive.openBox<Joueur>('data');
  //await Hive.deleteFromDisk();

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Utilisateur user = CreateUser('pseudo', 'login', 'mdp', 0, false);
  upLoadUser(user);

  runApp(MaterialApp(home: MyApp()));
}

dynamic CreateUser(String pseudo, String login, String mdp, int clickpub, bool Avalide) {

  var listeJoueur = Boxes.getparties().values.toList();
  Map<String, dynamic> res = {};
  for (int i = 0; i < listeJoueur.length; i++) {
    res[i.toString()] = listeJoueur[i].toJson();
  }

  Utilisateur u = Utilisateur(pseudo, login, mdp, res, clickpub, Avalide);

  return u;
}

Future upLoadUser(Utilisateur u) async {
  final docUser = FirebaseFirestore.instance.collection('users').doc('my_id');

  final json = {
    'pseudo': u.pseudo,
    'login': u.login,
    'mdp': u.mdp,
    'dateCreation': u.dateCreation,
    'parties': u.parties,
    'clickpub': u.clickpub,
    'AvalideCondition': u.AvalideCondition
  };

  await docUser.set(json);
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
      setState(() {});
    }

    const Color colorbutton = Colors.white;

    List<Widget> pages = [
      addJoueurPage(callbackFunction: callback),
      TableauScore(context),
      Historicpartie(
        callbackFunction: callback,
      ),
      statisticsPage(),
    ];

    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: Container(
        color: Colors.blue,
        padding: const EdgeInsets.all(12),
        child: GNav(
          haptic: true,
          gap: 8,
          padding:
              const EdgeInsets.only(left: 10, right: 10, top: 6, bottom: 6),
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
