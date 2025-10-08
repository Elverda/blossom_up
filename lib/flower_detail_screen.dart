import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:solo/l10n/app_localizations.dart';

class FlowerDetailScreen extends StatelessWidget {
  final Map<String, String> flowerData;

  const FlowerDetailScreen({super.key, required this.flowerData});

  void _kembali(BuildContext context) {
    Navigator.pop(context);
  }

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
                color: const Color.fromARGB(77, 0, 0, 0),
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
                  Text(
                    AppLocalizations.of(context)!.aboutThisFlower,
                    style: const TextStyle(
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
                  const SizedBox(height: 24),
                  GFButton(
                    onPressed: () {
                      _kembali(context);
                    },
                    text: AppLocalizations.of(context)!.backButton,
                    blockButton: true,
                    color: Colors.teal[400]!,
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
