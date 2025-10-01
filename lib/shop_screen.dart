import 'package:flutter/material.dart';
import 'package:solo/login_page.dart';
import 'package:solo/search.dart';
import 'cart_screen.dart';

class ShopScreen extends StatefulWidget {
  final String email;
  const ShopScreen({Key? key, required this.email}) : super(key: key);

  @override
  _ShopScreenState createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> with TickerProviderStateMixin {
  List<Map<String, dynamic>> _cart = [];
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;
  late TextEditingController _searchController;
  List<Map<String, dynamic>> _filteredBunga = [];

  final List<Map<String, dynamic>> bunga = [
    {
      "nama": "BUKET BUNGA MERAH",
      "image": "assets/images/buket_merah.jpeg",
      "harga": 90000,
      "deskripsi": "Buket bunga merah yang memukau dengan keindahan klasik yang tak lekang oleh waktu.",
      "makna": "Melambangkan cinta yang mendalam, gairah, dan keberanian. Bunga merah juga menyimbolkan kekuatan dan semangat yang berapi-api.",
      "cocokUntuk": "Ungkapan cinta romantis, anniversary, Valentine's Day, atau saat ingin menyatakan perasaan cinta yang tulus.",
      "jenisUtama": "Mawar merah, tulip merah, dan anyelir merah"
    },
    {
      "nama": "BUKET BUNGA PUTIH",
      "image": "assets/images/buket_putih.jpeg",
      "harga": 80000,
      "deskripsi": "Buket bunga putih yang elegan mencerminkan kemurnian dan kedamaian.",
      "makna": "Melambangkan kemurnian, kedamaian, ketulusan, dan harapan baru. Putih juga menyimbolkan spiritualitas dan kesucian hati.",
      "cocokUntuk": "Pernikahan, baptisan, wisuda, belasungkawa, atau momen sakral lainnya yang membutuhkan sentuhan kemurnian.",
      "jenisUtama": "Mawar putih, lily putih, dan baby's breath"
    },
    {
      "nama": "BUKET BUNGA UNGU",
      "image": "assets/images/buket_ungu.jpeg",
      "harga": 99000,
      "deskripsi": "Buket bunga ungu yang mewah memancarkan aura keanggunan dan kemisteriusan.",
      "makna": "Melambangkan kemewahan, keanggunan, kreativitas, dan kebijaksanaan. Ungu juga menyimbolkan transformasi dan spiritualitas tinggi.",
      "cocokUntuk": "Penghormatan kepada orang terhormat, pencapaian prestasi, atau hadiah untuk orang yang dikagumi.",
      "jenisUtama": "Lavender, iris ungu, dan mawar ungu"
    },
    {
      "nama": "BUKET BUNGA PINK",
      "image": "assets/images/buket_pink.jpeg",
      "harga": 80000,
      "deskripsi": "Buket bunga pink yang manis menyebarkan kehangatan dan kelembutan.",
      "makna": "Melambangkan kasih sayang yang lembut, apresiasi, rasa syukur, dan feminitas. Pink juga menyimbolkan kebahagiaan dan optimisme.",
      "cocokUntuk": "Ucapan terima kasih, hadiah untuk ibu, sahabat perempuan, atau saat ingin mengungkapkan kasih sayang yang tulus.",
      "jenisUtama": "Mawar pink, peony, dan sakura"
    },
    {
      "nama": "BUKET BUNGA KUNING",
      "image": "assets/images/buket_kuning.jpeg",
      "harga": 95000,
      "deskripsi": "Buket bunga kuning yang ceria membawa semangat dan kegembiraan.",
      "makna": "Melambangkan kegembiraan, persahabatan, kehangatan matahari, dan energi positif. Kuning juga menyimbolkan keceriaan dan harapan.",
      "cocokUntuk": "Penyemangat untuk orang sakit, hadiah persahabatan, perayaan keberhasilan, atau saat ingin menyebarkan kebahagiaan.",
      "jenisUtama": "Bunga matahari, mawar kuning, dan tulip kuning"
    },
    {
      "nama": "BUKET BUNGA MIX",
      "image": "assets/images/buket_mix.jpeg",
      "harga": 85000,
      "deskripsi": "Buket bunga campuran yang penuh warna mencerminkan keberagaman dan harmoni.",
      "makna": "Melambangkan keberagaman dalam persatuan, harmoni, dan perayaan kehidupan yang penuh warna. Mix juga menyimbolkan fleksibilitas dan adaptasi.",
      "cocokUntuk": "Perayaan ulang tahun, selamat tinggal, housewarming, atau saat ingin mengungkapkan berbagai perasaan sekaligus.",
      "jenisUtama": "Kombinasi berbagai jenis dan warna bunga"
    },
    {
      "nama": "BUKET BUNGA BIRU",
      "image": "assets/images/buket_biru.jpeg",
      "harga": 85000,
      "deskripsi": "Buket bunga biru yang langka memancarkan ketenangan dan kedamaian.",
      "makna": "Melambangkan ketenangan, kepercayaan, loyalitas, dan kebijaksanaan. Biru juga menyimbolkan stabilitas dan kesetiaan yang abadi.",
      "cocokUntuk": "Ungkapan kepercayaan, hadiah untuk pria, acara formal, atau saat ingin menyampaikan pesan kesetiaan dan kejujuran.",
      "jenisUtama": "Hydrangea biru, delphinium, dan mawar biru"
    },
    {
      "nama": "BUKET UANG",
      "image": "assets/images/buket_uang.jpeg",
      "harga": 99000,
      "deskripsi": "Buket uang kreatif yang unik dan praktis sebagai hadiah berkesan.",
      "makna": "Melambangkan kemakmuran, keberuntungan, dan doa untuk kesuksesan finansial. Juga menyimbolkan kreativitas dalam memberikan hadiah.",
      "cocokUntuk": "Wisuda, promosi kerja, pembukaan usaha baru, pernikahan, atau momen pencapaian finansial.",
      "jenisUtama": "Uang kertas yang dilipat artistik dengan hiasan bunga asli"
    },
  ];

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _filteredBunga = List.from(bunga);
    _searchController.addListener(_onSearchChanged);
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(parent: _fadeController, curve: Curves.easeIn);
    _fadeController.forward();
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {
      final query = _searchController.text.toLowerCase();
      if (query.isEmpty) {
        _filteredBunga = List.from(bunga);
      } else {
        _filteredBunga = bunga.where((item) {
          return item['nama'].toLowerCase().contains(query);
        }).toList();
      }
    });
  }

  void _addToCart(Map<String, dynamic> item) {
    setState(() {
      _cart.add(item);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(children: [
          const Icon(Icons.check_circle_outline, color: Colors.white),
          const SizedBox(width: 12),
          Expanded(child: Text('${item["nama"]} ditambahkan!')),
        ]),
        backgroundColor: Colors.green.shade600,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  void _navigateToCart() async {
    if (!mounted) return;
    final result = await Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            CartScreen(cartItems: List.from(_cart), email: widget.email),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: Tween<Offset>(begin: const Offset(1.0, 0.0), end: Offset.zero).animate(animation),
            child: child,
          );
        },
      ),
    );
    if (result is List<Map<String, dynamic>>) {
      setState(() {
        _cart = result;
      });
    }
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Text('Keluar dari Akun?', textAlign: TextAlign.center),
          content: const Text('Anda yakin ingin keluar dari sesi ini?', textAlign: TextAlign.center),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Batal', style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                      (Route<dynamic> route) => false,
                );
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red[400]),
              child: const Text('Keluar'),
            ),
          ],
        );
      },
    );
  }

  void _showProductDescription(Map<String, dynamic> item) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.7,
          minChildSize: 0.5,
          maxChildSize: 0.9,
          builder: (context, scrollController) {
            return Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: Column(
                children: [
                  // Handle
                  Container(
                    margin: const EdgeInsets.only(top: 12),
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),

                  Expanded(
                    child: SingleChildScrollView(
                      controller: scrollController,
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Image.asset(
                                  item["image"],
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item["nama"],
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                      decoration: BoxDecoration(
                                        color: Colors.purple[100],
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Text(
                                        'Rp ${item["harga"].toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}',
                                        style: TextStyle(
                                          color: Colors.purple[700],
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 24),

                          _buildInfoSection(
                            "Deskripsi",
                            item["deskripsi"],
                            Icons.info_outline,
                            Colors.blue,
                          ),

                          const SizedBox(height: 20),

                          _buildInfoSection(
                            "Makna & Simbolisme",
                            item["makna"],
                            Icons.favorite_outline,
                            Colors.red,
                          ),

                          const SizedBox(height: 20),

                          _buildInfoSection(
                            "Cocok Untuk",
                            item["cocokUntuk"],
                            Icons.event_available,
                            Colors.green,
                          ),

                          const SizedBox(height: 20),

                          _buildInfoSection(
                            "Jenis Bunga Utama",
                            item["jenisUtama"],
                            Icons.local_florist,
                            Colors.purple,
                          ),

                          const SizedBox(height: 32),

                          Row(
                            children: [
                              Expanded(
                                child: OutlinedButton.icon(
                                  onPressed: () => Navigator.pop(context),
                                  icon: const Icon(Icons.arrow_back),
                                  label: const Text('Kembali'),
                                  style: OutlinedButton.styleFrom(
                                    foregroundColor: Colors.grey[600],
                                    side: BorderSide(color: Colors.grey[300]!),
                                    padding: const EdgeInsets.symmetric(vertical: 16),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                flex: 2,
                                child: ElevatedButton.icon(
                                  onPressed: () {
                                    _addToCart(item);
                                    Navigator.pop(context);
                                  },
                                  icon: const Icon(Icons.add_shopping_cart),
                                  label: const Text('Tambah ke Keranjang'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.purple[400],
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(vertical: 16),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildInfoSection(String title, String content, IconData icon, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(width: 12),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: color.withOpacity(0.05),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: color.withOpacity(0.2)),
          ),
          child: Text(
            content,
            style: const TextStyle(
              fontSize: 14,
              height: 1.5,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFlowerCard(Map<String, dynamic> item, int index) {
    return Card(
      elevation: 4,
      shadowColor: Colors.black.withOpacity(0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => _showProductDescription(item),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 6,
              child: Stack(
                children: [
                  Image.asset(
                    item["image"],
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.info_outline,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item["nama"],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: Colors.black87,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Rp ${item["harga"].toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}',
                        style: TextStyle(
                          color: Colors.purple[700],
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      IconButton(
                        onPressed: () => _addToCart(item),
                        icon: const Icon(Icons.add_shopping_cart_rounded),
                        color: Colors.purple[400],
                        iconSize: 22,
                        splashRadius: 20,
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 120.0,
            floating: false,
            pinned: true,
            elevation: 2,
            backgroundColor: Colors.purple[400],
            actions: [
              Stack(
                children: [
                  IconButton(
                    icon: const Icon(Icons.shopping_cart_outlined),
                    onPressed: _navigateToCart,
                  ),
                  if (_cart.isNotEmpty)
                    Positioned(
                      right: 8,
                      top: 8,
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 16,
                          minHeight: 16,
                        ),
                        child: Text(
                          '${_cart.length}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              ),
              IconButton(
                icon: const Icon(Icons.logout_outlined),
                onPressed: _showLogoutDialog,
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text(
                'BLOSSOM SHOP',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  shadows: [
                    Shadow(
                      blurRadius: 2,
                      color: Colors.black.withOpacity(0.5),
                    ),
                  ],
                ),
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.purple[400]!, Colors.pink[300]!],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 12),
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AnimSearchBar(
                      width: MediaQuery.of(context).size.width,
                      textController: _searchController,
                      onSuffixTap: () {
                        _searchController.clear();
                      },
                      onSubmitted: (value) {},
                      searchBarOpen: (toggle) {},
                      helpText: "Cari bunga...",
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Selamat Datang,',
                      style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                    ),
                    Text(
                      widget.email,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.purple[50],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.purple[200]!),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.touch_app, color: Colors.purple[600], size: 20),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Ketuk bunga untuk melihat deskripsi dan makna',
                              style: TextStyle(
                                color: Colors.purple[700],
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.75,
              ),
              delegate: SliverChildBuilderDelegate(
                    (context, index) => FadeTransition(
                  opacity: _fadeAnimation,
                  child: _buildFlowerCard(_filteredBunga[index], index),
                ),
                childCount: _filteredBunga.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}