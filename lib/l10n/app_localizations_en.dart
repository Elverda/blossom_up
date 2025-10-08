// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get aboutThisFlower => 'About This Flower';

  @override
  String get backButton => 'Back';

  @override
  String get shopTitle => 'BLOSSOM SHOP';

  @override
  String get logout => 'Logout';

  @override
  String get logoutQuestion => 'Logout from Account?';

  @override
  String get logoutConfirmation => 'Are you sure you want to end this session?';

  @override
  String get cancel => 'Cancel';

  @override
  String itemAddedToCart(Object itemName) {
    return '$itemName added!';
  }

  @override
  String get description => 'Description';

  @override
  String get meaningAndSymbolism => 'Meaning & Symbolism';

  @override
  String get suitableFor => 'Suitable For';

  @override
  String get mainFlowerType => 'Main Flower Type';

  @override
  String get addToCart => 'Add to Cart';

  @override
  String get searchFlowers => 'Search for flowers...';

  @override
  String get welcome => 'Welcome,';

  @override
  String get tapFlowerHint => 'Tap a flower to see its description and meaning';
}
