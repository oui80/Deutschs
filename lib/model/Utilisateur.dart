import 'package:hive/hive.dart';
import 'Joueur.dart';

class Utilisateur {
  late String pseudo;
  late String login;
  late String mdp;
  late DateTime dateCreation;
  late Map<String, dynamic> parties;
  late int clickpub;
  late bool AvalideCondition;

  Utilisateur (pseudo,login,mdp,parties,clickpub,Avalide) {
    this.pseudo = pseudo;
    this.login = login;
    this.mdp = mdp;
    this.dateCreation = DateTime.now();
    this.parties = parties;
    this.clickpub = clickpub;
    this.AvalideCondition = Avalide;
  }
}

