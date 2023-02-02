import 'package:hive/hive.dart';

part 'Joueur.g.dart';

@HiveType(typeId: 1)
class Joueur extends HiveObject{
  @HiveField(0)
  late String nom;
  @HiveField(1)
  late List<int> scores;
  @HiveField(2)
  late List<bool> deutschs;
  @HiveField(3)
  late List<int> position;
  @HiveField(4)
  late List<int> color;

  Joueur(String nom,List<int> scores,List<bool> deutschs,List<int> position,List<int> color) {
    this.nom = nom;
    this.scores = scores;
    this.deutschs = deutschs;
    this.position = position;
    this.color = color;
  }

  int sommeScore() {
    int res = 0;
    for (int i = 0; i< scores.length; i++){
      res = res + scores[i];
    }
    return res;
  }

  int scoreJusqua(int index){
    int i = 0;
    int somme = 0;
    while (i < index){
      somme = somme +  scores[i];
      i++;
    }
    return somme;
  }

  @override
  String toString(){
    return nom + " " + sommeScore().toString();
  }
}