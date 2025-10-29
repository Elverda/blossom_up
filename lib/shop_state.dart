import 'package:equatable/equatable.dart';

enum ShopStatus { initial, loading, success, error }

class BungaItem extends Equatable {
  final String nama;
  final String image;
  final int harga;
  final String deskripsi;
  final String makna;
  final String cocokUntuk;
  final String jenisUtama;

  const BungaItem({
    required this.nama,
    required this.image,
    required this.harga,
    required this.deskripsi,
    required this.makna,
    required this.cocokUntuk,
    required this.jenisUtama,
  });

  factory BungaItem.fromJson(Map<String, dynamic> json) {
    return BungaItem(
      nama: json['nama'],
      image: json['image'],
      harga: json['harga'],
      deskripsi: json['deskripsi'],
      makna: json['makna'],
      cocokUntuk: json['cocokUntuk'],
      jenisUtama: json['jenisUtama'],
    );
  }

  @override
  List<Object> get props => [nama, image, harga, deskripsi, makna, cocokUntuk, jenisUtama];
}

class ShopState extends Equatable {
  final ShopStatus status;
  final List<BungaItem> allBunga;
  final List<BungaItem> filteredBunga;
  final String searchQuery;
  final String? errorMessage;

  const ShopState({
    this.status = ShopStatus.initial,
    this.allBunga = const [],
    this.filteredBunga = const [],
    this.searchQuery = '',
    this.errorMessage,
  });

  ShopState copyWith({
    ShopStatus? status,
    List<BungaItem>? allBunga,
    List<BungaItem>? filteredBunga,
    String? searchQuery,
    String? errorMessage,
  }) {
    return ShopState(
      status: status ?? this.status,
      allBunga: allBunga ?? this.allBunga,
      filteredBunga: filteredBunga ?? this.filteredBunga,
      searchQuery: searchQuery ?? this.searchQuery,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, allBunga, filteredBunga, searchQuery, errorMessage];
}
