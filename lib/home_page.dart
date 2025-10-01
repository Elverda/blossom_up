import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:solo/login_page.dart';
import 'package:solo/models/pengguna.dart';
import 'package:solo/webview_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Pengguna? _currentUser;
  String _deviceId = 'Loading...';

  @override
  void initState() {
    super.initState();
    _loadUserData();
    _getDeviceInfo();
  }

  Future<void> _loadUserData() async {
    final pengguna = await Pengguna.loadFromPreferences();
    setState(() {
      _currentUser = pengguna;
    });
  }

  Future<void> _getDeviceInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    String deviceId;
    try {
      if (Theme.of(context).platform == TargetPlatform.android) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        deviceId = androidInfo.id;
      } else if (Theme.of(context).platform == TargetPlatform.iOS) {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        deviceId = iosInfo.identifierForVendor ?? 'N/A';
      } else {
        deviceId = 'Unsupported Platform';
      }
    } catch (e) {
      deviceId = 'Failed to get device ID';
    }
    setState(() {
      _deviceId = deviceId;
    });
  }

  Future<void> _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // Clear all data

    if (mounted) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
        (route) => false, // Remove all previous routes
      );
    }
  }

  void _openWebView() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const WebViewPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        backgroundColor: Colors.pink,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome, ${_currentUser?.username ?? 'User'}',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _logout,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink,
              ),
              child: const Text('Logout'),
            ),
            const SizedBox(height: 20),
            Text('Device ID: $_deviceId'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _openWebView,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
              ),
              child: const Text('Open WebView'),
            ),
          ],
        ),
      ),
    );
  }
}
