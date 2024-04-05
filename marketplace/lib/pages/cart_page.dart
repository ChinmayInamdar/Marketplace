import 'package:flutter/material.dart';
import 'package:marketplace/components/my_button.dart';
import 'package:marketplace/models/product.dart';
import 'package:marketplace/models/shop.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  // User pressed pay button
  void payButtonPressed(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const AlertDialog(
        content: Text("Pay functionality will be added"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Access the cart
    final cart = context.watch<Shop>().cart;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Cart"),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: [
          // Cart list
          Expanded(
            child: cart.isEmpty
                ? const Center(child: Text("Your cart is empty"))
                : CartItemList(cart: cart),
          ),

          // Pay button
          Padding(
            padding: const EdgeInsets.all(50.0),
            child: MyButton(onTap: () => payButtonPressed(context), child: const Text("Pay now")),
          ),
        ],
      ),
    );
  }
}

class CartItemList extends StatelessWidget {
  final List<Product> cart;

  const CartItemList({required this.cart, super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: cart.length,
      itemBuilder: (context, index) {
        final item = cart[index];
        return CartItemTile(item: item);
      },
    );
  }
}

class CartItemTile extends StatelessWidget {
  final Product item;

  CartItemTile({required this.item, super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(item.name),
      subtitle: Text(item.price.toStringAsFixed(2)),
      trailing: IconButton(
        onPressed: () => removeItemFromCart(context, item),
        icon: const Icon(Icons.remove),
      ),
    );
  }

  // remove item from cart
  void removeItemFromCart(BuildContext context, Product product) {
    // show a dialog box to ask the user to confirm removing the item from the cart
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: const Text("Remove this item from your cart?"),
        actions: [
          // Cancel button
          MaterialButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),

          // Yes button
          MaterialButton(
            onPressed: () {
              // Pop the dialog box
              Navigator.pop(context);

              // Remove from cart
              context.read<Shop>().removeFromCart(product);
            },
            child: const Text("Yes"),
          ),
        ],
      ),
    );
  }
}
