import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive/hive.dart';
import 'model/Joueur.dart';

class Boxes {
  static Box<Joueur> getparties()=>
      Hive.box<Joueur>('data');
  static List<Joueur> getliste()=>
      Hive.box<Joueur>('data').values.toList();
}