import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:marketplace/components/drawer.dart';
import 'package:marketplace/models/product.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ShopPage extends StatelessWidget {
  const ShopPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Shop Page"),
        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, '/cart_page'),
            icon: const Icon(Icons.shopping_cart_outlined),
          ),
        ],
      ),
      drawer: const MyDrawer(),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: [
          const SizedBox(height: 25),
          // shop subtitle
          Center(
            child: Text(
              "Pick from a selected list of products",
              style: TextStyle(
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
          ),
          // product list
          const Expanded(
            child: ProductList(),
          ),
        ],
      ),
    );
  }
}

class ProductList extends StatelessWidget {
  const ProductList({Key? key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      // Replace 'products' with your Firestore collection name
      stream: FirebaseFirestore.instance.collection('products').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          final products = snapshot.data?.docs;
          return Expanded(
            child: ListView.builder(
              itemCount: products?.length,
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.all(15),
              itemBuilder: (context, index) {
                final productData = products?[index].data() as Map<String, dynamic>;
                final product = Product(
                  name: productData['name'],
                  description: productData['description'],
                  price: productData['price'],
                  imagePath: productData['imagePath'],
                );
                return MyProductTile(product: product);
              },
            ),
          );
        }
      },
    );
  }
}

class MyProductTile extends StatelessWidget {
  final Product product;

  const MyProductTile({required this.product});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(product.name),
      subtitle: Text(product.description),
      trailing: Text('\$${product.price.toStringAsFixed(2)}'),
      leading: FutureBuilder<String>(
        future: FirebaseStorage.instance.ref(product.imagePath).getDownloadURL(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Image.network(snapshot.data!);
          } else {
            return Container(); // Placeholder or loading indicator can be added here
          }
        },
      ),
    );
  }
}
