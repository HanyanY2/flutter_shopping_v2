import 'package:flutter/material.dart';
import 'data.dart';

class ProductDetail extends StatefulWidget {
  final String productName;
  final String imagePath;
  final double price;

  const ProductDetail({
    Key? key,
    required this.productName,
    required this.imagePath,
    required this.price,
  }) : super(key: key);

  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  String? selectedSize;
  String? selectedColor;
  final List<String> sizes = ['40', '41', '42', '43', '44'];
  final List<String> colors = ['Black', 'White', 'Red'];

  @override
  // you can set items as favorite in this page
  Widget build(BuildContext context) {
    final isFavorited = favoriteProducts.any((p) => p['name'] == widget.productName);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.productName),
        actions: [
          IconButton(
            icon: Icon(
              isFavorited ? Icons.favorite : Icons.favorite_border,
              color: Colors.red,
            ),
            onPressed: () {
              setState(() {
                final entry = {
                  'name': widget.productName,
                  'img': widget.imagePath,
                  'price': widget.price,
                };
                if (isFavorited) {
                  favoriteProducts.removeWhere((p) => p['name'] == widget.productName);
                } else {
                  favoriteProducts.add(entry);
                }
              });
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.asset(widget.imagePath, height: 250),
            SizedBox(height: 20),
            Text(
              widget.productName,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              "\$${widget.price}",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),

            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Select Color:",
                style: TextStyle(fontWeight: FontWeight.bold),
                // choose shoes' color
              ),
            ),
            SizedBox(height: 10),
            Wrap(
              spacing: 10,
              children: colors.map((color) {
                return ChoiceChip(
                  label: Text(color),
                  selected: selectedColor == color,
                  onSelected: (_) => setState(() => selectedColor = color),
                );
              }).toList(),
            ),
            SizedBox(height: 20),

            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Select Size:",
                style: TextStyle(fontWeight: FontWeight.bold),
                // choose shoes size
              ),
            ),
            SizedBox(height: 10),
            Wrap(
              spacing: 10,
              children: sizes.map((size) {
                return ChoiceChip(
                  label: Text(size),
                  selected: selectedSize == size,
                  onSelected: (_) => setState(() => selectedSize = size),
                );
              }).toList(),
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                if (selectedColor != null && selectedSize != null) {
                  cartItems.add({
                    'name': widget.productName,
                    'img': widget.imagePath,
                    'price': widget.price,
                    'size': selectedSize,
                    'color': selectedColor,
                    // add to the cart
                  });

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("The item is added to your cart")),
                  );
                } else {
                  // if forget choose color or size
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Please choose size and color")),
                  );
                }
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
              child: Text("Add to Cart", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
