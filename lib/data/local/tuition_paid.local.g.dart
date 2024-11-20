// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tuition_paid.local.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TuitionPaidLocalAdapter extends TypeAdapter<TuitionPaidLocal> {
  @override
  final int typeId = 5;

  @override
  TuitionPaidLocal read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TuitionPaidLocal(
      namHocHocKy: fields[0] as String,
      soTien: fields[1] as double,
      bienLai: fields[2] as String?,
      nguoiThu: fields[3] as String?,
      ngayThu: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, TuitionPaidLocal obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.namHocHocKy)
      ..writeByte(1)
      ..write(obj.soTien)
      ..writeByte(2)
      ..write(obj.bienLai)
      ..writeByte(3)
      ..write(obj.nguoiThu)
      ..writeByte(4)
      ..write(obj.ngayThu);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TuitionPaidLocalAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
