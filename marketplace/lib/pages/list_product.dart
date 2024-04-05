import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class ListProductPage extends StatefulWidget {
  const ListProductPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ListProductPageState createState() => _ListProductPageState();
}

class _ListProductPageState extends State<ListProductPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  XFile? _imageFile;

  // Function to add a product to Firestore and upload image to Firebase Storage
  Future<void> addProductToFirestore() async {
    final String name = nameController.text;
    final String description = descriptionController.text;
    final double price = double.parse(priceController.text);

    if (_imageFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select an image')),
      );
      return;
    }

    try {
      // Upload image to Firebase Storage
      final Reference storageReference =
          FirebaseStorage.instance.ref().child('product_images/$name');
      await storageReference.putFile(File(_imageFile!.path));

      // Get the download URL of the uploaded image
      final String imagePath = await storageReference.getDownloadURL();

      // Add the product to Firestore
      await FirebaseFirestore.instance.collection('products').add({
        'name': name,
        'description': description,
        'price': price,
        'imagePath': imagePath,
      });

      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Product added to Firestore')),
      );
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error adding product to Firestore')),
      );
    }
  }

  Future<void> _pickImage() async {
    final XFile? pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _imageFile = pickedImage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Products'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Product Name'),
            ),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            TextField(
              controller: priceController,
              decoration: const InputDecoration(labelText: 'Price'),
              keyboardType: TextInputType.number,
            ),
            ElevatedButton(
              onPressed: _pickImage,
              child: const Text('Select Image'),
            ),
            _imageFile != null
                ? Image.file(File(_imageFile!.path))
                : const Text('No image selected'),
            ElevatedButton(
              onPressed: addProductToFirestore,
              child: const Text('Add Product to Firestore'),
            ),
            const SizedBox(height: 16),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('products').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  final products = snapshot.data!.docs;
                  return Expanded(
                    child: ListView.builder(
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        final product = products[index].data() as Map<String, dynamic>;
                        return ListTile(
                          title: Text(product['name'] as String),
                          subtitle: Text(product['description'] as String),
                          trailing: Text('\$${product['price']}'),
                        );
                      },
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
