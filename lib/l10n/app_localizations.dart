import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_id.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('id'),
  ];

  /// No description provided for @aboutThisFlower.
  ///
  /// In en, this message translates to:
  /// **'About This Flower'**
  String get aboutThisFlower;

  /// No description provided for @backButton.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get backButton;

  /// No description provided for @shopTitle.
  ///
  /// In en, this message translates to:
  /// **'BLOSSOM SHOP'**
  String get shopTitle;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @logoutQuestion.
  ///
  /// In en, this message translates to:
  /// **'Logout from Account?'**
  String get logoutQuestion;

  /// No description provided for @logoutConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to end this session?'**
  String get logoutConfirmation;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @itemAddedToCart.
  ///
  /// In en, this message translates to:
  /// **'{itemName} added!'**
  String itemAddedToCart(Object itemName);

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @meaningAndSymbolism.
  ///
  /// In en, this message translates to:
  /// **'Meaning & Symbolism'**
  String get meaningAndSymbolism;

  /// No description provided for @suitableFor.
  ///
  /// In en, this message translates to:
  /// **'Suitable For'**
  String get suitableFor;

  /// No description provided for @mainFlowerType.
  ///
  /// In en, this message translates to:
  /// **'Main Flower Type'**
  String get mainFlowerType;

  /// No description provided for @addToCart.
  ///
  /// In en, this message translates to:
  /// **'Add to Cart'**
  String get addToCart;

  /// No description provided for @searchFlowers.
  ///
  /// In en, this message translates to:
  /// **'Search for flowers...'**
  String get searchFlowers;

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome,'**
  String get welcome;

  /// No description provided for @tapFlowerHint.
  ///
  /// In en, this message translates to:
  /// **'Tap a flower to see its description and meaning'**
  String get tapFlowerHint;

  /// No description provided for @flowerWorldTitle.
  ///
  /// In en, this message translates to:
  /// **'Flower World'**
  String get flowerWorldTitle;

  /// No description provided for @flowerWorldSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Explore the wonders of nature'**
  String get flowerWorldSubtitle;

  /// No description provided for @discoverFacts.
  ///
  /// In en, this message translates to:
  /// **'Discover interesting facts about beautiful flowers'**
  String get discoverFacts;

  /// No description provided for @read.
  ///
  /// In en, this message translates to:
  /// **'Read'**
  String get read;

  /// No description provided for @readMore.
  ///
  /// In en, this message translates to:
  /// **'Read More'**
  String get readMore;

  /// No description provided for @logoutAppQuestion.
  ///
  /// In en, this message translates to:
  /// **'Exit the Application?'**
  String get logoutAppQuestion;

  /// No description provided for @roseTitle.
  ///
  /// In en, this message translates to:
  /// **'Rose: Universal Symbol of Love'**
  String get roseTitle;

  /// No description provided for @roseSubtitle.
  ///
  /// In en, this message translates to:
  /// **'The red rose is the most recognized symbol of love worldwide. It is often given as a gift to express feelings of affection, passion, and respect. There are over 150 species of roses worldwide.'**
  String get roseSubtitle;

  /// No description provided for @tulipTitle.
  ///
  /// In en, this message translates to:
  /// **'Tulip: Once More Valuable Than Gold'**
  String get tulipTitle;

  /// No description provided for @tulipSubtitle.
  ///
  /// In en, this message translates to:
  /// **'In 17th-century Netherlands, during a period known as \'Tulip Mania,\' some rare tulip bulbs could be worth as much as a luxury house in Amsterdam. This phenomenon is considered one of the first speculative bubbles in history.'**
  String get tulipSubtitle;

  /// No description provided for @orchidTitle.
  ///
  /// In en, this message translates to:
  /// **'Orchid: One of the Largest Flower Families'**
  String get orchidTitle;

  /// No description provided for @orchidSubtitle.
  ///
  /// In en, this message translates to:
  /// **'With over 25,000 identified species, orchids are one of the largest and most diverse families of flowering plants in the world. They can be found in almost every habitat on earth.'**
  String get orchidSubtitle;

  /// No description provided for @sunflowerTitle.
  ///
  /// In en, this message translates to:
  /// **'Sunflower: Always Facing the Sun'**
  String get sunflowerTitle;

  /// No description provided for @sunflowerSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Young sunflowers exhibit a unique behavior called heliotropism, where their buds follow the sun\'s movement from east to west each day. However, as adults, most will stop and face east.'**
  String get sunflowerSubtitle;

  /// No description provided for @lavenderTitle.
  ///
  /// In en, this message translates to:
  /// **'Lavender: Not Just for Aroma'**
  String get lavenderTitle;

  /// No description provided for @lavenderSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Besides being widely used in aromatherapy for relaxation, lavender has historically been used as an antiseptic and anti-inflammatory. Its oil can be applied to soothe insect bites or minor burns.'**
  String get lavenderSubtitle;

  /// No description provided for @welcomeHeader.
  ///
  /// In en, this message translates to:
  /// **'WELCOME'**
  String get welcomeHeader;

  /// No description provided for @pleaseLogin.
  ///
  /// In en, this message translates to:
  /// **'Please sign in to your account'**
  String get pleaseLogin;

  /// No description provided for @roleUser.
  ///
  /// In en, this message translates to:
  /// **'User'**
  String get roleUser;

  /// No description provided for @roleAdmin.
  ///
  /// In en, this message translates to:
  /// **'Admin'**
  String get roleAdmin;

  /// No description provided for @enterUsername.
  ///
  /// In en, this message translates to:
  /// **'Enter your username'**
  String get enterUsername;

  /// No description provided for @enterPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get enterPassword;

  /// No description provided for @loginButton.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get loginButton;

  /// No description provided for @dontHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account? '**
  String get dontHaveAccount;

  /// No description provided for @registerNow.
  ///
  /// In en, this message translates to:
  /// **'Register Now'**
  String get registerNow;

  /// No description provided for @usernamePasswordRequired.
  ///
  /// In en, this message translates to:
  /// **'Username and password are required'**
  String get usernamePasswordRequired;

  /// No description provided for @loginSuccessFor.
  ///
  /// In en, this message translates to:
  /// **'Login successful for: {username}'**
  String loginSuccessFor(Object username);

  /// No description provided for @loginSuccessAsAdmin.
  ///
  /// In en, this message translates to:
  /// **'Login successful as Admin'**
  String get loginSuccessAsAdmin;

  /// No description provided for @adminLoginFailed.
  ///
  /// In en, this message translates to:
  /// **'Incorrect Admin username or password'**
  String get adminLoginFailed;

  /// No description provided for @createAccountHeader.
  ///
  /// In en, this message translates to:
  /// **'CREATE NEW ACCOUNT'**
  String get createAccountHeader;

  /// No description provided for @joinUsMessage.
  ///
  /// In en, this message translates to:
  /// **'Join us at blossom'**
  String get joinUsMessage;

  /// No description provided for @createYourPassword.
  ///
  /// In en, this message translates to:
  /// **'Create your password'**
  String get createYourPassword;

  /// No description provided for @confirmYourPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm your password'**
  String get confirmYourPassword;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account? '**
  String get alreadyHaveAccount;

  /// No description provided for @loginHere.
  ///
  /// In en, this message translates to:
  /// **'Login Here'**
  String get loginHere;

  /// No description provided for @registrationSuccessTitle.
  ///
  /// In en, this message translates to:
  /// **'Registration Successful!'**
  String get registrationSuccessTitle;

  /// No description provided for @registrationSuccessMessage.
  ///
  /// In en, this message translates to:
  /// **'Account with username {username} has been created successfully!'**
  String registrationSuccessMessage(Object username);

  /// No description provided for @loginNow.
  ///
  /// In en, this message translates to:
  /// **'Login Now'**
  String get loginNow;

  /// No description provided for @usernameRequired.
  ///
  /// In en, this message translates to:
  /// **'Username is required'**
  String get usernameRequired;

  /// No description provided for @usernameTooShort.
  ///
  /// In en, this message translates to:
  /// **'Username must be at least 4 characters'**
  String get usernameTooShort;

  /// No description provided for @passwordRequired.
  ///
  /// In en, this message translates to:
  /// **'Password is required'**
  String get passwordRequired;

  /// No description provided for @passwordTooShort.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters'**
  String get passwordTooShort;

  /// No description provided for @confirmPasswordRequired.
  ///
  /// In en, this message translates to:
  /// **'Password confirmation is required'**
  String get confirmPasswordRequired;

  /// No description provided for @passwordsDoNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwordsDoNotMatch;

  /// No description provided for @shoppingCartTitle.
  ///
  /// In en, this message translates to:
  /// **'Shopping Cart'**
  String get shoppingCartTitle;

  /// No description provided for @itemRemovedFromCart.
  ///
  /// In en, this message translates to:
  /// **'{itemName} removed from cart'**
  String itemRemovedFromCart(Object itemName);

  /// No description provided for @undo.
  ///
  /// In en, this message translates to:
  /// **'UNDO'**
  String get undo;

  /// No description provided for @cartEmptyCannotCheckout.
  ///
  /// In en, this message translates to:
  /// **'Cart is empty, nothing to checkout.'**
  String get cartEmptyCannotCheckout;

  /// No description provided for @yourCartIsEmpty.
  ///
  /// In en, this message translates to:
  /// **'Your cart is empty'**
  String get yourCartIsEmpty;

  /// No description provided for @nameNotAvailable.
  ///
  /// In en, this message translates to:
  /// **'Name not available'**
  String get nameNotAvailable;

  /// No description provided for @removeItem.
  ///
  /// In en, this message translates to:
  /// **'Remove item'**
  String get removeItem;

  /// No description provided for @totalPrice.
  ///
  /// In en, this message translates to:
  /// **'Total Price'**
  String get totalPrice;

  /// No description provided for @checkoutNow.
  ///
  /// In en, this message translates to:
  /// **'Checkout Now'**
  String get checkoutNow;

  /// No description provided for @payment.
  ///
  /// In en, this message translates to:
  /// **'Payment'**
  String get payment;

  /// No description provided for @totalBill.
  ///
  /// In en, this message translates to:
  /// **'TOTAL BILL'**
  String get totalBill;

  /// No description provided for @selectPaymentMethod.
  ///
  /// In en, this message translates to:
  /// **'Select Payment Method'**
  String get selectPaymentMethod;

  /// No description provided for @bankTransfer.
  ///
  /// In en, this message translates to:
  /// **'Bank Transfer'**
  String get bankTransfer;

  /// No description provided for @bankTransferSubtitle.
  ///
  /// In en, this message translates to:
  /// **'BCA, Mandiri, BNI, BRI & other banks'**
  String get bankTransferSubtitle;

  /// No description provided for @digitalWallet.
  ///
  /// In en, this message translates to:
  /// **'Digital Wallet'**
  String get digitalWallet;

  /// No description provided for @digitalWalletSubtitle.
  ///
  /// In en, this message translates to:
  /// **'GoPay, OVO, DANA, ShopeePay & LinkAja'**
  String get digitalWalletSubtitle;

  /// No description provided for @creditDebitCard.
  ///
  /// In en, this message translates to:
  /// **'Credit/Debit Card'**
  String get creditDebitCard;

  /// No description provided for @creditDebitCardSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Visa, MasterCard & other bank cards'**
  String get creditDebitCardSubtitle;

  /// No description provided for @secureTransaction.
  ///
  /// In en, this message translates to:
  /// **'Secure & Trusted Transaction'**
  String get secureTransaction;

  /// No description provided for @paymentDataProtected.
  ///
  /// In en, this message translates to:
  /// **'Your payment data is protected'**
  String get paymentDataProtected;

  /// No description provided for @payNow.
  ///
  /// In en, this message translates to:
  /// **'Pay Now'**
  String get payNow;

  /// No description provided for @processingPayment.
  ///
  /// In en, this message translates to:
  /// **'Processing Payment'**
  String get processingPayment;

  /// No description provided for @pleaseWait.
  ///
  /// In en, this message translates to:
  /// **'Please wait a moment...'**
  String get pleaseWait;

  /// No description provided for @paymentSuccessTitle.
  ///
  /// In en, this message translates to:
  /// **'Payment Successful!'**
  String get paymentSuccessTitle;

  /// No description provided for @paymentSuccessMessage.
  ///
  /// In en, this message translates to:
  /// **'Thank you for shopping at Blossom by Izora Elverda. Your order is being prepared with love.'**
  String get paymentSuccessMessage;

  /// No description provided for @confirmationEmail.
  ///
  /// In en, this message translates to:
  /// **'Confirmation Email'**
  String get confirmationEmail;

  /// No description provided for @sentToEmail.
  ///
  /// In en, this message translates to:
  /// **'Has been sent to {email}'**
  String sentToEmail(Object email);

  /// No description provided for @backToShop.
  ///
  /// In en, this message translates to:
  /// **'Back to Shop'**
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
  // Lookup logic when only language code is specified.
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
