class GetScheduleModel {
  int id;
  int idLophp;
  String noiDung;
  String thongTinQr;
  DateTime ngayDay;

  GetScheduleModel({
    required this.id,
    required this.idLophp,
    required this.noiDung,
    required this.thongTinQr,
    required this.ngayDay,
  });

  factory GetScheduleModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      throw Exception("JSON data is null");
    }

    return GetScheduleModel(
      id: json['id'] ?? 0, // Default value if id is null
      idLophp: json['idlophp'], // Default value if idTkb is null
      noiDung: json['noiDung'] ?? '', // Default empty string if null
      thongTinQr: json['thongTinQR'] ?? '', // Default empty string if null
      ngayDay: json['ngayDay'] != null ? DateTime.parse(json['ngayDay'] as String) : DateTime.now(), // Default to current date if null
    );
  }

  @override
  String toString() {
    return 'GetScheduleModel(id: $id, idTkb: $idLophp, noiDung: $noiDung, thongTinQr: $thongTinQr, ngayDay: $ngayDay)';
  }
}
