import 'package:coffee_app/utils/extensions/currency_extension.dart';
import 'package:coffee_app/utils/extensions/string_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';

class Promo extends Equatable {
  final int idPromo;
  final String nama;
  final String type;
  final int? diskon;
  final int? nominal;
  final int? kadaluarsa;
  final String syaratKetentuan;
  final String? foto;

  const Promo({
    required this.idPromo,
    required this.nama,
    required this.type,
    required this.diskon,
    required this.nominal,
    required this.kadaluarsa,
    required this.syaratKetentuan,
    this.foto,
  });

  /// From Json
  factory Promo.fromJson(Map<String, dynamic> json) {
    return Promo(
      idPromo: json['id_promo'] as int,
      nama: json['nama'] as String,
      type: json['type'] as String,
      diskon: json['diskon'] as int?,
      nominal: json['nominal'] as int?,
      kadaluarsa: json['kadaluarsa'] as int?,
      syaratKetentuan: json['syarat_ketentuan'] as String,
      foto: json['foto'] as String?,
    );
  }

  /// To Map
  Map<String, dynamic> toMap() {
    return {
      'id_promo': idPromo,
      'nama': nama,
      'type': type,
      'diskon': diskon,
      'nominal': nominal,
      'kadaluarsa': kadaluarsa,
      'syarat_ketentuan': syaratKetentuan,
      'foto': foto,
    };
  }

  /// Mendapatkan jenis promo
  String get typeLabel => type.tr.toTitleCase();

  /// Mendapatkan besaran promo
  String get amountLabel => type == 'diskon' ? '$diskon%' : nominal!.toShortK();

  /// Mendapatkan jenis dan besaran promo
  String get typeAmountLabel => '$typeLabel $amountLabel';

  @override
  List<Object?> get props => [idPromo];
}

class ListPromoResponse {
  final int statusCode;
  final String? message;
  final List<Promo>? data;

  const ListPromoResponse({
    required this.statusCode,
    this.message,
    this.data,
  });

  /// From Json
  factory ListPromoResponse.fromJson(Map<String, dynamic> json) {
    return ListPromoResponse(
      statusCode: json['status_code'] as int,
      message: json['message'] as String?,
      data: json['status_code'] == 200 ? json['data'].map<Promo>((e) => Promo.fromJson(e)).toList() : null,
    );
  }
}

class PromoResponse {
  final int statusCode;
  final String? message;
  final Promo? data;

  const PromoResponse({
    required this.statusCode,
    this.message,
    this.data,
  });

  /// From Json
  factory PromoResponse.fromJson(Map<String, dynamic> json) {
    return PromoResponse(
      statusCode: json['status_code'] as int,
      message: json['message'] as String?,
      data: json['status_code'] == 200 ? Promo.fromJson(json['data']) : null,
    );
  }
}
