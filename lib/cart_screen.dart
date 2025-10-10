import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:solo/l10n/app_localizations.dart';
import 'package:solo/payment_screen.dart';

class CartScreen extends StatefulWidget {
  final List<Map<String, dynamic>> cartItems;
  final String email;

  const CartScreen({Key? key, required this.cartItems, required this.email}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> with SingleTickerProviderStateMixin {
  late List<Map<String, dynamic>> _cart;

  @override
  void initState() {
    super.initState();
    _cart = List.from(widget.cartItems);
  }

  double get _totalPrice {
    return _cart.fold(0, (sum, item) => sum + (item['harga'] ?? 0));
  }

  void _removeItem(int index) {
    final l10n = AppLocalizations.of(context)!;
    final removedItem = _cart[index];
    setState(() {
      _cart.removeAt(index);
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(l10n.itemRemovedFromCart(removedItem['nama'] ?? l10n.nameNotAvailable)),
        action: SnackBarAction(
          label: l10n.undo,
          onPressed: () {
            setState(() {
              _cart.insert(index, removedItem);
            });
          },
        ),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void _navigateToPayment() {
    final l10n = AppLocalizations.of(context)!;
    if (_cart.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.cartEmptyCannotCheckout),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PaymentScreen(
          cartItems: _cart,
          totalPrice: _totalPrice,
          email: widget.email,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context).toString();
    final currencyFormatter = NumberFormat.currency(locale: locale, symbol: 'Rp ', decimalDigits: 0);

    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, _cart);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(l10n.shoppingCartTitle),
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context, _cart),
          ),
        ),
        body: _cart.isEmpty
            ? Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.shopping_cart_outlined, size: 100, color: theme.hintColor.withOpacity(0.5)),
              const SizedBox(height: 24),
              Text(
                l10n.yourCartIsEmpty,
                style: theme.textTheme.titleLarge?.copyWith(color: theme.hintColor),
              ),
            ],
          ),
        )
            : Column(
          children: [
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                itemCount: _cart.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final item = _cart[index];
                  return Dismissible(
                    key: Key(item['nama'] + index.toString()),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Icon(Icons.delete_forever, color: Colors.white, size: 32),
                    ),
                    onDismissed: (_) => _removeItem(index),
                    child: Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      elevation: 4,
                      shadowColor: theme.primaryColor.withOpacity(0.2),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(12),
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            item['image'] ?? 'assets/images/placeholder.png',
                            width: 70,
                            height: 70,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                            Icon(Icons.broken_image, size: 70, color: theme.hintColor),
                          ),
                        ),
                        title: Text(
                          item['nama'] ?? l10n.nameNotAvailable,
                          style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
                        ),
                        subtitle: Text(
                          currencyFormatter.format(item['harga'] ?? 0),
                          style: theme.textTheme.titleSmall?.copyWith(
                            color: theme.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.remove_circle_outline, color: Colors.redAccent, size: 28),
                          tooltip: l10n.removeItem,
                          onPressed: () => _removeItem(index),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              decoration: BoxDecoration(
                color: theme.cardColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 15,
                    offset: const Offset(0, -3),
                  ),
                ],
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        l10n.totalPrice,
                        style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        currencyFormatter.format(_totalPrice),
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: theme.primaryColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _navigateToPayment,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.primaryColor,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        elevation: 5,
                        shadowColor: theme.primaryColor.withOpacity(0.5),
                      ),
                      child: Text(
                        l10n.checkoutNow,
                        style: TextStyle(fontSize: 18, color: theme.colorScheme.onPrimary, fontWeight: FontWeight.w600),
                      ),
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
}
