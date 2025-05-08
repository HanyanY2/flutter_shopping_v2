import 'package:flutter/material.dart';
import 'data.dart';

class AllProductsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("All Products")),
      body: GridView.builder(
        padding: EdgeInsets.all(16),
        itemCount: allProducts.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, mainAxisSpacing: 10, crossAxisSpacing: 10, childAspectRatio: 0.75,
        ),
        itemBuilder: (_, i) {
          final item = allProducts[i];
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/detail', arguments: item);
            },
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: Image.asset(item['img'])),
                  Text("Men's Shoes", style: TextStyle(color: Colors.grey, fontSize: 12)),
                  Text(item['name'], style: TextStyle(fontWeight: FontWeight.bold)),
                  Text("\$${item['price']}"),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
