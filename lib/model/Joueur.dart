import 'package:hive/hive.dart';

part 'Joueur.g.dart';

@HiveType(typeId: 1)
class Joueur extends HiveObject{
  @HiveField(0)
  late String nom;
  @HiveField(1)
  late List<int> scores;
  @HiveField(2)
  late List<int> deutschs;
  @HiveField(3)
  late List<int> position;
  @HiveField(4)
  late List<int> color;
  @HiveField(5)
  late String partie;

  Joueur(this.nom,this.partie,this.scores,this.deutschs,this.position,this.color);

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

  int NbDeutschs(){
    int res = 0;
    for (int i = 0; i<deutschs.length; i++){
      if(deutschs[i]==1){
        res = res + 1;
      }
    }
    return res;
  }

  @override
  String toString(){
    return "$nom  ${sommeScore()} ${position}";
  }
}