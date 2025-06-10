import 'package:flutter/material.dart';
import '../generated/l10n.dart'; // Import localization

class CartScreen extends StatelessWidget {
  final List<Map<String, dynamic>> cart;

  const CartScreen({Key? key, required this.cart}) : super(key: key);

  double get totalPrice =>
      cart.fold(0, (sum, item) => sum + ((item['price'] ?? 0) as double));

  @override
  Widget build(BuildContext context) {
    final loc = S.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(loc.yourCart),
        backgroundColor: Colors.deepOrange,
      ),
      body: cart.isEmpty
          ? Center(
              child: Text(loc.cartEmpty, style: const TextStyle(fontSize: 18)),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cart.length,
                    itemBuilder: (context, index) {
                      final item = cart[index];
                      return ListTile(
                        leading: Image.network(
                          item['image'] ?? '',
                          width: 50,
                          height: 50,
                          errorBuilder: (_, __, ___) =>
                              const Icon(Icons.image_not_supported),
                        ),
                        title: Text(item['localizedName'] ?? 'Unknown Item'),
                        trailing: Text(
                          '\$${(item['price'] ?? 0).toStringAsFixed(2)}',
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.deepOrange.shade100,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(12),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${loc.total}: \$${totalPrice.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(loc.checkoutNotImplemented)),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepOrange,
                          foregroundColor: Colors.white, // <-- white text here
                        ),
                        child: Text(loc.checkout),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
