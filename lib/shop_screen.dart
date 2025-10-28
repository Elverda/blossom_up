import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:solo/chat_admin_screen.dart';
import 'package:solo/l10n/app_localizations.dart';
import 'package:solo/login_page.dart';
import 'package:solo/main.dart';
import 'package:solo/search.dart';
import 'cart_screen.dart';
import 'package:badges/badges.dart' as badges;
import 'dart:math';

// **MODIFIED:** Now stores svgData instead of url
class Avatar {
  final int id;
  final String svgData;
  final String seed;
  final String style;

  Avatar({required this.id, required this.svgData, required this.seed, required this.style});
}

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

  final Dio _dio = Dio();
  Avatar? _selectedAvatar;
  List<Avatar> _avatars = [];

  final List<String> avatarStyles = const [
    'adventurer', 'avataaars', 'big-ears', 'bottts', 'croodles',
    'fun-emoji', 'lorelei', 'micah', 'miniavs', 'notionists',
    'open-peeps', 'personas', 'pixel-art', 'shapes'
  ];

  final List<Map<String, dynamic>> bunga = [
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
    _generateAvatars();
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  // **MODIFIED:** This function now actually fetches SVG data from the network.
  Future<List<Avatar>> _fetchAvatars() async {
    final Random random = Random();
    List<Future<Avatar>> avatarFutures = [];

    for (int i = 0; i < 8; i++) {
      final String randomSeed = random.nextDouble().toString().substring(2, 9);
      final String randomStyle = avatarStyles[random.nextInt(avatarStyles.length)];
      final String url = 'https://api.dicebear.com/7.x/$randomStyle/svg?seed=$randomSeed';

      // Create a future that will resolve to an Avatar object
      final future = _dio.get(url).then((response) {
        if (response.statusCode == 200) {
          return Avatar(
            id: i + 1,
            svgData: response.data, // Store the SVG string data
            seed: randomSeed,
            style: randomStyle,
          );
        } else {
          throw DioError(requestOptions: response.requestOptions, response: response);
        }
      });
      avatarFutures.add(future);
    }

    // Wait for all network requests to complete
    final List<Avatar> newAvatars = await Future.wait(avatarFutures);
    return newAvatars;
  }

  Future<void> _generateAvatars() async {
    try {
      final newAvatars = await _fetchAvatars();
      if (mounted) {
        setState(() {
          _avatars = newAvatars;
          if (_selectedAvatar == null && _avatars.isNotEmpty) {
            _selectedAvatar = _avatars.first;
          }
        });
      }
    } catch (e) {
      print("Error generating initial avatars: $e");
    }
  }

  void _handleSelectAvatar(Avatar avatar) {
    if (mounted) {
      setState(() {
        _selectedAvatar = avatar;
      });
    }
  }

  void _showProfileDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AvatarSelectorDialog(
          initialAvatars: _avatars,
          initialSelected: _selectedAvatar,
          onSelect: (avatar) {
            _handleSelectAvatar(avatar);
          },
          fetchAvatars: _fetchAvatars,
        );
      },
    );
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
          Expanded(child: Text(AppLocalizations.of(context)!.itemAddedToCart(item["nama"]))),
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
          title: Text(AppLocalizations.of(context)!.logoutQuestion, textAlign: TextAlign.center),
          content: Text(AppLocalizations.of(context)!.logoutConfirmation, textAlign: TextAlign.center),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(AppLocalizations.of(context)!.cancel, style: const TextStyle(color: Colors.grey)),
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
              child: Text(AppLocalizations.of(context)!.logout),
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
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: Column(
                children: [
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
                            AppLocalizations.of(context)!.description,
                            item["deskripsi"],
                            Icons.info_outline,
                            Colors.blue,
                          ),
                          const SizedBox(height: 20),
                          _buildInfoSection(
                            AppLocalizations.of(context)!.meaningAndSymbolism,
                            item["makna"],
                            Icons.favorite_outline,
                            Colors.red,
                          ),
                          const SizedBox(height: 20),
                          _buildInfoSection(
                            AppLocalizations.of(context)!.suitableFor,
                            item["cocokUntuk"],
                            Icons.event_available,
                            Colors.green,
                          ),
                          const SizedBox(height: 20),
                          _buildInfoSection(
                            AppLocalizations.of(context)!.mainFlowerType,
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
                                  label: Text(AppLocalizations.of(context)!.backButton),
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
                                  label: Text(AppLocalizations.of(context)!.addToCart),
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
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 120.0,
            floating: false,
            pinned: true,
            elevation: 2,
            leading: IconButton(
              icon: const Icon(Icons.chat_bubble_outline_rounded),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ChatAdminScreen()),
                );
              },
            ),
            actions: [
              badges.Badge(
                position: badges.BadgePosition.topEnd(top: 0, end: 3),
                showBadge: _cart.isNotEmpty,
                badgeContent: Text(
                  _cart.length.toString(),
                  style: const TextStyle(color: Colors.white, fontSize: 10),
                ),
                child: IconButton(
                  icon: const Icon(Icons.shopping_cart_outlined),
                  onPressed: _navigateToCart,
                ),
              ),
              PopupMenuButton<String>(
                onSelected: (value) {
                  switch (value) {
                    case 'profile':
                      _showProfileDialog();
                      break;
                    case 'theme_light':
                      SoloApp.setTheme(context, ThemeMode.light);
                      break;
                    case 'theme_dark':
                      SoloApp.setTheme(context, ThemeMode.dark);
                      break;
                    case 'lang_en':
                      SoloApp.setLocale(context, const Locale('en', ''));
                      break;
                    case 'lang_id':
                      SoloApp.setLocale(context, const Locale('id', ''));
                      break;
                    case 'logout':
                      _showLogoutDialog();
                      break;
                  }
                },
                itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                  PopupMenuItem<String>(
                    value: 'profile',
                    child: ListTile(
                      leading: Container(
                        width: 40,
                        height: 40,
                        child: _selectedAvatar != null
                            ? SvgPicture.string( // **MODIFIED:** Use SvgPicture.string
                                _selectedAvatar!.svgData,
                                placeholderBuilder: (BuildContext context) => const CircularProgressIndicator(strokeWidth: 2),
                              )
                            : const Icon(Icons.person, color: Colors.purple),
                      ),
                      title: const Text('Profile'),
                    ),
                  ),
                  const PopupMenuDivider(),
                  const PopupMenuItem<String>(
                    value: 'theme',
                    child: ListTile(
                      leading: Icon(Icons.brightness_4_outlined),
                      title: Text('Change Theme'),
                    ),
                    enabled: false,
                  ),
                  const PopupMenuItem<String>(
                    value: 'theme_light',
                    child: Padding(
                      padding: EdgeInsets.only(left: 16.0),
                      child: Text('Light'),
                    ),
                  ),
                  const PopupMenuItem<String>(
                    value: 'theme_dark',
                    child: Padding(
                      padding: EdgeInsets.only(left: 16.0),
                      child: Text('Dark'),
                    ),
                  ),
                  const PopupMenuDivider(),
                  const PopupMenuItem<String>(
                    value: 'language',
                    child: ListTile(
                      leading: Icon(Icons.language),
                      title: Text('Change Language'),
                    ),
                    enabled: false,
                  ),
                  const PopupMenuItem<String>(
                    value: 'lang_en',
                    child: Padding(
                      padding: EdgeInsets.only(left: 16.0),
                      child: Text('English'),
                    ),
                  ),
                  const PopupMenuItem<String>(
                    value: 'lang_id',
                    child: Padding(
                      padding: EdgeInsets.only(left: 16.0),
                      child: Text('Indonesia'),
                    ),
                  ),
                  const PopupMenuDivider(),
                  PopupMenuItem<String>(
                    value: 'logout',
                    child: ListTile(
                      leading: Icon(Icons.logout_outlined, color: Colors.red[400]),
                      title: Text('Logout', style: TextStyle(color: Colors.red[400])),
                    ),
                  ),
                ],
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text(
                AppLocalizations.of(context)!.shopTitle,
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
                      helpText: AppLocalizations.of(context)!.searchFlowers,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      AppLocalizations.of(context)!.welcome,
                      style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                    ),
                    Text(
                      widget.email,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
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
                              AppLocalizations.of(context)!.tapFlowerHint,
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

class AvatarSelectorDialog extends StatefulWidget {
  final List<Avatar> initialAvatars;
  final Avatar? initialSelected;
  final Function(Avatar) onSelect;
  final Future<List<Avatar>> Function() fetchAvatars;

  const AvatarSelectorDialog({
    Key? key,
    required this.initialAvatars,
    required this.initialSelected,
    required this.onSelect,
    required this.fetchAvatars,
  }) : super(key: key);

  @override
  _AvatarSelectorDialogState createState() => _AvatarSelectorDialogState();
}

class _AvatarSelectorDialogState extends State<AvatarSelectorDialog> {
  late List<Avatar> _avatars;
  late Avatar? _selectedAvatar;
  bool _isLoading = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _avatars = widget.initialAvatars;
    _selectedAvatar = widget.initialSelected;
    if (_avatars.isEmpty) {
      _loadAvatars();
    }
  }

  Future<void> _loadAvatars() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });
    try {
      final newAvatars = await widget.fetchAvatars();
      setState(() {
        _avatars = newAvatars;
        if (_selectedAvatar == null || !newAvatars.any((a) => a.id == _selectedAvatar!.id)) {
          _selectedAvatar = newAvatars.isNotEmpty ? newAvatars.first : null;
        }
        if (_selectedAvatar != null) {
          widget.onSelect(_selectedAvatar!); // Update the main screen
        }
      });
    } on DioError catch (e) {
      String errorMessage;
      switch (e.type) {
        case DioErrorType.connectionTimeout:
        case DioErrorType.sendTimeout:
        case DioErrorType.receiveTimeout:
          errorMessage = "Connection timed out. Please try again.";
          break;
        case DioErrorType.badResponse:
          errorMessage = "Server error. Please try again later.";
          break;
        case DioErrorType.connectionError:
          errorMessage = "Network error. Check your connection.";
          break;
        case DioErrorType.cancel:
          errorMessage = "Request was cancelled.";
          break;
        default:
          errorMessage = "An unknown error occurred.";
          break;
      }
      setState(() {
        _error = errorMessage;
      });
    } catch (e) {
      setState(() {
        _error = "An unexpected error occurred.";
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('My Profile'),
      content: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Preview
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [Colors.purple.shade200, Colors.purple.shade300],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: _selectedAvatar != null
                  ? SvgPicture.string( // **MODIFIED:** Use SvgPicture.string
                      _selectedAvatar!.svgData,
                      placeholderBuilder: (context) => const CircularProgressIndicator(),
                    )
                  : const Icon(Icons.person, size: 60, color: Colors.white70),
            ),
            const SizedBox(height: 20),
            const Text('Choose from options:', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            // Grid Area
            SizedBox(
              height: 200,
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _error != null
                      ? Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.wifi_off, color: Colors.red, size: 40),
                                const SizedBox(height: 10),
                                Text(
                                  _error!,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(color: Colors.red),
                                ),
                              ],
                            ),
                          ),
                        )
                      : GridView.builder(
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                          ),
                          itemCount: _avatars.length,
                          itemBuilder: (context, index) {
                            final avatar = _avatars[index];
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedAvatar = avatar;
                                });
                                widget.onSelect(avatar);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: _selectedAvatar?.id == avatar.id
                                      ? Border.all(color: Colors.indigo.shade500, width: 3)
                                      : null,
                                ),
                                child: ClipOval(
                                  child: SvgPicture.string( // **MODIFIED:** Use SvgPicture.string
                                    avatar.svgData,
                                    placeholderBuilder: (context) => const CircularProgressIndicator(),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
            ),
            const SizedBox(height: 20),
            // Button
            ElevatedButton.icon(
              onPressed: _isLoading ? null : _loadAvatars,
              icon: _isLoading
                  ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2, valueColor: AlwaysStoppedAnimation<Color>(Colors.white)))
                  : const Icon(Icons.refresh),
              label: const Text('Get New Options'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo.shade500,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Close'),
        ),
      ],
    );
  }
}
