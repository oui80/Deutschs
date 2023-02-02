// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Joueur.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class JoueurAdapter extends TypeAdapter<Joueur> {
  @override
  final int typeId = 1;

  @override
  Joueur read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Joueur(
      fields[0] as String,
      (fields[1] as List).cast<int>(),
      (fields[2] as List).cast<bool>(),
      (fields[3] as List).cast<int>(),
      (fields[4] as List).cast<int>(),
    );
  }

  @override
  void write(BinaryWriter writer, Joueur obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.nom)
      ..writeByte(1)
      ..write(obj.scores)
      ..writeByte(2)
      ..write(obj.deutschs)
      ..writeByte(3)
      ..write(obj.position)
      ..writeByte(4)
      ..write(obj.color);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is JoueurAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
