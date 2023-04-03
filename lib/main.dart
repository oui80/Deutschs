import 'dart:ui';

import 'package:Dutch/model/Utilisateur.dart';
import 'package:Dutch/pages/Log/LoginPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:Dutch/pages/HistoricPage.dart';
import 'package:Dutch/pages/TableauScore.dart';
import 'package:Dutch/pages/StatPage.dart';
import 'ad/ad_service.dart';
import 'ad/bottom_ad.dart';
import 'boxes.dart';
import 'generated/l10n.dart';
import 'pages/addJoueurPage.dart';
import 'model/Joueur.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:translator/translator.dart';

Color myWhite = const Color.fromRGBO(238, 253, 253, 1.0);
Color tan = const Color.fromRGBO(255, 171, 64, 1.0);
Color tan1 = const Color.fromRGBO(255, 146, 1, 1.0);
Color tan2 = const Color.fromRGBO(255, 109, 0, 1.0);
Color mygrey = const Color.fromRGBO(44, 58, 81, 1);
Color mygrey1 = const Color.fromRGBO(44, 58, 81, 0.55);

String partieCourante = Boxes.getliste().isEmpty ? "partie 1" : Boxes.getliste().last.partie;

int currentIndex = 0;
PageController _currentIndex = PageController();

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}

final navigatorKey = GlobalKey<NavigatorState>();
Joueur j = Joueur('', partieCourante, [], [], [], []);

final User? user = FirebaseAuth.instance.currentUser;
Utilisateur u = Utilisateur(user?.uid, "", "", DateTime(2019,11,14), [], 0, false);

void printlog(dynamic chaine) {
  if (kDebugMode) {
    print(chaine);
  }
}

Future<String> t(String text) async {
  GoogleTranslator translator = GoogleTranslator();
  String res = "";
  await translator.translate(text, from: "fr", to: 'en').then((value) => res = value.toString());
  printlog(res);
  return res;
}

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final adService = AdService(MobileAds.instance);
  GetIt.instance.registerSingleton<AdService>(adService);

  await adService.init();

  await Hive.initFlutter();
  Hive.registerAdapter(JoueurAdapter());
  await Hive.openBox<Joueur>('data');
  //await Hive.deleteFromDisk();

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  Locale _local = window.locale;

  runApp(
      MaterialApp(
        locale: _local,
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
       home: MyApp()));
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
      setState(() {
        _currentIndex.jumpToPage(currentIndex);
      });
    }

    List<Widget> pages = [
      addJoueurPage(callbackFunction: callback),
      TableauScore(),
      Historicpartie(callbackFunction: callback),
      statisticsPage(),
    ];

    return StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasError){
                return const AlertDialog(content: Center(child: Text("ERROR")),);
              }else if (snapshot.hasData) {
                final user = FirebaseAuth.instance.currentUser!;
                return Scaffold(
                  backgroundColor: myWhite,
                  body: PageView(
                      onPageChanged: (page) {
                        setState(() {
                          currentIndex = page;
                        });
                      },
                    controller: _currentIndex,
                      children: pages),
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

  Widget bottomNavBar() {
        return SizedBox(
          height: 110,
          child: Column(
            children: [
              const BottomBannerAd(),
              Container(
                decoration: BoxDecoration(
                  color: myWhite,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 3,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),

                padding: const EdgeInsets.all(12),
                child: GNav(
                  haptic: true,
                  gap: 8,
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 6, bottom: 6),
                  tabBackgroundColor: tan1,
                  backgroundColor: Colors.transparent,
                  duration: Duration(milliseconds: 350),
                  textStyle: TextStyle(color: myWhite, fontWeight: FontWeight.bold, fontSize: 16),
                  selectedIndex: currentIndex,
                  onTabChange: (index) {
                    if(Boxes.getliste().isNotEmpty){
                      setState(() {
                        currentIndex= index;
                      } );
                      _currentIndex.jumpToPage(currentIndex);

                    }
                  },
                  tabs: [
                    GButton(
                      iconColor: mygrey,
                      iconActiveColor: myWhite,
                      textColor: mygrey,
                      icon: Icons.person_add_alt_1_rounded,
                      text: S.of(context).Joueurs,

                    ),
                    GButton(
                      iconColor: mygrey,
                      iconActiveColor: myWhite,
                      textColor: mygrey,
                      icon: Icons.format_list_numbered_rounded,
                      text: 'Scores',
                    ),
                    GButton(
                      iconColor: mygrey,
                      iconActiveColor: myWhite,
                      textColor: mygrey,
                      icon: Icons.history,
                      text: 'Historique',
                    ),
                    GButton(
                      iconColor: mygrey,
                      iconActiveColor: myWhite,
                      textColor: mygrey,
                      icon: Icons.query_stats_rounded,
                      text: 'Statistiques',
                    ),
                  ],
                ),
              ),
            ],
          ),
        );

  }
}
