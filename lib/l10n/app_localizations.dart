import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_id.dart';

abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();
  
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];
  
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('id'),
  ];
  
  String get aboutThisFlower;
  String get backButton;
  String get shopTitle;
  String get logout;
  String get logoutQuestion;
  String get logoutConfirmation;
  String get cancel;
  String itemAddedToCart(Object itemName);
  String get description;
  String get meaningAndSymbolism;
  String get suitableFor;
  String get mainFlowerType;
  String get addToCart;
  String get searchFlowers;
  String get welcome;
  String get tapFlowerHint;
  String get flowerWorldTitle;
  String get flowerWorldSubtitle;
  String get discoverFacts;
  String get read;
  String get readMore;
  String get logoutAppQuestion;
  String get roseTitle;
  String get roseSubtitle;
  String get tulipTitle;
  String get tulipSubtitle;
  String get orchidTitle;
  String get orchidSubtitle;
  String get sunflowerTitle;
  String get sunflowerSubtitle;
  String get lavenderTitle;
  String get lavenderSubtitle;
  String get welcomeHeader;
  String get pleaseLogin;
  String get roleUser;
  String get roleAdmin;
  String get enterUsername;
  String get enterPassword;
  String get loginButton;
  String get dontHaveAccount;
  String get registerNow;
  String get usernamePasswordRequired;
  String loginSuccessFor(Object username);
  String get loginSuccessAsAdmin;
  String get adminLoginFailed;
  String get createAccountHeader;
  String get joinUsMessage;
  String get createYourPassword;
  String get confirmYourPassword;
  String get alreadyHaveAccount;
  String get loginHere;
  String get registrationSuccessTitle;
  String registrationSuccessMessage(Object username);
  String get loginNow;
  String get usernameRequired;
  String get usernameTooShort;
  String get passwordRequired;
  String get passwordTooShort;
  String get confirmPasswordRequired;
  String get passwordsDoNotMatch;
  String get shoppingCartTitle;
  String itemRemovedFromCart(Object itemName);
  String get undo;
  String get cartEmptyCannotCheckout;
  String get yourCartIsEmpty;
  String get nameNotAvailable;
  String get removeItem;
  String get totalPrice;
  String get checkoutNow;
  String get payment;
  String get totalBill;
  String get selectPaymentMethod;
  String get bankTransfer;
  String get bankTransferSubtitle;
  String get digitalWallet;
  String get digitalWalletSubtitle;
  String get creditDebitCard;
  String get creditDebitCardSubtitle;
  String get secureTransaction;
  String get paymentDataProtected;
  String get payNow;
  String get processingPayment;
  String get pleaseWait;
  String get paymentSuccessTitle;
  String get paymentSuccessMessage;
  String get confirmationEmail;
  String sentToEmail(Object email);
  String get backToShop;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'id'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'id':
      return AppLocalizationsId();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
