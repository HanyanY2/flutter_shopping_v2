import 'package:flutter/material.dart';
import 'data.dart';

class FavoritesPage extends StatefulWidget {
  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    final favs = favoriteProducts;
    return Scaffold(
      appBar: AppBar(title: Text("Favorites")),
      body: favs.isEmpty
          ? Center(child: Text("You don't have favorites"))
          : ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: favs.length,
        itemBuilder: (ctx, i) {
          final item = favs[i];
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              leading: Image.asset(item['img'], width: 50, height: 50),
              title: Text(item['name']),
              subtitle: Text("\$${item['price']}"),
              trailing: IconButton(
                icon: Icon(Icons.favorite, color: Colors.red),
                onPressed: () {
                  setState(() {
                    favoriteProducts.removeAt(i);
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${item['name']} removed from favorites'),
                      duration: Duration(seconds: 1),
                    ),
                  );
                },
              ),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/detail',
                  arguments: {
                    'name': item['name'],
                    'img': item['img'],
                    'price': item['price'],
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
