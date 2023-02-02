import 'package:hive/hive.dart';
import 'model/Partie.dart';

class Boxes {
  static Box<Partie> getparties()=>
      Hive.box<Partie>('Parties');
}