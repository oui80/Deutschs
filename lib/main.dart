import 'package:Dutch/model/Utilisateur.dart';
import 'package:Dutch/pages/Log/LoginPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:Dutch/pages/HistoricPage.dart';
import 'package:Dutch/pages/TableauScore.dart';
import 'package:Dutch/pages/StatPage.dart';
import 'pages/addJoueurPage.dart';
import 'model/Joueur.dart';
import 'package:firebase_core/firebase_core.dart';

String partieCourante = "partie 1";
int currentIndex = 0;

bool imprime = false;

late Utilisateur u;

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
  //Utilisateur user = Utilisateur('', 'pseudo', 'login', 'mdp',DateTime(1989, 01, 26), Boxes.getparties(), 0, false);
  //upLoadUser(user);

  runApp(
      MaterialApp(
       home: MyApp()));
}

Future upLoadUser(Utilisateur u) async {
  var res = u.toJson();
    FirebaseFirestore.instance
        .collection('users')
        .doc(u.id)
        .set(res);
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {

    void callback() {
      setState(() {});
    }

    List<Widget> pages = [
      addJoueurPage(callbackFunction: callback),
      TableauScore(context),
      Historicpartie(
        callbackFunction: callback,
      ),
      const statisticsPage(),
    ];

    return StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasError){
                return const AlertDialog(content: Center(child: Text("ERROR")),);
              }else if (snapshot.hasData) {
                final user = FirebaseAuth.instance.currentUser!;
                return Scaffold(
                  body: pages[currentIndex],
                  bottomNavigationBar: bottomNavBar(),
                  drawer: Drawer(
                      child: Column(
                    children: [
                      Text(user.email!,style: const TextStyle(fontSize: 20)),
                      IconButton(
                        onPressed: () {
                          FirebaseAuth.instance.signOut();
                        },
                        icon: const Icon(Icons.logout_rounded),
                      ),
                    ],
                  )),
                );
              } else {
                return LoginPage();
              }
            });
  }

  Container bottomNavBar() {
    const Color colorbutton = Colors.black;
    const Color colorbutton2 = Colors.white;
    return Container(
      color: Colors.grey.shade50,
      padding: const EdgeInsets.all(12),
      child: GNav(
        haptic: true,
        gap: 8,
        padding: const EdgeInsets.only(left: 10, right: 10, top: 6, bottom: 6),
        tabBackgroundColor: Colors.blue,
        backgroundColor: Colors.grey.shade50,
        textStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
        onTabChange: (index) => setState(() => currentIndex = index),
        tabs: const [
          GButton(
            iconColor: colorbutton,
            iconActiveColor: colorbutton2,
            textColor: colorbutton,
            icon: Icons.person_add_alt_1_rounded,
            text: 'Joueur',
          ),
          GButton(
            iconColor: colorbutton,
            iconActiveColor: colorbutton2,
            textColor: colorbutton,
            icon: Icons.format_list_numbered_rounded,
            text: 'Scores',
          ),
          GButton(
            iconColor: colorbutton,
            iconActiveColor: colorbutton2,
            textColor: colorbutton,
            icon: Icons.history,
            text: 'Historique',
          ),
          GButton(
            iconColor: colorbutton,
            iconActiveColor: colorbutton2,
            textColor: colorbutton,
            icon: Icons.query_stats_rounded,
            text: 'Statistiques',
          ),
        ],
      ),
    );
  }
}
