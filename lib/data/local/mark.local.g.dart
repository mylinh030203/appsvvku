// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mark.local.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MarkLocalAdapter extends TypeAdapter<MarkLocal> {
  @override
  final int typeId = 1;

  @override
  MarkLocal read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MarkLocal(
      listDiemTongKet: (fields[0] as List).cast<DiemTongKet>(),
      listDiemHocPhanTheoKy: (fields[1] as List).cast<DiemHocPhanTheoKy>(),
    );
  }

  @override
  void write(BinaryWriter writer, MarkLocal obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.listDiemTongKet)
      ..writeByte(1)
      ..write(obj.listDiemHocPhanTheoKy);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MarkLocalAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class DiemTongKetAdapter extends TypeAdapter<DiemTongKet> {
  @override
  final int typeId = 2;

  @override
  DiemTongKet read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DiemTongKet(
      namBatDau: fields[0] as int,
      namKetThuc: fields[1] as int,
      hocKi: fields[2] as int,
      soTinChi: fields[3] as int,
      diem4: fields[4] as double,
      diem10: fields[5] as double,
      diemHb: fields[6] as double,
      tinChiTichLuyHocKi: fields[7] as int,
      xepLoai: fields[8] as String,
      diem4TichLuy: fields[9] as double,
      diem10TichLuy: fields[10] as double,
      tongTinChiTichLuy: fields[11] as int,
    );
  }

  @override
  void write(BinaryWriter writer, DiemTongKet obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.namBatDau)
      ..writeByte(1)
      ..write(obj.namKetThuc)
      ..writeByte(2)
      ..write(obj.hocKi)
      ..writeByte(3)
      ..write(obj.soTinChi)
      ..writeByte(4)
      ..write(obj.diem4)
      ..writeByte(5)
      ..write(obj.diem10)
      ..writeByte(6)
      ..write(obj.diemHb)
      ..writeByte(7)
      ..write(obj.tinChiTichLuyHocKi)
      ..writeByte(8)
      ..write(obj.xepLoai)
      ..writeByte(9)
      ..write(obj.diem4TichLuy)
      ..writeByte(10)
      ..write(obj.diem10TichLuy)
      ..writeByte(11)
      ..write(obj.tongTinChiTichLuy);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DiemTongKetAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class DiemHocPhanTheoKyAdapter extends TypeAdapter<DiemHocPhanTheoKy> {
  @override
  final int typeId = 3;

  @override
  DiemHocPhanTheoKy read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DiemHocPhanTheoKy(
      namBatDau: fields[0] as int,
      namKetThuc: fields[1] as int,
      hocKi: fields[2] as int,
      listDiemHocPhan: (fields[3] as List).cast<DiemHocPhan>(),
    );
  }

  @override
  void write(BinaryWriter writer, DiemHocPhanTheoKy obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.namBatDau)
      ..writeByte(1)
      ..write(obj.namKetThuc)
      ..writeByte(2)
      ..write(obj.hocKi)
      ..writeByte(3)
      ..write(obj.listDiemHocPhan);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DiemHocPhanTheoKyAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class DiemHocPhanAdapter extends TypeAdapter<DiemHocPhan> {
  @override
  final int typeId = 4;

  @override
  DiemHocPhan read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DiemHocPhan(
      id: fields[0] as int,
      tbm: fields[1] as double,
      chuyenCan: fields[2] as double,
      baiTap: fields[3] as double,
      giuaKi: fields[4] as double,
      cuoiKi: fields[5] as double,
      soTinChi: fields[6] as int,
      tenHocPhan: fields[7] as String,
    );
  }

  @override
  void write(BinaryWriter writer, DiemHocPhan obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.tbm)
      ..writeByte(2)
      ..write(obj.chuyenCan)
      ..writeByte(3)
      ..write(obj.baiTap)
      ..writeByte(4)
      ..write(obj.giuaKi)
      ..writeByte(5)
      ..write(obj.cuoiKi)
      ..writeByte(6)
      ..write(obj.soTinChi)
      ..writeByte(7)
      ..write(obj.tenHocPhan);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DiemHocPhanAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
