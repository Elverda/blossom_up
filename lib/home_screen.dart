import 'package:flutter/material.dart';
import 'package:solo/login_page.dart';
import 'package:solo/flower_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  final String email;
  const HomeScreen({Key? key, required this.email}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  final List<Map<String, dynamic>> flowerFacts = [
    {
      "title": "Mawar: Simbol Cinta Universal",
      "subtitle": "Mawar merah adalah lambang cinta yang paling dikenal di seluruh dunia. Bunga ini sering diberikan sebagai hadiah untuk mengungkapkan perasaan kasih sayang, gairah, dan rasa hormat. Ada lebih dari 150 spesies mawar di seluruh dunia.",
      "image": "assets/images/mawarr.jpeg",
      "gradient": [Color(0xFFE91E63), Color(0xFFAD1457)],
      "icon": Icons.favorite,
    },
    {
      "title": "Tulip: Pernah Lebih Berharga dari Emas",
      "subtitle": "Pada abad ke-17 di Belanda, selama periode yang dikenal sebagai 'Tulip Mania', beberapa jenis umbi tulip langka harganya bisa setara dengan sebuah rumah mewah di Amsterdam. Fenomena ini dianggap sebagai salah satu gelembung spekulatif pertama dalam sejarah.",
      "image": "assets/images/tulip.jpeg",
      "gradient": [Color(0xFF9C27B0), Color(0xFF6A1B9A)],
      "icon": Icons.diamond,
    },
    {
      "title": "Anggrek: Salah Satu Keluarga Bunga Terbesar",
      "subtitle": "Dengan lebih dari 25.000 spesies yang telah diidentifikasi, anggrek adalah salah satu keluarga tanaman berbunga terbesar dan paling beragam di dunia. Mereka dapat ditemukan di hampir setiap habitat di bumi.",
      "image": "assets/images/anggrek.jpeg",
      "gradient": [Color(0xFF3F51B5), Color(0xFF283593)],
      "icon": Icons.nature,
    },
    {
      "title": "Bunga Matahari: Selalu Menghadap Matahari",
      "subtitle": "Bunga matahari muda menunjukkan perilaku unik yang disebut heliotropisme, di mana kuncupnya akan mengikuti pergerakan matahari dari timur ke barat setiap hari. Namun, saat dewasa, sebagian besar akan berhenti dan menghadap ke timur.",
      "image": "assets/images/Matahari.jpeg",
      "gradient": [Color(0xFFFF9800), Color(0xFFE65100)],
      "icon": Icons.wb_sunny,
    },
    {
      "title": "Lavender: Bukan Hanya untuk Aroma",
      "subtitle": "Selain digunakan secara luas dalam aromaterapi untuk relaksasi, lavender juga secara historis digunakan sebagai antiseptik dan anti-inflamasi. Minyaknya dapat dioleskan untuk menenangkan sengatan serangga atau luka bakar ringan.",
      "image": "assets/images/lavender.jpeg",
      "gradient": [Color(0xFF2196F3), Color(0xFF1565C0)],
      "icon": Icons.spa,
    },
  ];

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _slideController, curve: Curves.easeOutCubic),
    );

    _fadeController.forward();
    _slideController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFFE3F2FD),
                  Color(0xFFF3E5F5),
                ],
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2196F3).withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.logout_rounded,
                    size: 32,
                    color: Color(0xFF2196F3),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Keluar dari Aplikasi?',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1565C0),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  'Anda yakin ingin keluar dari sesi ini?',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () => Navigator.pop(context),
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Batal',
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => const LoginPage()),
                                (Route<dynamic> route) => false,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2196F3),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Keluar',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildFactCard(Map<String, dynamic> fact, int index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: fact['gradient'][0].withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Map<String, String> flowerData = {
              'title': fact['title'].toString(),
              'subtitle': fact['subtitle'].toString(),
              'image': fact['image'].toString(),
            };

            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    FlowerDetailScreen(flowerData: flowerData),
                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                  return SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(1.0, 0.0),
                      end: Offset.zero,
                    ).animate(CurvedAnimation(
                      parent: animation,
                      curve: Curves.easeInOut,
                    )),
                    child: child,
                  );
                },
              ),
            );
          },
          borderRadius: BorderRadius.circular(20),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: fact['gradient'][0].withOpacity(0.2),
                width: 1,
              ),
            ),
            child: Column(
              children: [
                // Image section with overlay
                Container(
                  height: 180,
                  width: double.infinity,
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                        child: Image.asset(
                          fact['image']!,
                          height: 180,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      // Gradient overlay
                      Container(
                        height: 180,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.3),
                            ],
                          ),
                        ),
                      ),
                      // Icon badge
                      Positioned(
                        top: 16,
                        left: 16,
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(colors: fact['gradient']),
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: fact['gradient'][0].withOpacity(0.4),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Icon(
                            fact['icon'],
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                      // Read more indicator
                      Positioned(
                        top: 16,
                        right: 16,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.9),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Baca',
                                style: TextStyle(
                                  color: fact['gradient'][0],
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: fact['gradient'][0],
                                size: 12,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Content section
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        fact['title']!,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: fact['gradient'][1],
                          letterSpacing: -0.2,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        fact['subtitle']!,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Read more button
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(colors: fact['gradient']),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            Map<String, String> flowerData = {
                              'title': fact['title'].toString(),
                              'subtitle': fact['subtitle'].toString(),
                              'image': fact['image'].toString(),
                            };

                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder: (context, animation, secondaryAnimation) =>
                                    FlowerDetailScreen(flowerData: flowerData),
                                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                  return SlideTransition(
                                    position: Tween<Offset>(
                                      begin: const Offset(1.0, 0.0),
                                      end: Offset.zero,
                                    ).animate(CurvedAnimation(
                                      parent: animation,
                                      curve: Curves.easeInOut,
                                    )),
                                    child: child,
                                  );
                                },
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Text(
                                'Selengkapnya',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(width: 8),
                              Icon(Icons.arrow_forward, color: Colors.white, size: 16),
                            ],
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 200.0,
              floating: false,
              pinned: true,
              elevation: 0,
              backgroundColor: Colors.transparent,
              actions: [
                Container(
                  margin: const EdgeInsets.only(right: 16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.logout_rounded, color: Color(0xFF2196F3)),
                    tooltip: 'Logout',
                    onPressed: _showLogoutDialog,
                  ),
                ),
              ],
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFF2196F3),
                        Color(0xFF21CBF3),
                        Color(0xFF9C27B0),
                      ],
                      stops: [0.0, 0.6, 1.0],
                    ),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        top: -30,
                        right: -30,
                        child: Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: -50,
                        left: -50,
                        child: Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.local_florist,
                                size: 40,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              'Dunia Bunga',
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                letterSpacing: 1.2,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Jelajahi keajaiban alam',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white.withOpacity(0.9),
                                fontWeight: FontWeight.w300,
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
          ];
        },
        body: ListView.builder(
          padding: const EdgeInsets.only(top: 0, bottom: 20),
          itemCount: flowerFacts.length + 1,
          itemBuilder: (context, index) {
            if (index == 0) {
              // Welcome section
              return FadeTransition(
                opacity: _fadeAnimation,
                child: Container(
                  margin: const EdgeInsets.all(20),
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF2196F3).withOpacity(0.1),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF2196F3), Color(0xFF9C27B0)],
                          ),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Icon(Icons.person_outline, color: Colors.white, size: 28),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Selamat Datang,',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              widget.email,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF2196F3),
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Temukan fakta menarik tentang bunga-bunga indah',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                                height: 1.3,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
            final factIndex = index - 1;
            return SlideTransition(
              position: _slideAnimation,
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: _buildFactCard(flowerFacts[factIndex], factIndex),
              ),
            );
          },
        ),
      ),
    );
  }
}
