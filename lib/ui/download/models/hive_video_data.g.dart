// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_video_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveVideoDataAdapter extends TypeAdapter<HiveVideoData> {
  @override
  final int typeId = 0;

  @override
  HiveVideoData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveVideoData(
      id: fields[3] as String,
      url: fields[0] as String,
      dimensions: fields[2] as String,
      type: fields[4] as String,
      thumbnail: fields[1] as String,
      downloadUrl: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, HiveVideoData obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.url)
      ..writeByte(1)
      ..write(obj.thumbnail)
      ..writeByte(2)
      ..write(obj.dimensions)
      ..writeByte(3)
      ..write(obj.id)
      ..writeByte(4)
      ..write(obj.type)
      ..writeByte(5)
      ..write(obj.downloadUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveVideoDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
