import 'package:flutter/material.dart';
import 'data.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  void removeItem(int index) {
    setState(() {
      cartItems.removeAt(index);
    });
  }

  double get totalPrice => cartItems.fold(0, (sum, item) => sum + item['price']);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Your Cart")),
      body: cartItems.isEmpty
          ? Center(child: Text("Your cart is empty"))
          : ListView.separated(
        padding: EdgeInsets.all(16),
        itemCount: cartItems.length,
        separatorBuilder: (_, __) => Divider(),
        itemBuilder: (_, i) {
          final item = cartItems[i];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Here load the items' image
                Image.asset(
                  item['img'],
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      Icon(Icons.broken_image, size: 80),
                ),
                SizedBox(width: 12),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item['name'],
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "\$${item['price']}",
                        style: TextStyle(fontSize: 15, color: Colors.grey[600]),
                      ),
                      if (item.containsKey('color'))
                        Text("Color: ${item['color']}", style: TextStyle(fontSize: 14, color: Colors.grey[700])),
                      if (item.containsKey('size'))
                        Text("Size: ${item['size']}", style: TextStyle(fontSize: 14, color: Colors.grey[700])),
                    ],
                  ),
                ),

                // delete the items that no more needing
                IconButton(
                  icon: Icon(Icons.delete_outline),
                  onPressed: () => removeItem(i),
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: cartItems.isEmpty
          ? null
          : Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Total: \$${totalPrice.toStringAsFixed(2)}",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                // check out
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Purchase successful! Thank you for buying.'),
                    behavior: SnackBarBehavior.floating,
                    margin: EdgeInsets.only(bottom: 80, left: 16, right: 16),
                    duration: Duration(seconds: 5),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                );

                // empty the cart and refresh the cart page
                setState(() {
                  cartItems.clear();
                });
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
              child: Text("Checkout", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
