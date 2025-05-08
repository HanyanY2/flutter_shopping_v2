import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'all_products_page.dart';
import 'cart_page.dart';
import 'data.dart';
import 'favorites_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  // Three items in the bottom navigator
  final List<Widget> _pages = [
    HomePageContent(), // back to home page
    FavoritesPage(), // go to favorites page
    CartPage(), // check the cart page
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nike Shoes Shop"),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero, // fill the gap with color
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.green),
              child: Text("Menu",
                  style: TextStyle(color: Colors.white, fontSize: 27)),
            ),
            // set three elements for drawer.
            // favorites, cart and quit
            ListTile(
              leading: Icon(Icons.favorite), // put the heart icon here
              title: Text('Favorites'),
              onTap: () {
                Navigator.pop(context);
                setState(() => _currentIndex = 1); // go to index 1: the favorites page
              },
            ),
            ListTile(
              leading: Icon(Icons.shopping_cart),
              title: Text('Cart'),
              onTap: () {
                Navigator.pop(context);
                setState(() => _currentIndex = 2); // go to index 2: the cart page
              },
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Quit'),
              onTap: () {
                SystemNavigator.pop(); // quit the APP
              },
            ),
          ],
        ),
      ),

      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home),    label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.favorite),label: "Favorites"),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart),label: "Cart"),
          //BottomNavigationBarItem(icon: Icon(Icons.person),  label: "Profile"),
        ],
      ),
    );
  }
}

class HomePageContent extends StatefulWidget {
  @override
  _HomePageContentState createState() => _HomePageContentState();
}

class _HomePageContentState extends State<HomePageContent> {
  final List<String> categories = ['Lifestyle', 'Basketball', 'Running'];
  String selectedCategory = 'Lifestyle'; // the default category to present
  String searchQuery = '';  // the search bar should be empty initially

  List<Map<String, dynamic>> get productsByCategory {
    return allProducts.where((p) => p['category'] == selectedCategory).toList();
    // get data from data.dirt
    // only present the category we choose on the screen
  }

  @override
  Widget build(BuildContext context) {
    /// filtering by category
    // final filteredProducts = productsByCategory.where((p) {
    //   final query = searchQuery.toLowerCase();
    //   return p['name'].toLowerCase().contains(query);
    // }).toList();
    final filteredProducts = productsByCategory;

    // calculate the price of your cart
    final double total = cartItems.fold(0.0, (sum, item) => sum + item['price']);

    return Stack(
      children: [
        SingleChildScrollView(
          padding: EdgeInsets.only(bottom: total > 0 ? 70 : 0),
          // when hte cart have items, set gap for the floating bar
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // align hte floating bar
            children: [
              // search bar
              Padding(
                padding: const EdgeInsets.fromLTRB(17, 12, 17, 5),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Items Search',
                    prefixIcon: Icon(Icons.search),
                    // search icon in the left
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onSubmitted: (value) {
                    if (value.trim().isEmpty) return;
                    Navigator.pushNamed(
                      context,
                      '/search',
                      // go to search page
                      arguments: value.trim(),
                    );
                  },
                ),
              ),

              // set the ad on the top of homepage
              Container(
                height: 280,
                margin: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  image: DecorationImage(
                    image: AssetImage('assets/cover_ad.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(16),
                          // use round edge
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 20,
                      left: 20,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("New Release", style: TextStyle(color: Colors.white70)),
                          SizedBox(height: 6),
                          Text("Air Jordan 1 Low SE",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold)),
                          SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/all');
                              // to the all items list
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.black,
                            ),
                            child: Text("Shop Now"),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // category choosing button
              Container(
                height: 40,
                margin: EdgeInsets.symmetric(horizontal: 16),
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  separatorBuilder: (_, __) => SizedBox(width: 10),
                  itemBuilder: (_, i) {
                    final category = categories[i];
                    final isSelected = selectedCategory == category;
                    return GestureDetector(
                      onTap: () => setState(() => selectedCategory = category),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: isSelected ? Colors.orange : Colors.white,
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          category,
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              // showing the chosen category, see all can go to the items list
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("${selectedCategory}",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    GestureDetector(
                      onTap: () => Navigator.pushNamed(context, '/all'),
                      child: Text("See All", style: TextStyle(color: Colors.grey)),
                    )
                  ],
                ),
              ),

              // the item grid
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: filteredProducts.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.7,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  itemBuilder: (_, i) {
                    final p = filteredProducts[i];
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          '/detail',
                          arguments: {
                            'name': p['name'],
                            'img': p['img'],
                            'price': p['price'],
                          },
                        ).then((_) {
                          setState(() {}); // refresh the page when back to homepage
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
                            Container(
                              height: 120,
                              width: double.infinity,
                              padding: EdgeInsets.all(8),
                              child: Image.asset(
                                p['img'],
                                fit: BoxFit.contain,
                                // fit the container
                                alignment: Alignment.center,
                                errorBuilder: (_, __, ___) => Icon(Icons.broken_image, size: 60),
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(p['type'], style: TextStyle(color: Colors.grey, fontSize: 12)),
                            Text(p['name'], style: TextStyle(fontWeight: FontWeight.bold)),
                            Text("\$${p['price']}", style: TextStyle(fontSize: 14)),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: GestureDetector(
                                onTap: () {
                                  cartItems.add({
                                    'name': p['name'],
                                    'img': p['img'],
                                    'price': p['price'],
                                    'color': 'Black',
                                    // the default color
                                    'size': '40',
                                    // the default size ( when you click the "Add" icon
                                  });
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('${p['name']} added to cart'),
                                      duration: Duration(seconds: 1),
                                    ),
                                  );
                                  setState(() {});
                                },
                                child: Icon(Icons.add_circle_outline),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),

        // The floating bar for cart price
        if (total > 0)
          Positioned(
            left: 0,
            right: 0,
            bottom: 15,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 6)],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("\$${total.toStringAsFixed(2)}",
                      style: TextStyle(color: Colors.white, fontSize: 16)),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/cart')
                          .then((_) => setState(() {})); // refresh when back to homepage
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text("Checkout"),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}

