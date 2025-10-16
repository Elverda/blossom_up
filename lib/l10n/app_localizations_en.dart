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

  @override
  String get flowerWorldTitle => 'Flower World';

  @override
  String get flowerWorldSubtitle => 'Explore the wonders of nature';

  @override
  String get discoverFacts =>
      'Discover interesting facts about beautiful flowers';

  @override
  String get read => 'Read';

  @override
  String get readMore => 'Read More';

  @override
  String get logoutAppQuestion => 'Exit the Application?';

  @override
  String get roseTitle => 'Rose: Universal Symbol of Love';

  @override
  String get roseSubtitle =>
      'The red rose is the most recognized symbol of love worldwide. It is often given as a gift to express feelings of affection, passion, and respect. There are over 150 species of roses worldwide.';

  @override
  String get tulipTitle => 'Tulip: Once More Valuable Than Gold';

  @override
  String get tulipSubtitle =>
      'In 17th-century Netherlands, during a period known as \'Tulip Mania,\' some rare tulip bulbs could be worth as much as a luxury house in Amsterdam. This phenomenon is considered one of the first speculative bubbles in history.';

  @override
  String get orchidTitle => 'Orchid: One of the Largest Flower Families';

  @override
  String get orchidSubtitle =>
      'With over 25,000 identified species, orchids are one of the largest and most diverse families of flowering plants in the world. They can be found in almost every habitat on earth.';

  @override
  String get sunflowerTitle => 'Sunflower: Always Facing the Sun';

  @override
  String get sunflowerSubtitle =>
      'Young sunflowers exhibit a unique behavior called heliotropism, where their buds follow the sun\'s movement from east to west each day. However, as adults, most will stop and face east.';

  @override
  String get lavenderTitle => 'Lavender: Not Just for Aroma';

  @override
  String get lavenderSubtitle =>
      'Besides being widely used in aromatherapy for relaxation, lavender has historically been used as an antiseptic and anti-inflammatory. Its oil can be applied to soothe insect bites or minor burns.';

  @override
  String get welcomeHeader => 'WELCOME';

  @override
  String get pleaseLogin => 'Please sign in to your account';

  @override
  String get roleUser => 'User';

  @override
  String get roleAdmin => 'Admin';

  @override
  String get enterUsername => 'Enter your username';

  @override
  String get enterPassword => 'Enter your password';

  @override
  String get loginButton => 'Login';

  @override
  String get dontHaveAccount => 'Don\'t have an account? ';

  @override
  String get registerNow => 'Register Now';

  @override
  String get usernamePasswordRequired => 'Username and password are required';

  @override
  String loginSuccessFor(Object username) {
    return 'Login successful for: $username';
  }

  @override
  String get loginSuccessAsAdmin => 'Login successful as Admin';

  @override
  String get adminLoginFailed => 'Incorrect Admin username or password';

  @override
  String get createAccountHeader => 'CREATE NEW ACCOUNT';

  @override
  String get joinUsMessage => 'Join us at blossom';

  @override
  String get createYourPassword => 'Create your password';

  @override
  String get confirmYourPassword => 'Confirm your password';

  @override
  String get alreadyHaveAccount => 'Already have an account? ';

  @override
  String get loginHere => 'Login Here';

  @override
  String get registrationSuccessTitle => 'Registration Successful!';

  @override
  String registrationSuccessMessage(Object username) {
    return 'Account with username $username has been created successfully!';
  }

  @override
  String get loginNow => 'Login Now';

  @override
  String get usernameRequired => 'Username is required';

  @override
  String get usernameTooShort => 'Username must be at least 4 characters';

  @override
  String get passwordRequired => 'Password is required';

  @override
  String get passwordTooShort => 'Password must be at least 6 characters';

  @override
  String get confirmPasswordRequired => 'Password confirmation is required';

  @override
  String get passwordsDoNotMatch => 'Passwords do not match';

  @override
  String get shoppingCartTitle => 'Shopping Cart';

  @override
  String itemRemovedFromCart(Object itemName) {
    return '$itemName removed from cart';
  }

  @override
  String get undo => 'UNDO';

  @override
  String get cartEmptyCannotCheckout => 'Cart is empty, nothing to checkout.';

  @override
  String get yourCartIsEmpty => 'Your cart is empty';

  @override
  String get nameNotAvailable => 'Name not available';

  @override
  String get removeItem => 'Remove item';

  @override
  String get totalPrice => 'Total Price';

  @override
  String get checkoutNow => 'Checkout Now';

  @override
  String get payment => 'Payment';

  @override
  String get totalBill => 'TOTAL BILL';

  @override
  String get selectPaymentMethod => 'Select Payment Method';

  @override
  String get bankTransfer => 'Bank Transfer';

  @override
  String get bankTransferSubtitle => 'BCA, Mandiri, BNI, BRI & other banks';

  @override
  String get digitalWallet => 'Digital Wallet';

  @override
  String get digitalWalletSubtitle => 'GoPay, OVO, DANA, ShopeePay & LinkAja';

  @override
  String get creditDebitCard => 'Credit/Debit Card';

  @override
  String get creditDebitCardSubtitle => 'Visa, MasterCard & other bank cards';

  @override
  String get secureTransaction => 'Secure & Trusted Transaction';

  @override
  String get paymentDataProtected => 'Your payment data is protected';

  @override
  String get payNow => 'Pay Now';

  @override
  String get processingPayment => 'Processing Payment';

  @override
  String get pleaseWait => 'Please wait a moment...';

  @override
  String get paymentSuccessTitle => 'Payment Successful!';

  @override
  String get paymentSuccessMessage =>
      'Thank you for shopping at Blossom by Izora Elverda. Your order is being prepared with love.';

  @override
  String get confirmationEmail => 'Confirmation Email';

  @override
  String sentToEmail(Object email) {
    return 'Has been sent to $email';
  }

  @override
  String get backToShop => 'Back to Shop';
}
