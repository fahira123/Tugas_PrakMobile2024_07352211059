import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-Commerce App',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: Colors.grey[200],
      ),
      home: const HomePage(),
    );
  }
}

// Data for featured products (using price)
final List<Map<String, dynamic>> featuredProducts = [
  {"image": "assets/images/mie.jpg", "name": "Mie Goreng", "price": 20000},
  {"image": "assets/images/nasigoreng.jpg", "name": "Nasi Goreng", "price": 18000},
  {"image": "assets/images/risol.jpg", "name": "Risol", "price": 10000},
  {"image": "assets/images/kopi.jpg", "name": "Kopi Latte", "price": 25000},
  {"image": "assets/images/minuman.jpg", "name": "Es Teh Manis", "price": 5000},
];

// Data for top food (using rating)
final List<Map<String, dynamic>> topFood = [
  {"image": "assets/images/mochi.jpg", "name": "Mochi", "rating": 4.5},
  {"image": "assets/images/nasigoreng.jpg", "name": "Nasi Goreng", "rating": 4.0},
  {"image": "assets/images/mie.jpg", "name": "Mie Goreng", "rating": 4.7},
];

// Data for grid products (using price)
final List<Map<String, dynamic>> gridProducts = [
  {"image": "assets/images/jagungbakar.jpg", "name": "Jagung Bakar", "price": 12000},
  {"image": "assets/images/matcha.jpg", "name": "Matcha", "price": 18000},
  {"image": "assets/images/mochi.jpg", "name": "Mochi", "price": 20000},
  {"image": "assets/images/nasikebuli.jpg", "name": "Nasi Kebuli", "price": 25000},
  {"image": "assets/images/escincau.jpg", "name": "Es Cincau", "price": 7000},
  {"image": "assets/images/ayamgeprek.jpg", "name": "Ayam Geprek", "price": 15000},
];

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final filteredFeaturedProducts = featuredProducts
        .where((product) =>
            product["name"].toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();

    final filteredTopFood = topFood
        .where((product) =>
            product["name"].toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();

    final filteredGridProducts = gridProducts
        .where((product) =>
            product["name"].toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('E-Commerce App'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {},
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              controller: _searchController,
              onChanged: (query) {
                setState(() {
                  _searchQuery = query;
                });
              },
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search, color: Colors.indigo),
                hintText: 'Search for food...',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Banner
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(
                    colors: [Colors.indigo.shade100, Colors.indigo.shade400],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Special Offer Today!",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            "Up to 50% OFF",
                            style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                color: Colors.yellowAccent),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            "Limited time only. Grab it now!",
                            style: TextStyle(color: Colors.white70),
                          ),
                          const SizedBox(height: 12),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.indigo,
                              backgroundColor: Colors.yellowAccent.shade700,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: const Text("BUY NOW"),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        "assets/images/mie.jpg",
                        width: 250,
                        height: 250,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Featured Products (Price)
            const HeaderSection(title: "Featured Products"),
            SizedBox(
              height: 160,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: filteredFeaturedProducts.length,
                itemBuilder: (context, index) {
                  var price = filteredFeaturedProducts[index]["price"];
                  if (price is! num) {
                    price = 0.0; // Default to 0 if price is invalid
                  }
                  return ProductItemWidget(
                    name: filteredFeaturedProducts[index]["name"],
                    image: filteredFeaturedProducts[index]["image"],
                    price: price.toDouble(), // Ensure it's a double for display
                  );
                },
              ),
            ),
            const SizedBox(height: 20),

            // Top Food Section (Rating)
            const HeaderSection(title: "Top Food"),
            SizedBox(
              height: 200,
              child: ListView.builder(
                itemCount: filteredTopFood.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: ProductItemWidget(
                      name: filteredTopFood[index]["name"],
                      image: filteredTopFood[index]["image"],
                      rating: filteredTopFood[index]["rating"], // Pass rating
                      isTopFood: true, // Indicate this is a "Top Food"
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),

            // Grid of Products (Price)
            const HeaderSection(title: "All Products"),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 4,
                mainAxisSpacing: 8,
                childAspectRatio: 1,
              ),
              itemCount: filteredGridProducts.length,
              itemBuilder: (context, index) {
                var price = filteredGridProducts[index]["price"];
                if (price is! num) {
                  price = 0.0; // Default to 0 if price is invalid
                }
                return ProductItemWidget(
                  name: filteredGridProducts[index]["name"],
                  image: filteredGridProducts[index]["image"],
                  price: price.toDouble(), // Ensure it's a double for display
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class HeaderSection extends StatelessWidget {
  final String title;

  const HeaderSection({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          TextButton(
            onPressed: () {},
            child: const Text(
              "See All",
              style: TextStyle(color: Colors.indigo),
            ),
          ),
        ],
      ),
    );
  }
}

class ProductItemWidget extends StatelessWidget {
  final String name;
  final String image;
  final double price;
  final double? rating;
  final bool isTopFood;

  const ProductItemWidget({
    super.key,
    required this.name,
    required this.image,
    required this.price,
    this.rating = 0.0,
    this.isTopFood = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              image,
              width: 150,
              height: 100,
              fit: BoxFit.fill,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            name,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          if (isTopFood)
            Row(
              children: [
                Icon(
                  Icons.star,
                  color: Colors.yellow.shade700,
                  size: 16,
                ),
                Text(
                  rating.toString(),
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
          if (!isTopFood)
            Text(
              "Rp ${NumberFormat('#,###').format(price)}",
              style: const TextStyle(fontSize: 12),
            ),
        ],
      ),
    );
  }
}
