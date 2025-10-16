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

  @override
  String get flowerWorldTitle => 'Dunia Bunga';

  @override
  String get flowerWorldSubtitle => 'Jelajahi keajaiban alam';

  @override
  String get discoverFacts => 'Temukan fakta menarik tentang bunga-bunga indah';

  @override
  String get read => 'Baca';

  @override
  String get readMore => 'Selengkapnya';

  @override
  String get logoutAppQuestion => 'Keluar dari Aplikasi?';

  @override
  String get roseTitle => 'Mawar: Simbol Cinta Universal';

  @override
  String get roseSubtitle =>
      'Mawar merah adalah lambang cinta yang paling dikenal di seluruh dunia. Bunga ini sering diberikan sebagai hadiah untuk mengungkapkan perasaan kasih sayang, gairah, dan rasa hormat. Ada lebih dari 150 spesies mawar di seluruh dunia.';

  @override
  String get tulipTitle => 'Tulip: Pernah Lebih Berharga dari Emas';

  @override
  String get tulipSubtitle =>
      'Pada abad ke-17 di Belanda, selama periode yang dikenal sebagai \'Tulip Mania\', beberapa jenis umbi tulip langka harganya bisa setara dengan sebuah rumah mewah di Amsterdam. Fenomena ini dianggap sebagai salah satu gelembung spekulatif pertama dalam sejarah.';

  @override
  String get orchidTitle => 'Anggrek: Salah Satu Keluarga Bunga Terbesar';

  @override
  String get orchidSubtitle =>
      'Dengan lebih dari 25.000 spesies yang telah diidentifikasi, anggrek adalah salah satu keluarga tanaman berbunga terbesar dan paling beragam di dunia. Mereka dapat ditemukan di hampir setiap habitat di bumi.';

  @override
  String get sunflowerTitle => 'Bunga Matahari: Selalu Menghadap Matahari';

  @override
  String get sunflowerSubtitle =>
      'Bunga matahari muda menunjukkan perilaku unik yang disebut heliotropisme, di mana kuncupnya akan mengikuti pergerakan matahari dari timur ke barat setiap hari. Namun, saat dewasa, sebagian besar akan berhenti dan menghadap ke timur.';

  @override
  String get lavenderTitle => 'Lavender: Bukan Hanya untuk Aroma';

  @override
  String get lavenderSubtitle =>
      'Selain digunakan secara luas dalam aromaterapi untuk relaksasi, lavender juga secara historis digunakan sebagai antiseptik dan anti-inflamasi. Minyaknya dapat dioleskan untuk menenangkan sengatan serangga atau luka bakar ringan.';

  @override
  String get welcomeHeader => 'SELAMAT DATANG';

  @override
  String get pleaseLogin => 'Silakan masuk ke akun Anda';

  @override
  String get roleUser => 'Pengguna';

  @override
  String get roleAdmin => 'Admin';

  @override
  String get enterUsername => 'Masukkan username Anda';

  @override
  String get enterPassword => 'Masukkan password Anda';

  @override
  String get loginButton => 'Masuk';

  @override
  String get dontHaveAccount => 'Belum punya akun? ';

  @override
  String get registerNow => 'Daftar Sekarang';

  @override
  String get usernamePasswordRequired => 'Username dan password harus diisi';

  @override
  String loginSuccessFor(Object username) {
    return 'Login berhasil untuk: $username';
  }

  @override
  String get loginSuccessAsAdmin => 'Login berhasil sebagai Admin';

  @override
  String get adminLoginFailed => 'Username atau password Admin salah';

  @override
  String get createAccountHeader => 'DAFTAR AKUN BARU';

  @override
  String get joinUsMessage => 'Bergabunglah dengan kami di blossom';

  @override
  String get createYourPassword => 'Buat password Anda';

  @override
  String get confirmYourPassword => 'Konfirmasi password Anda';

  @override
  String get alreadyHaveAccount => 'Sudah punya akun? ';

  @override
  String get loginHere => 'Masuk Disini';

  @override
  String get registrationSuccessTitle => 'Registrasi Berhasil!';

  @override
  String registrationSuccessMessage(Object username) {
    return 'Akun dengan username $username berhasil dibuat!';
  }

  @override
  String get loginNow => 'Masuk Sekarang';

  @override
  String get usernameRequired => 'Username harus diisi';

  @override
  String get usernameTooShort => 'Username minimal 4 karakter';

  @override
  String get passwordRequired => 'Password harus diisi';

  @override
  String get passwordTooShort => 'Password minimal 6 karakter';

  @override
  String get confirmPasswordRequired => 'Konfirmasi password harus diisi';

  @override
  String get passwordsDoNotMatch => 'Password tidak sama';

  @override
  String get shoppingCartTitle => 'Keranjang Belanja';

  @override
  String itemRemovedFromCart(Object itemName) {
    return '$itemName dihapus dari keranjang';
  }

  @override
  String get undo => 'BATALKAN';

  @override
  String get cartEmptyCannotCheckout =>
      'Keranjang kosong, tidak ada yang bisa di-checkout.';

  @override
  String get yourCartIsEmpty => 'Keranjang Anda masih kosong';

  @override
  String get nameNotAvailable => 'Nama tidak tersedia';

  @override
  String get removeItem => 'Hapus item';

  @override
  String get totalPrice => 'Total Harga';

  @override
  String get checkoutNow => 'Checkout Sekarang';

  @override
  String get payment => 'Pembayaran';

  @override
  String get totalBill => 'TOTAL TAGIHAN';

  @override
  String get selectPaymentMethod => 'Pilih Metode Pembayaran';

  @override
  String get bankTransfer => 'Transfer Bank';

  @override
  String get bankTransferSubtitle => 'BCA, Mandiri, BNI, BRI & bank lainnya';

  @override
  String get digitalWallet => 'Dompet Digital';

  @override
  String get digitalWalletSubtitle => 'GoPay, OVO, DANA, ShopeePay & LinkAja';

  @override
  String get creditDebitCard => 'Kartu Kredit/Debit';

  @override
  String get creditDebitCardSubtitle => 'Visa, MasterCard & kartu bank lainnya';

  @override
  String get secureTransaction => 'Transaksi Aman & Terpercaya';

  @override
  String get paymentDataProtected => 'Data pembayaran Anda dilindungi';

  @override
  String get payNow => 'Bayar Sekarang';

  @override
  String get processingPayment => 'Memproses Pembayaran';

  @override
  String get pleaseWait => 'Mohon tunggu sebentar...';

  @override
  String get paymentSuccessTitle => 'Pembayaran Berhasil!';

  @override
  String get paymentSuccessMessage =>
      'Terima kasih telah berbelanja di Blossom by Izora Elverda. Pesanan Anda sedang kami siapkan dengan penuh cinta.';

  @override
  String get confirmationEmail => 'Email konfirmasi';

  @override
  String sentToEmail(Object email) {
    return 'Telah dikirim ke $email';
  }

  @override
  String get backToShop => 'Kembali ke Toko';
}
