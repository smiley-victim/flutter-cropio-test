// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plant_info.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PlantInfoAdapter extends TypeAdapter<PlantInfo> {
  @override
  final int typeId = 0;

  @override
  PlantInfo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PlantInfo(
      id: fields[0] as String,
      plant: fields[1] as String,
      type: fields[2] as String,
      imageUrl: (fields[3] as List).cast<String>(),
      description: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, PlantInfo obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.plant)
      ..writeByte(2)
      ..write(obj.type)
      ..writeByte(3)
      ..write(obj.imageUrl)
      ..writeByte(4)
      ..write(obj.description);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlantInfoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
