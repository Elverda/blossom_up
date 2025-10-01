import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
  final currencyFormatter = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);

  @override
  void initState() {
    super.initState();
    _cart = List.from(widget.cartItems);
  }

  double get _totalPrice {
    return _cart.fold(0, (sum, item) => sum + (item['harga'] ?? 0));
  }

  void _removeItem(int index) {
    final removedItem = _cart[index];
    setState(() {
      _cart.removeAt(index);
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${removedItem['nama']} dihapus dari keranjang'),
        action: SnackBarAction(
          label: 'UNDO',
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
    if (_cart.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Keranjang kosong, tidak ada yang bisa di-checkout.'),
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
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, _cart);
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          title: const Text('Keranjang Belanja'),
          backgroundColor: Colors.deepPurple[400],
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
              Icon(Icons.shopping_cart_outlined, size: 100, color: Colors.grey[400]),
              const SizedBox(height: 24),
              Text(
                'Keranjang Anda masih kosong',
                // FIX: Mengganti headline6 dengan titleLarge
                style: theme.textTheme.titleLarge?.copyWith(color: Colors.grey[500]),
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
                      shadowColor: Colors.deepPurple.withOpacity(0.2),
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
                            const Icon(Icons.broken_image, size: 70, color: Colors.grey),
                          ),
                        ),
                        title: Text(
                          item['nama'] ?? 'Nama tidak tersedia',
                          // FIX: Mengganti subtitle1 dengan titleMedium
                          style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
                        ),
                        subtitle: Text(
                          currencyFormatter.format(item['harga'] ?? 0),
                          // FIX: Mengganti subtitle2 dengan titleSmall
                          style: theme.textTheme.titleSmall?.copyWith(
                            color: Colors.deepPurple[700],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.remove_circle_outline, color: Colors.redAccent, size: 28),
                          tooltip: 'Hapus item',
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
                color: Colors.white,
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
                        'Total Harga',
                        style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        currencyFormatter.format(_totalPrice),
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple,
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
                        backgroundColor: Colors.deepPurple,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        elevation: 5,
                        shadowColor: Colors.deepPurpleAccent,
                      ),
                      child: const Text(
                        'Checkout Sekarang',
                        style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w600),
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