// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Indonesian (`id`).
class AppLocalizationsId extends AppLocalizations {
  AppLocalizationsId([String locale = 'id']) : super(locale);

  @override
  String get aboutThisFlower => 'Tentang Bunga Ini';

  @override
  String get backButton => 'Kembali';

  @override
  String get shopTitle => 'BLOSSOM SHOP';

  @override
  String get logout => 'Keluar';

  @override
  String get logoutQuestion => 'Keluar dari Akun?';

  @override
  String get logoutConfirmation => 'Anda yakin ingin keluar dari sesi ini?';

  @override
  String get cancel => 'Batal';

  @override
  String itemAddedToCart(Object itemName) {
    return '$itemName ditambahkan!';
  }

  @override
  String get description => 'Deskripsi';

  @override
  String get meaningAndSymbolism => 'Makna & Simbolisme';

  @override
  String get suitableFor => 'Cocok Untuk';

  @override
  String get mainFlowerType => 'Jenis Bunga Utama';

  @override
  String get addToCart => 'Tambah ke Keranjang';

  @override
  String get searchFlowers => 'Cari bunga...';

  @override
  String get welcome => 'Selamat Datang,';

  @override
  String get tapFlowerHint => 'Ketuk bunga untuk melihat deskripsi dan makna';
}
