import 'package:flutter/material.dart';

class FlowerDetailScreen extends StatelessWidget {
  final Map<String, String> flowerData;

  const FlowerDetailScreen({Key? key, required this.flowerData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String title = flowerData['title'] ?? 'Judul Tidak Tersedia';
    final String subtitle = flowerData['subtitle'] ?? 'Deskripsi tidak tersedia.';
    final String image = flowerData['image'] ?? 'assets/images/placeholder.png';

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 300.0,
            pinned: true,
            backgroundColor: Colors.teal[400],
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                title,
                style: const TextStyle(
                  shadows: [
                    Shadow(blurRadius: 8, color: Colors.black54)
                  ]
                ),
              ),
              background: Image.asset(
                image,
                fit: BoxFit.cover,
                color: Colors.black.withOpacity(0.3),
                colorBlendMode: BlendMode.darken,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Tentang Bunga Ini',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 17,
                      height: 1.5,
                      color: Colors.black54,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
