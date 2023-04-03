import 'package:Dutch/Widgets/neurimrophic.dart';
import 'package:Dutch/model/Utilisateur.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import '../boxes.dart';
import '../main.dart';
import '../model/Joueur.dart';
import 'Log/components/Utils.dart';
import 'addJoueurPage.dart';

//ranger liste par postion
List<Joueur> ranger(List<Joueur> l) {
  if (l[0].position.isNotEmpty) {
    l.sort((a, b) => a.position.last.compareTo(b.position.last));
  }
  return l;
}

void download(id) async {
  var db = FirebaseFirestore.instance;

  Box<Joueur> box = Boxes.getparties();
  box.clear();

  final docRef = db.collection("users").doc(id);
  docRef.get().then(
        (DocumentSnapshot doc) {
      final res2 = doc.data() as Map<String, dynamic>;
      u = Utilisateur.fromJson(res2);

      for (int i = 0; i < u.parties.length; i++) {
        box.add(u.parties[i]);
      }
    },
    onError: (e) => Utils.showSnackBar(e.message),
  );
}

void upload() {
  final User? user = FirebaseAuth.instance.currentUser;

  u = Utilisateur(
      user?.uid,
      u.pseudo,
      u.login,
      u.dateNais,
      Boxes.getliste(),
      u.clickpub,
      u.AvalideCondition);

  var res = u.toJson();
  FirebaseFirestore.instance.collection('users').doc(u.id).set(res);
}

class Historicpartie extends StatefulWidget {
  final Function callbackFunction;

  Historicpartie({Key? key, required this.callbackFunction}) : super(key: key);

  @override
  State<Historicpartie> createState() => _HistoricpartieState();
}

class _HistoricpartieState extends State<Historicpartie> {
  late Function callback;
  final nom = TextEditingController(text: "partie ");

  @override
  void initState() {
    super.initState();
    callback = widget.callbackFunction;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box<Joueur>>(
        valueListenable: Boxes.getparties().listenable(),
        builder: (context, box, _) {
          List<Joueur> listeJoueur = box.values.toList().cast<Joueur>();

          printlog(listeJoueur.toString());

          return Construire(listeJoueur, context);
        });
  }

  SafeArea Construire(List<Joueur> l, BuildContext context) {
    List<String> nomParties = [];
    for (int i = 0; i < l.length; i++) {
      if (!nomParties.contains(l[i].partie)) {
        nomParties = nomParties + [l[i].partie];
      }
    }

    List<List<Joueur>> listeJoueur = [];
    List<Joueur> temps = [];
    for (int j = 0; j < nomParties.length; j++) {
      temps = [];
      for (int i = 0; i < l.length; i++) {
        if (l[i].partie == nomParties[j]) {
          temps = temps + [l[i]];
        }
      }
      listeJoueur = listeJoueur + [temps];
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: myWhite,
        appBar: AppBar(
          toolbarHeight: 70,
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Historique des parties',
              style: TextStyle(
                  color: tan2,
                  fontSize: 25,
                  letterSpacing: 1.5,
                  fontWeight: FontWeight.normal),
            ),
          ),
          backgroundColor: myWhite,
        ),
        body: Stack(
          children: [
            SizedBox(
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              child: ScrollConfiguration(
                  behavior: MyBehavior(),
                  child: l.isNotEmpty
                      ? ListView.builder(
                      shrinkWrap: true,
                      itemCount: nomParties.length+1,
                      itemBuilder: (BuildContext context, int index) {
                        if (index != nomParties.length) {
                          return Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  partieCourante = nomParties[index];
                                  currentIndex = 0;
                                  callback();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: myContainer(
                                    Column(children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          nomParties[index],
                                          style: TextStyle(
                                              color: tan2,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(15),
                                        child:
                                        CardPartie(listeJoueur[index]),
                                      )
                                    ]),
                                  ),
                                ),
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) =>
                                          SupPartieDialog(
                                              l, index, nomParties, context));
                                },
                                icon: Icon(Icons.more_vert_rounded,
                                    color: mygrey))
                          ],
                        );
                        } else {
                          return const SizedBox(height: 60,);
                        }
                      })
                      : Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Appuyer sur le bouton",
                            style: TextStyle(color: mygrey, fontSize: 18),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Text(
                              "Nouvelle partie",
                              style: TextStyle(color: mygrey, fontSize: 18),
                            ),
                          ),
                          Text(
                            "pour créez votre première partie",
                            style: TextStyle(color: mygrey, fontSize: 18),
                          ),
                        ],
                      ))),
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
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
                          )),
                      child: TextButton.icon(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) =>
                                  AlertDialog(
                                    backgroundColor: myWhite,
                                    title: Text("Nouvelle Partie",
                                        style: TextStyle(
                                            fontSize: 20, color: tan1)),
                                    content: SizedBox(
                                      height: 130,
                                      child: Column(
                                        children: [
                                          myContainer(TextField(
                                            inputFormatters: [
                                              FilteringTextInputFormatter.allow(RegExp(r'^[^$]*$'))
                                            ],
                                            style: TextStyle(color: mygrey),
                                            controller: nom,
                                            decoration: InputDecoration(
                                                enabledBorder:
                                                OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: myWhite),
                                                ),
                                                focusedBorder:
                                                OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: myWhite),
                                                ),
                                                fillColor: myWhite,
                                                filled: true,
                                                hintText: nom.text,
                                                hintStyle:
                                                TextStyle(color: mygrey)),
                                          )),
                                          Expanded(child: Container()),
                                          myContainer(Container(
                                            decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                  begin: Alignment.topRight,
                                                  end: Alignment.bottomLeft,
                                                  colors: [
                                                    tan2,
                                                    tan1,
                                                  ],
                                                )),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 5, right: 8),
                                              child: TextButton.icon(
                                                onPressed: () {
                                                  if (nomParties
                                                      .contains(nom.text)) {
                                                    Navigator.of(context).pop();
                                                    ScaffoldMessenger.of(
                                                        context)
                                                        .showSnackBar(
                                                        const SnackBar(
                                                            content: Text(
                                                                "Ce nom existe déjà !!")));
                                                  } else {
                                                    Navigator.of(context).pop();
                                                    partieCourante = nom.text;
                                                    setState(() {});
                                                    addJoueur('', nom.text, [],
                                                        [], [], []);
                                                    addJoueur('', nom.text, [],
                                                        [], [], []);
                                                    addJoueur('', nom.text, [],
                                                        [], [], []);
                                                    addJoueur('', nom.text, [],
                                                        [], [], []);

                                                    upload();

                                                    currentIndex = 0;
                                                    callback();
                                                  }
                                                },
                                                label: Text('valider',
                                                    style: TextStyle(
                                                      color: myWhite,
                                                    )),
                                                icon: Icon(Icons.check_rounded,
                                                    color: myWhite),
                                              ),
                                            ),
                                          ))
                                        ],
                                      ),
                                    ),
                                  ));
                        },
                        label: Text(
                          'Nouvelle partie',
                          style: TextStyle(color: myWhite),
                        ),
                        icon: Icon(
                          Icons.add_circle_outline_rounded,
                          color: myWhite,
                        ),
                      ),
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }

  AlertDialog SupPartieDialog(l, int index, List<String> nomParties,
      BuildContext context) {
    return AlertDialog(
      content: SizedBox(
        height: 140,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: myContainer(Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        tan2,
                        tan1,
                      ],
                    )),
                child: Padding(
                  padding: const EdgeInsets.only(left: 5, right: 8),
                  child: TextButton.icon(
                    onPressed: () {
                      supprimePartie(index, l, nomParties);
                      Navigator.of(context).pop();
                    },
                    label: Text('supprimer',
                        style: TextStyle(
                          color: myWhite,
                        )),
                    icon: Icon(Icons.delete_rounded, color: myWhite),
                  ),
                ),
              )),
            ),
            Expanded(child: Container()),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: myContainer(Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        tan2,
                        tan1,
                      ],
                    )),
                child: Padding(
                  padding: const EdgeInsets.only(left: 5, right: 8),
                  child: TextButton.icon(
                    onPressed: () {
                      Navigator.of(context).pop();
                      showDialog(
                        context: context,
                        builder: (context) =>
                            AlertDialog(
                              title: Text(
                                "Les scores vont être remis à zéro",
                                style: TextStyle(
                                    fontSize: 15,
                                    color: mygrey
                                ),
                              ),
                              content: SizedBox(
                                  height: 30,
                                  child: Row(
                                    children: [
                                  myContainer(
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
                              child: TextButton(
                                  onPressed: () {
                                    scoreZero(index, l, nomParties);
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(" valider ",style: TextStyle(
                                    color: myWhite
                                  ),)),
                            )),
                        Expanded(child: Container()),
                                      myContainer(
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
                                            child: TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text(" Annuler ",style: TextStyle(
                                                    color: myWhite
                                                ),)),
                                          )),
                        ],
                      ),)
                      ,
                      )
                      );
                    },
                    label: Text('Score à 0',
                        style: TextStyle(
                          color: myWhite,
                        )),
                    icon: Icon(Icons.refresh_rounded, color: myWhite),
                  ),
                ),
              )),
            ),
          ],
        ),
      ),
    );
  }

  Widget CardPartie(List<Joueur> l) {
    l = ranger(l);
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: l.length,
        itemBuilder: (context, indice) {
          return Padding(
            padding: const EdgeInsets.only(
              left: 12,
              bottom: 10,
              right: 10,
            ),
            child: Row(
              children: [
                Flexible(
                    flex: 3,
                    fit: FlexFit.loose,
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(),
                      child: Text(
                        l[indice].nom,
                        maxLines: 1,
                        style: TextStyle(fontSize: 20, color: mygrey),
                      ),
                    )),
                const Padding(padding: EdgeInsets.all(10)),
                Expanded(
                  flex: 1,
                  child: Text(
                    "${l[indice].sommeScore()}",
                    style: TextStyle(
                        color: tan1, fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
              ],
            ),
          );
        });
  }

  void supprimePartie(int index, List<Joueur> l, List<String> nomParties) {
    String nomTemp = nomParties[index];

    for (int i = 0; i < l.length; i++) {
      if (l[i].partie == nomTemp) {
        deleteJoueur(l[i], l, callback);
      }
    }

    //trouver une autre partie
    if (Boxes
        .getliste()
        .isNotEmpty) {
      if (index == 0) {
        partieCourante = nomParties[index + 1];
      } else {
        partieCourante = nomParties[index - 1];
      }
    }

    nomParties.remove(nomTemp);
  }

  void scoreZero(int index, List<Joueur> l, List<String> nomParties) {
    for (int i = 0; i < l.length; i++) {
      if (l[i].partie == nomParties[index]) {
        l[i].scores = [];
        l[i].position = [0];
        l[i].deutschs = [];
      }
    }
  }
}
