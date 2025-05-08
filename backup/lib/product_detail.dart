import 'package:flutter/material.dart';

class ProductDetail extends StatefulWidget {
  final Map<String, dynamic> product;
  final Function(Map<String, dynamic>) onAdd;

  ProductDetail({required this.product, required this.onAdd});

  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  String? selectedColor;
  String? selectedSize;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.product['name'])),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.asset(widget.product['image'], height: 200),
            SizedBox(height: 10),
            Text(widget.product['description']),
            SizedBox(height: 10),
            Text("Select Color:"),
            Wrap(
              spacing: 8,
              children: widget.product['colors']
                  .map<Widget>((color) => ChoiceChip(
                  label: Text(color),
                  selected: selectedColor == color,
                  onSelected: (_) {
                    setState(() {
                      selectedColor = color;
                    });
                  }))
                  .toList(),
            ),
            SizedBox(height: 10),
            Text("Select Size:"),
            Wrap(
              spacing: 8,
              children: widget.product['sizes']
                  .map<Widget>((size) => ChoiceChip(
                  label: Text(size),
                  selected: selectedSize == size,
                  onSelected: (_) {
                    setState(() {
                      selectedSize = size;
                    });
                  }))
                  .toList(),
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                if (selectedColor != null && selectedSize != null) {
                  widget.onAdd(widget.product);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Added to cart!")),
                  );
                }
              },
              child: Text("Add to Bag"),
            )
          ],
        ),
      ),
    );
  }
}
