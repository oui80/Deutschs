import 'package:cloud_firestore/cloud_firestore.dart';
import 'Joueur.dart';

class Utilisateur {
  late String id;
  late String pseudo;
  late String login;
  late String mdp;
  late DateTime dateNais;
  late DateTime dateCreation;
  late List<Joueur> parties;
  late int clickpub;
  late bool AvalideCondition;

  Utilisateur (id,pseudo,login,mdp,dateNais,parties,clickpub,Avalide) {
    this.id = id;
    this.pseudo = pseudo;
    this.login = login;
    this.mdp = mdp;
    this.dateNais = dateNais;
    this.dateCreation = DateTime.now();
    this.parties = parties;
    this.clickpub = clickpub;
    this.AvalideCondition = Avalide;
  }

  toJson(){
    Map<String, dynamic> res = {};
    for (int i = 0; i < parties.length; i++) {
      res[i.toString()] = parties[i].toJson();
    }

    return {
      'id': id,
      'pseudo': pseudo,
      'login': login,
      'mdp': mdp,
      'date naissance': dateNais,
      'dateCreation': dateCreation,
      'parties': res,
      'clickpub': clickpub,
      'AvalideCondition': AvalideCondition
    };
  }

  static List<Joueur> jsontoList(Map<String, dynamic> json) {
    List<Joueur> res = [];
    List<dynamic> js = json.values.toList();
    for (int i = 0;i<js.length;i++){
      res.add(Joueur.fromJson(js[i]));
    }
    return res;
  }

  static Utilisateur fromJson(Map<String, dynamic> json) {
    return Utilisateur(
        json['id'],
        json['pseudo'],
        json['login'],
        json['mdp'],
        (json['date naissance'] as Timestamp).toDate() ,
        jsontoList(json['parties']),
        json['clickpub'],
        json['AvalideCondition']);
  }

  String toString() {
    return id.toString()+ parties.toString();
  }
}

