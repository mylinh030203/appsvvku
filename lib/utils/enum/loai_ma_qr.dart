enum LoaiMaQR {
  DiemDanh("0"),
  ThongTin("1"),
  Khac("2"),
  QRBenNgoai("-1");

  final String value;

  const LoaiMaQR(this.value);

  static LoaiMaQR fromValue(String value) {
    return LoaiMaQR.values.firstWhere((e) => e.value == value, orElse: () => QRBenNgoai);
  }
}
