import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:solo/l10n/app_localizations.dart';
import 'package:solo/payment_screen.dart';
import 'package:solo/tracking_map_screen.dart';

class CartScreen extends StatefulWidget {
  final List<Map<String, dynamic>> cartItems;
  final String email;

  const CartScreen({Key? key, required this.cartItems, required this.email}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> with SingleTickerProviderStateMixin {
  late List<Map<String, dynamic>> _cart;
  final _voucherController = TextEditingController();
  Map<String, dynamic>? _appliedVoucher;
  double _discount = 0.0;
  LatLng? _deliveryLocation;

  final List<Map<String, dynamic>> _vouchers = [
    {
      'code': 'HEMAT10',
      'type': 'percentage',
      'value': 10,
      'minPurchase': 0,
    },
    {
      'code': 'DISKON15K',
      'type': 'fixed',
      'value': 15000,
      'minPurchase': 0,
    },
    {
      'code': 'SUPERDEAL',
      'type': 'fixed',
      'value': 25000,
      'minPurchase': 150000,
    },
  ];

  @override
  void initState() {
    super.initState();
    _cart = List.from(widget.cartItems);
  }

  @override
  void dispose() {
    _voucherController.dispose();
    super.dispose();
  }

  double get _subtotal {
    return _cart.fold(0, (sum, item) => sum + (item['harga'] ?? 0));
  }

  double get _finalPrice {
    return _subtotal - _discount;
  }

  void _applyVoucher() {
    final code = _voucherController.text.toUpperCase();
    final voucher = _vouchers.firstWhere((v) => v['code'] == code, orElse: () => {});

    if (voucher.isEmpty) {
      _showErrorSnackBar('Kode voucher tidak valid');
      return;
    }

    if (_subtotal < voucher['minPurchase']) {
      _showErrorSnackBar('Minimal belanja untuk voucher ini adalah Rp ${voucher['minPurchase']}');
      return;
    }

    setState(() {
      if (voucher['type'] == 'percentage') {
        _discount = _subtotal * (voucher['value'] / 100);
      } else {
        _discount = voucher['value'].toDouble();
      }
      _appliedVoucher = voucher;
    });

    _showSuccessSnackBar('Voucher berhasil diterapkan!');
  }

  void _removeVoucher() {
    setState(() {
      _discount = 0.0;
      _appliedVoucher = null;
    });
    _voucherController.clear();
    _showSuccessSnackBar('Voucher dihapus');
  }

  void _removeItem(int index) {
    final l10n = AppLocalizations.of(context)!;
    final removedItem = _cart[index];
    setState(() {
      _cart.removeAt(index);
      if (_appliedVoucher != null) {
        _applyVoucher();
      }
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
              if (_appliedVoucher != null) {
                _applyVoucher();
              }
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
      _showErrorSnackBar(l10n.cartEmptyCannotCheckout);
      return;
    }
    if (_deliveryLocation == null) {
      _showErrorSnackBar('Silakan pilih lokasi pengiriman terlebih dahulu.');
      return;
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PaymentScreen(
          cartItems: _cart,
          totalPrice: _finalPrice,
          email: widget.email,
          deliveryLocation: _deliveryLocation!,
        ),
      ),
    );
  }

  void _selectDeliveryLocation() async {
    final selectedLocation = await Navigator.push<LatLng>(
      context,
      MaterialPageRoute(
        builder: (context) => const TrackingMapScreen(),
      ),
    );

    if (selectedLocation != null) {
      setState(() {
        _deliveryLocation = selectedLocation;
      });
      _showSuccessSnackBar('Lokasi pengiriman berhasil dipilih!');
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.green),
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
              padding: const EdgeInsets.all(24.0),
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
                  if (_appliedVoucher == null)
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _voucherController,
                            decoration: const InputDecoration(
                              hintText: 'Masukkan kode voucher',
                              border: OutlineInputBorder(),
                              isDense: true,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: _applyVoucher,
                          child: const Text('Terapkan'),
                        ),
                      ],
                    )
                  else
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Voucher Diterapkan: ${_appliedVoucher!['code']}',
                            style: TextStyle(color: Colors.green[800], fontWeight: FontWeight.bold),
                          ),
                          IconButton(
                            icon: Icon(Icons.close, color: Colors.green[800]),
                            onPressed: _removeVoucher,
                          ),
                        ],
                      ),
                    ),

                  const SizedBox(height: 16),
                  const Divider(),
                  const SizedBox(height: 16),

                  ListTile(
                    leading: Icon(Icons.location_on_outlined, color: theme.primaryColor),
                    title: const Text('Lokasi Pengiriman'),
                    subtitle: Text(
                      _deliveryLocation == null
                          ? 'Belum dipilih'
                          : 'Lat: ${_deliveryLocation!.latitude.toStringAsFixed(5)}, Lng: ${_deliveryLocation!.longitude.toStringAsFixed(5)}',
                    ),
                    trailing: TextButton(
                      onPressed: _selectDeliveryLocation,
                      child: const Text('Pilih'),
                    ),
                    contentPadding: EdgeInsets.zero,
                  ),

                  const SizedBox(height: 16),
                  const Divider(),
                  const SizedBox(height: 16),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Subtotal', style: theme.textTheme.bodyLarge),
                      Text(currencyFormatter.format(_subtotal), style: theme.textTheme.bodyLarge),
                    ],
                  ),
                  if (_discount > 0)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Diskon Voucher', style: TextStyle(color: Colors.green[700])),
                          Text('- ${currencyFormatter.format(_discount)}', style: TextStyle(color: Colors.green[700])),
                        ],
                      ),
                    ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        l10n.totalPrice,
                        style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        currencyFormatter.format(_finalPrice),
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
