// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Partie.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PartieAdapter extends TypeAdapter<Partie> {
  @override
  final int typeId = 0;

  @override
  Partie read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Partie()
      ..l = (fields[0] as List).cast<Joueur>()
      ..nom = fields[1] as String
      ..id = fields[2] as String?;
  }

  @override
  void write(BinaryWriter writer, Partie obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.l)
      ..writeByte(1)
      ..write(obj.nom)
      ..writeByte(2)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PartieAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
