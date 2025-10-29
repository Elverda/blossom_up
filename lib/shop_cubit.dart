import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solo/shop_state.dart';

class ShopCubit extends Cubit<ShopState> {
  ShopCubit() : super(const ShopState());

  final List<Map<String, dynamic>> _bungaData = [
    {
      "nama": "BUKET BUNGA MERAH",
      "image": "assets/images/buket_merah.jpeg",
      "harga": 90000,
      "deskripsi": "Buket bunga merah yang memukau dengan keindahan klasik yang tak lekang oleh waktu.",
      "makna": "Melambangkan cinta yang mendalam, gairah, dan keberanian. Bunga merah juga menyimbolkan kekuatan dan semangat yang berapi-api.",
      "cocokUntuk": "Ungkapan cinta romantis, anniversary, Valentine\'s Day, atau saat ingin menyatakan perasaan cinta yang tulus.",
      "jenisUtama": "Mawar merah, tulip merah, dan anyelir merah"
    },
    {"nama": "BUKET BUNGA PUTIH", "image": "assets/images/buket_putih.jpeg", "harga": 80000, "deskripsi": "Buket bunga putih yang elegan mencerminkan kemurnian dan kedamaian.", "makna": "Melambangkan kemurnian, kedamaian, ketulusan, dan harapan baru. Putih juga menyimbolkan spiritualitas dan kesucian hati.", "cocokUntuk": "Pernikahan, baptisan, wisuda, belasungkawa, atau momen sakral lainnya yang membutuhkan sentuhan kemurnian.", "jenisUtama": "Mawar putih, lily putih, dan baby\'s breath"},
    {"nama": "BUKET BUNGA UNGU", "image": "assets/images/buket_ungu.jpeg", "harga": 99000, "deskripsi": "Buket bunga ungu yang mewah memancarkan aura keanggunan dan kemisteriusan.", "makna": "Melambangkan kemewahan, keanggunan, kreativitas, dan kebijaksanaan. Ungu juga menyimbolkan transformasi dan spiritualitas tinggi.", "cocokUntuk": "Penghormatan kepada orang terhormat, pencapaian prestasi, atau hadiah untuk orang yang dikagumi.", "jenisUtama": "Lavender, iris ungu, dan mawar ungu"},
    {"nama": "BUKET BUNGA PINK", "image": "assets/images/buket_pink.jpeg", "harga": 80000, "deskripsi": "Buket bunga pink yang manis menyebarkan kehangatan dan kelembutan.", "makna": "Melambangkan kasih sayang yang lembut, apresiasi, rasa syukur, dan feminitas. Pink juga menyimbolkan kebahagiaan dan optimisme.", "cocokUntuk": "Ucapan terima kasih, hadiah untuk ibu, sahabat perempuan, atau saat ingin mengungkapkan kasih sayang yang tulus.", "jenisUtama": "Mawar pink, peony, dan sakura"},
    {"nama": "BUKET BUNGA KUNING", "image": "assets/images/buket_kuning.jpeg", "harga": 95000, "deskripsi": "Buket bunga kuning yang ceria membawa semangat dan kegembiraan.", "makna": "Melambangkan kegembiraan, persahabatan, kehangatan matahari, dan energi positif. Kuning juga menyimbolkan keceriaan dan harapan.", "cocokUntuk": "Penyemangat untuk orang sakit, hadiah persahabatan, perayaan keberhasilan, atau saat ingin menyebarkan kebahagiaan.", "jenisUtama": "Bunga matahari, mawar kuning, dan tulip kuning"},
    {"nama": "BUKET BUNGA MIX", "image": "assets/images/buket_mix.jpeg", "harga": 85000, "deskripsi": "Buket bunga campuran yang penuh warna mencerminkan keberagaman dan harmoni.", "makna": "Melambangkan keberagaman dalam persatuan, harmoni, dan perayaan kehidupan yang penuh warna. Mix juga menyimbolkan fleksibilitas dan adaptasi.", "cocokUntuk": "Perayaan ulang tahun, selamat tinggal, housewarming, atau saat ingin mengungkapkan berbagai perasaan sekaligus.", "jenisUtama": "Kombinasi berbagai jenis dan warna bunga"},
    {"nama": "BUKET BUNGA BIRU", "image": "assets/images/buket_biru.jpeg", "harga": 85000, "deskripsi": "Buket bunga biru yang langka memancarkan ketenangan dan kedamaian.", "makna": "Melambangkan ketenangan, kepercayaan, loyalitas, dan kebijaksanaan. Biru juga menyimbolkan stabilitas dan kesetiaan yang abadi.", "cocokUntuk": "Ungkapan kepercayaan, hadiah untuk pria, acara formal, atau saat ingin menyampaikan pesan kesetiaan dan kejujuran.", "jenisUtama": "Hydrangea biru, delphinium, dan mawar biru"},
    {"nama": "BUKET UANG", "image": "assets/images/buket_uang.jpeg", "harga": 99000, "deskripsi": "Buket uang kreatif yang unik dan praktis sebagai hadiah berkesan.", "makna": "Melambangkan kemakmuran, keberuntungan, dan doa untuk kesuksesan finansial. Juga menyimbolkan kreativitas dalam memberikan hadiah.", "cocokUntuk": "Wisuda, promosi kerja, pembukaan usaha baru, pernikahan, atau momen pencapaian finansial.", "jenisUtama": "Uang kertas yang dilipat artistik dengan hiasan bunga asli"},
  ];

  void loadBunga() {
    try {
      emit(state.copyWith(status: ShopStatus.loading));

      final List<BungaItem> bungaItems = _bungaData.map((data) => BungaItem.fromJson(data)).toList();

      emit(state.copyWith(
        status: ShopStatus.success,
        allBunga: bungaItems,
        filteredBunga: bungaItems,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: ShopStatus.error,
        errorMessage: "Failed to load flower data.",
      ));
    }
  }

  void filterBunga(String query) {
    final String lowerCaseQuery = query.toLowerCase();

    if (lowerCaseQuery.isEmpty) {
      emit(state.copyWith(
        filteredBunga: state.allBunga,
        searchQuery: '',
      ));
    } else {
      final List<BungaItem> filteredList = state.allBunga
          .where((bunga) => bunga.nama.toLowerCase().contains(lowerCaseQuery))
          .toList();

      emit(state.copyWith(
        filteredBunga: filteredList,
        searchQuery: query,
      ));
    }
  }
}
