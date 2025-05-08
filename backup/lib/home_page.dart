import 'package:flutter/material.dart';
import 'product_data.dart';
import 'product_detail.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> cart = [];

  void addToCart(Map<String, dynamic> product) {
    setState(() {
      cart.add(product);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Shoe Store"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Center(
              child: Text("Items: ${cart.length}"),
            ),
          )
        ],
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(10),
        itemCount: products.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // 每行两个
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 1,
        ),
        itemBuilder: (context, index) {
          final product = products[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                  builder: (_) => ProductDetail(
                    product: product,
                    onAdd: addToCart,
                  )
              ));
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.all(8),
              child: Column(
                children: [
                  Expanded(child: Image.asset(product['image'], fit: BoxFit.cover)),
                  Text(product['name'], style: TextStyle(fontWeight: FontWeight.bold)),
                  Text("\$${product['price']}"),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () => addToCart(product),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
