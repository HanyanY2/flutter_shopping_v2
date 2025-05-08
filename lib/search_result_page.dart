import 'package:flutter/material.dart';
import 'data.dart';

class SearchResultPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String keyword = ModalRoute.of(context)!.settings.arguments as String;
    final List<Map<String, dynamic>> results = allProducts.where((product) {
      return product['name'].toLowerCase().contains(keyword.toLowerCase());
    }).toList();

    return Scaffold(
      appBar: AppBar(title: Text('Results for "$keyword"')),
      body: results.isEmpty
          ? Center(child: Text("No products found."))
          : GridView.builder(
        padding: EdgeInsets.all(16),
        itemCount: results.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 0.7,
        ),
        itemBuilder: (_, i) {
          final p = results[i];
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/detail', arguments: {
                'name': p['name'],
                'img': p['img'],
                'price': p['price'],
              });
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(12),
              ),
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Image.asset(
                      p['img'],
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Icon(Icons.broken_image),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(p['type'], style: TextStyle(color: Colors.grey, fontSize: 12)),
                  Text(p['name'], style: TextStyle(fontWeight: FontWeight.bold)),
                  Text("\$${p['price']}", style: TextStyle(fontSize: 14)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
