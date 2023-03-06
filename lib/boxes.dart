import 'package:hive/hive.dart';
import 'model/Joueur.dart';

class Boxes {
  static Box<Joueur> getparties()=>
      Hive.box<Joueur>('zdfviuvze');
}