class UserResponseModel {
  final int id;
  final String maSV;
  final String hoTen;
  final String? lopSinhHoat;
  final String nien_khoa;
  final String nganh;
  final String? chuyenNganh;
  final int hocKyHienTai;
  final String numberCIC;
  final String? ngaySinh;
  final String? noiSinh;
  final String? gioiTinh;
  final String? queQuan;
  final String? danToc;
  final String? dienThoai;
  final String? email;
  final bool? doanVien;
  final String? dienChinhSach;
  final String? dienThoaiGD;
  final int? namTotNghiep;
  final String? truongThptTotNghiep;
  final String? maTruongThptTotNghiep;
  final bool? status;
  final String? ngayCapCccd;
  final String? noiCapCccd;
  final String? tonGiao;
  final String? cuTruTinh;
  final String? cuTruQuanHuyen;
  final String? cuTruXaPhuong;
  final String? cuTruToThon;
  final String? maSoBHYT;
  final String emailVku;
  final String? ngayKetNap;

  UserResponseModel({
    required this.id,
    required this.maSV,
    required this.hoTen,
    this.lopSinhHoat,
    required this.nien_khoa,
    required this.nganh,
    this.chuyenNganh,
    required this.hocKyHienTai,
    required this.numberCIC,
    this.ngaySinh,
    this.noiSinh,
    this.gioiTinh,
    this.queQuan,
    this.danToc,
    this.dienThoai,
    this.email,
    this.doanVien,
    this.dienChinhSach,
    this.dienThoaiGD,
    this.namTotNghiep,
    this.truongThptTotNghiep,
    this.maTruongThptTotNghiep,
    this.status,
    this.ngayCapCccd,
    this.noiCapCccd,
    this.tonGiao,
    this.cuTruTinh,
    this.cuTruQuanHuyen,
    this.cuTruXaPhuong,
    this.cuTruToThon,
    this.maSoBHYT,
    required this.emailVku,
    this.ngayKetNap,
  });

  factory UserResponseModel.fromJson(Map<String, dynamic> json) {
    return UserResponseModel(
      id: json['id'],
      maSV: json['maSV'],
      hoTen: json['hoTen'],
      lopSinhHoat: json['lopSinhHoat'],
      nien_khoa: json['khoa'],
      nganh: json['nganh'],
      chuyenNganh: json['chuyenNganh'],
      hocKyHienTai: json['hocKyHienTai'],
      numberCIC: json['numberCIC'],
      ngaySinh: json['ngay_sinh'],
      noiSinh: json['noi_sinh'],
      gioiTinh: json['gioi_tinh'],
      queQuan: json['que_quan'],
      danToc: json['dan_toc'],
      dienThoai: json['dien_thoai'],
      email: json['email'],
      doanVien: json['doan_vien'],
      dienChinhSach: json['dien_chinh_sach'],
      dienThoaiGD: json['dien_thoai_gd'],
      namTotNghiep: json['nam_tot_nghiep'],
      truongThptTotNghiep: json['truongthpttotnghiep'],
      maTruongThptTotNghiep: json['matruongthpttotnghiep'],
      status: json['status'],
      ngayCapCccd: json['ngaycapcccd'],
      noiCapCccd: json['noicapcccd'],
      tonGiao: json['ton_giao'],
      cuTruTinh: json['cu_tru_tinh'],
      cuTruQuanHuyen: json['cu_tru_quan_huyen'],
      cuTruXaPhuong: json['cu_tru_xa_phuong'],
      cuTruToThon: json['cu_tru_to_thon'],
      maSoBHYT: json['ma_so_BHYT'],
      emailVku: json['emailvku'],
      ngayKetNap: json['ngay_ket_nap'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'maSV': maSV,
      'hoTen': hoTen,
      'lopSinhHoat': lopSinhHoat,
      'khoa': nien_khoa,
      'nganh': nganh,
      'chuyenNganh': chuyenNganh,
      'hocKyHienTai': hocKyHienTai,
      'numberCIC': numberCIC,
      'ngay_sinh': ngaySinh,
      'noi_sinh': noiSinh,
      'gioi_tinh': gioiTinh,
      'que_quan': queQuan,
      'dan_toc': danToc,
      'dien_thoai': dienThoai,
      'email': email,
      'doan_vien': doanVien,
      'dien_chinh_sach': dienChinhSach,
      'dien_thoai_gd': dienThoaiGD,
      'nam_tot_nghiep': namTotNghiep,
      'truongthpttotnghiep': truongThptTotNghiep,
      'matruongthpttotnghiep': maTruongThptTotNghiep,
      'status': status,
      'ngaycapcccd': ngayCapCccd,
      'noicapcccd': noiCapCccd,
      'ton_giao': tonGiao,
      'cu_tru_tinh': cuTruTinh,
      'cu_tru_quan_huyen': cuTruQuanHuyen,
      'cu_tru_xa_phuong': cuTruXaPhuong,
      'cu_tru_to_thon': cuTruToThon,
      'ma_so_BHYT': maSoBHYT,
      'emailvku': emailVku,
      'ngay_ket_nap': ngayKetNap,
    };
  }
}

class FetchProfileUserModel {
  final String token;

  FetchProfileUserModel({required this.token});
}
