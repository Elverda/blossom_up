import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
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
}

class _SoloAppState extends State<SoloApp> {
  Locale? _locale;

  void changeLanguage(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blossom App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.pink,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
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
