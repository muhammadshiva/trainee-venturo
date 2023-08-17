import 'package:coffee_app/constants/commons/constants.dart';
import 'package:equatable/equatable.dart';

class Menu extends Equatable {
  final int idMenu;
  final String nama;
  final String kategori;
  final int harga;
  final String deskripsi;
  final String foto;
  final int status;

  const Menu({
    required this.idMenu,
    required this.nama,
    required this.kategori,
    required this.harga,
    required this.deskripsi,
    required this.foto,
    required this.status,
  });

  /// is this menu is food
  bool get isFood => kategori == AppConst.foodCategory;

  /// is this menu is drink
  bool get isDrink => kategori == AppConst.drinkCategory;

  /// From json
  factory Menu.fromJson(Map<String, dynamic> json) {
    return Menu(
      idMenu: json['id_menu'] as int,
      nama: json['nama'] as String,
      kategori: json['kategori'] as String,
      harga: json['harga'] as int,
      deskripsi: json['deskripsi'] as String,
      foto: (json['foto'] ?? AppConst.defaultMenuPhoto) as String,
      status: json['status'] as int,
    );
  }

  /// To map
  Map<String, dynamic> toMap() {
    return {
      'id_menu': idMenu,
      'nama': nama,
      'kategori': kategori,
      'harga': harga,
      'deskripsi': deskripsi,
      'foto': foto,
      'status': status,
    };
  }

  @override
  List<Object?> get props => [idMenu];
}

class MenuVariant extends Equatable {
  final int idDetail;
  final String keterangan;
  final String type;
  final int harga;

  const MenuVariant({
    required this.idDetail,
    required this.keterangan,
    required this.type,
    required this.harga,
  });

  /// From json
  factory MenuVariant.fromJson(Map<String, dynamic> json) {
    return MenuVariant(
      idDetail: json['id_detail'] as int,
      keterangan: json['keterangan'] as String,
      type: json['type'] as String,
      harga: json['harga'] as int,
    );
  }

  /// To map
  Map<String, dynamic> toMap() {
    return {
      'id_detail': idDetail,
      'keterangan': keterangan,
      'type': type,
      'harga': harga,
    };
  }

  @override
  List<Object?> get props => [idDetail];
}

class ListMenuResponse {
  final int statusCode;
  final String? message;
  final List<Menu>? data;

  ListMenuResponse({
    required this.statusCode,
    this.message,
    this.data,
  });

  /// From json
  factory ListMenuResponse.fromJson(Map<String, dynamic> json) {
    return ListMenuResponse(
      statusCode: json['status_code'] as int,
      message: json['message'] as String?,
      data: json['status_code'] == 200 ? json['data'].map<Menu>((e) => Menu.fromJson(e)).toList() : null,
    );
  }
}

class MenuResponse {
  final int statusCode;
  final String? message;
  final Menu? data;
  final List<MenuVariant> topping;
  final List<MenuVariant> level;

  MenuResponse({
    required this.statusCode,
    this.message,
    this.data,
    this.topping = const <MenuVariant>[],
    this.level = const <MenuVariant>[],
  });

  /// From json
  factory MenuResponse.fromJson(Map<String, dynamic> json) {
    return MenuResponse(
      statusCode: json['status_code'] as int,
      message: json['message'] as String?,
      data: json['status_code'] == 200 ? Menu.fromJson(json['data']['menu']) : null,
      topping: json['status_code'] == 200 && json['data']['topping'] is List
          ? json['data']['topping'].map<MenuVariant>((e) => MenuVariant.fromJson(e)).toList()
          : const <MenuVariant>[],
      level: json['status_code'] == 200 && json['data']['level'] is List
          ? json['data']['level'].map<MenuVariant>((e) => MenuVariant.fromJson(e)).toList()
          : const <MenuVariant>[],
    );
  }
}
