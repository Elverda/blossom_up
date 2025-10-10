import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:solo/splash_screen.dart';
import 'package:solo/l10n/app_localizations.dart';

void main() {
  runApp(const SoloApp());
}

class SoloApp extends StatefulWidget {
  const SoloApp({Key? key}) : super(key: key);

  @override
  State<SoloApp> createState() => _SoloAppState();

  static void setLocale(BuildContext context, Locale newLocale) {
    _SoloAppState? state = context.findAncestorStateOfType<_SoloAppState>();
    state?.changeLanguage(newLocale);
  }

  static void setTheme(BuildContext context, ThemeMode newThemeMode) {
    _SoloAppState? state = context.findAncestorStateOfType<_SoloAppState>();
    state?.changeTheme(newThemeMode);
  }
}

class _SoloAppState extends State<SoloApp> {
  Locale? _locale;
  ThemeMode _themeMode = ThemeMode.system;

  @override
  void initState() {
    super.initState();
    _loadTheme();
  }

  void _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final theme = prefs.getString('theme') ?? 'system';
    setState(() {
      if (theme == 'light') {
        _themeMode = ThemeMode.light;
      } else if (theme == 'dark') {
        _themeMode = ThemeMode.dark;
      } else {
        _themeMode = ThemeMode.system;
      }
    });
  }

  void _saveTheme(ThemeMode themeMode) async {
    final prefs = await SharedPreferences.getInstance();
    String theme;
    if (themeMode == ThemeMode.light) {
      theme = 'light';
    } else if (themeMode == ThemeMode.dark) {
      theme = 'dark';
    } else {
      theme = 'system';
    }
    await prefs.setString('theme', theme);
  }

  void changeLanguage(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  void changeTheme(ThemeMode themeMode) {
    setState(() {
      _themeMode = themeMode;
    });
    _saveTheme(themeMode);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData lightTheme = ThemeData(
      brightness: Brightness.light,
      primarySwatch: Colors.pink,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      scaffoldBackgroundColor: Colors.grey[50],
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.purple[400],
      ),
    );

    final ThemeData darkTheme = ThemeData(
      brightness: Brightness.dark,
      primarySwatch: Colors.pink,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      scaffoldBackgroundColor: const Color(0xFF121212),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.grey[900],
      ),
      cardColor: Colors.grey[850],
      dividerColor: Colors.grey[700],
      dialogBackgroundColor: Colors.grey[850],
    );

    return MaterialApp(
      title: 'Blossom App',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: _themeMode,
      locale: _locale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''), // English
        Locale('id', ''), // Indonesian
      ],
      home: const SplashScreen(),
    );
  }
}
