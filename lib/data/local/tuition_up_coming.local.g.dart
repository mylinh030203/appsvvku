// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tuition_up_coming.local.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TuitionUpComingLocalAdapter extends TypeAdapter<TuitionUpComingLocal> {
  @override
  final int typeId = 6;

  @override
  TuitionUpComingLocal read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TuitionUpComingLocal(
      tenHocPhan: fields[0] as String,
      soTinChi: fields[1] as int,
      soTien: fields[2] as double,
    );
  }

  @override
  void write(BinaryWriter writer, TuitionUpComingLocal obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.tenHocPhan)
      ..writeByte(1)
      ..write(obj.soTinChi)
      ..writeByte(2)
      ..write(obj.soTien);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TuitionUpComingLocalAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
