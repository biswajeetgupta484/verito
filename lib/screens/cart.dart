import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:verito/provider/provider.dart';

class Cart extends StatefulWidget {
  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: Consumer<GlobalProvider>(
        builder: (context, globalProvider, child) {
          List<Product> cartItems = globalProvider.cartItems;
          return ListView.builder(
            itemCount: cartItems.length,
            itemBuilder: (context, index) {
              return cartItems.isEmpty
                  ? Text("No items Available")
                  : _buildProductItem(cartItems[index], globalProvider, index);
            },
          );
        },
      ),
      bottomSheet: Consumer<GlobalProvider>(
        builder: (context, globalProvider, child) {
          return Container(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Total Cart Value: \$${globalProvider.calculateTotal().toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          );
        },
      ),
    );
  }

  Widget _buildProductItem(
      Product product, GlobalProvider globalProvider, index) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: ListTile(
        title: Text(product.title),
        leading: Image.network(
          product.image,
          height: 50,
          width: 50,
        ),
        trailing: Container(
          width: 150,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () {
                      globalProvider.decreaseItemQuantity(product);
                    },
                  ),
                  Text(
                    product.quantity.toString(),
                    style: const TextStyle(fontSize: 18),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      globalProvider.increaseItemQuantity(product);
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      globalProvider.removeFromCart(product);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
