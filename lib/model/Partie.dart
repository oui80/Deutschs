import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'Joueur.dart';

part 'Partie.g.dart';

@HiveType(typeId: 0)
class Partie extends HiveObject{
  @HiveField(0)
  late List<Joueur> l;
  @HiveField(1)
  late String nom;
  @HiveField(2)
  late String? id;

  @override
  String toString(){
    return l.toString();
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Partie &&
              runtimeType == other.runtimeType &&
// Check if the values of the id field are equal
              id == other.id &&
// Check if the values of the nom field are equal
              nom == other.nom &&
// Check if the values of the l field are equal
              listEquals(l, other.l);

// The hashCode method is used to generate a unique identifier for an object.
// Overriding the hashCode method is recommended when you override the == operator.

  @override
  int get hashCode =>
      id.hashCode ^ nom.hashCode ^ l.hashCode;
}