import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:verito/provider/provider.dart';

class ProductListFromApi extends StatefulWidget {
  @override
  State<ProductListFromApi> createState() => _ProductListFromApiState();
}

class _ProductListFromApiState extends State<ProductListFromApi> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<GlobalProvider>(context, listen: false).fetchProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product List from API'),
      ),
      body: Consumer<GlobalProvider>(
        builder: (context, globalProvider, child) {
          final products = globalProvider.products;
          return products.isEmpty
              ? const Center(child: CircularProgressIndicator.adaptive())
              : ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return ListTile(
                      leading: Image.network(
                        product.image,
                        height: 50,
                        width: 50,
                      ),
                      title: Text(product.title),
                      subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
                      trailing: ElevatedButton(
                        onPressed: () {
                          globalProvider.addToCart(product.id);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              duration: Duration(seconds: 1),
                              content: Text('Item has been added to the cart'),
                            ),
                          );
                        },
                        child: const Text("Add to Cart"),
                      ),
                    );
                  },
                );
        },
      ),
    );
  }
}
