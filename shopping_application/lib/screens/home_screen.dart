import 'package:flutter/material.dart';
import '../models/product.dart';
import '../widgets/product_card.dart';
import '../widgets/category_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TechShop'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Categories',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 120,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  CategoryCard(
                    icon: Icons.phone_android,
                    title: 'Smartphones',
                    onTap: () {},
                  ),
                  CategoryCard(
                    icon: Icons.laptop,
                    title: 'Laptops',
                    onTap: () {},
                  ),
                  CategoryCard(
                    icon: Icons.headphones,
                    title: 'Accessories',
                    onTap: () {},
                  ),
                  CategoryCard(
                    icon: Icons.watch,
                    title: 'Wearables',
                    onTap: () {},
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Latest Products',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: _getLatestProducts().length,
              itemBuilder: (context, index) {
                return ProductCard(product: _getLatestProducts()[index]);
              },
            ),
          ],
        ),
      ),
    );
  }

  List<Product> _getLatestProducts() {
    return [
      Product(
        id: '1',
        name: 'iPhone 13 Pro',
        description: 'Latest iPhone with amazing camera',
        price: 999.99,
        imageUrl: 'assets/images/iphone.jpg',
        category: 'Smartphones',
        rating: 4.8,
        reviewCount: 120,
        isFeatured: false,
        specifications: {},
      ),
      Product(
        id: '2',
        name: 'MacBook Pro M1',
        description: 'Powerful laptop for professionals',
        price: 1299.99,
        imageUrl: 'assets/images/macbook.jpg',
        category: 'Laptops',
        rating: 4.9,
        reviewCount: 85,
        isFeatured: false,
        specifications: {},
      ),
      Product(
        id: '3',
        name: 'AirPods Pro',
        description: 'Wireless earbuds with noise cancellation',
        price: 249.99,
        imageUrl: 'assets/images/airpods.jpg',
        category: 'Accessories',
        rating: 4.7,
        reviewCount: 200,
        isFeatured: false,
        specifications: {},
      ),
      Product(
        id: '4',
        name: 'Apple Watch Series 7',
        description: 'Advanced health and fitness companion',
        price: 399.99,
        imageUrl: 'assets/images/watch.jpg',
        category: 'Wearables',
        rating: 4.6,
        reviewCount: 150,
        isFeatured: false,
        specifications: {},
      ),
    ];
  }
} 