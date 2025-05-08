import 'package:flutter/material.dart';
import 'home_page.dart';
import 'product_detail.dart';
import 'cart_page.dart';
import 'all_products_page.dart';
import 'favorites_page.dart';
import 'start_page.dart'; // for opening banner
import 'search_result_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nike Shop',
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      theme: ThemeData(
        primarySwatch: Colors.orange,
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Roboto',
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        // set the routes for different pages
        '/': (context) => StartPage(),
        '/home': (context) => HomePage(),
        '/cart': (context) => CartPage(),
        '/favorites': (context) => FavoritesPage(),
        '/all': (context) => AllProductsPage(),
        '/search': (context) => SearchResultPage(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/detail') {
          final args = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
            builder: (context) => ProductDetail(
              productName: args['name'],
              imagePath: args['img'],
              price: args['price'],
            ),
          );
        }
        return null;
      },
    );
  }
}
