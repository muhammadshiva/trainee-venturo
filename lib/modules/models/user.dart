import 'package:equatable/equatable.dart';

class User extends Equatable {
  int idUser;
  String email;
  String nama;
  String pin;
  String foto;
  int mRolesId;
  int isGoogle;
  int isCustomer;
  String roles;
  Akses? akses;

  User({
    required this.idUser,
    required this.email,
    required this.nama,
    required this.pin,
    required this.foto,
    required this.mRolesId,
    required this.isGoogle,
    required this.isCustomer,
    required this.roles,
    this.akses,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        idUser: json["id_user"],
        email: json["email"],
        nama: json["nama"],
        pin: json["pin"],
        foto: json["foto"],
        mRolesId: json["m_roles_id"],
        isGoogle: json["is_google"],
        isCustomer: json["is_customer"],
        roles: json["roles"],
        akses: Akses.fromJson(json["akses"]),
      );

  Map<String, dynamic> toJson() => {
        "id_user": idUser,
        "email": email,
        "nama": nama,
        "pin": pin,
        "foto": foto,
        "m_roles_id": mRolesId,
        "is_google": isGoogle,
        "is_customer": isCustomer,
        "roles": roles,
        "akses": akses!.toJson(),
      };

  /// To Map
  Map<String, dynamic> toMap() {
    return {
      'id_user': idUser,
      'email': email,
      'nama': nama,
      'pin': pin,
      'foto': foto,
      'roles': roles,
      'm_roles_id': mRolesId,
      'is_google': isGoogle,
      'is_customer': isCustomer,
    };
  }

  static User dummy = User(
    idUser: 0,
    email: '',
    nama: '',
    pin: '',
    foto: '',
    roles: '',
    mRolesId: 0,
    isGoogle: 0,
    isCustomer: 0,
  );

  @override
  List<Object?> get props => [idUser];
}

class UserResponse {
  final int statusCode;
  final String? message;
  final User? user;
  final String? token;

  const UserResponse({
    required this.statusCode,
    this.message,
    this.user,
    this.token,
  });

  /// From Login Json
  factory UserResponse.fromLoginJson(Map<String, dynamic> json) {
    return UserResponse(
      statusCode: json['status_code'],
      message: json['message'],
      user: json['status_code'] == 200 ? User.fromJson(json['data']['user']) : null,
      token: json['status_code'] == 200 ? json['data']['token'] : null,
    );
  }

  /// From Login Json
  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      statusCode: json['status_code'],
      message: json['message'],
      user: json['status_code'] == 200 ? User.fromJson(json['data']) : null,
    );
  }
}

class Akses {
  bool authUser;
  bool authAkses;
  bool settingMenu;
  bool settingCustomer;
  bool settingPromo;
  bool settingDiskon;
  bool settingVoucher;
  bool laporanMenu;
  bool laporanCustomer;

  Akses({
    required this.authUser,
    required this.authAkses,
    required this.settingMenu,
    required this.settingCustomer,
    required this.settingPromo,
    required this.settingDiskon,
    required this.settingVoucher,
    required this.laporanMenu,
    required this.laporanCustomer,
  });

  factory Akses.fromJson(Map<String, dynamic> json) => Akses(
        authUser: json["auth_user"],
        authAkses: json["auth_akses"],
        settingMenu: json["setting_menu"],
        settingCustomer: json["setting_customer"],
        settingPromo: json["setting_promo"],
        settingDiskon: json["setting_diskon"],
        settingVoucher: json["setting_voucher"],
        laporanMenu: json["laporan_menu"],
        laporanCustomer: json["laporan_customer"],
      );

  Map<String, dynamic> toJson() => {
        "auth_user": authUser,
        "auth_akses": authAkses,
        "setting_menu": settingMenu,
        "setting_customer": settingCustomer,
        "setting_promo": settingPromo,
        "setting_diskon": settingDiskon,
        "setting_voucher": settingVoucher,
        "laporan_menu": laporanMenu,
        "laporan_customer": laporanCustomer,
      };
}
