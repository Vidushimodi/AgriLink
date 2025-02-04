import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/cart_model.dart';
import '../widgets/bottom_nav_bar.dart'; // Import the navigation bar

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cartItems = Provider.of<CartModel>(context).cartItems;

    return Scaffold(
      appBar: AppBar(title: Text("Shopping Cart")),
      bottomNavigationBar: CustomBottomNavBar(currentIndex: 1), // Fixed NavBar
      body: cartItems.isEmpty
          ? Center(
              child: Text("Your cart is empty",
                  style: TextStyle(fontSize: 18, color: Colors.grey)))
          : Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: cartItems.length,
                      itemBuilder: (context, index) {
                        final product = cartItems[index];
                        return Card(
                          elevation: 3,
                          margin: EdgeInsets.symmetric(vertical: 10),
                          child: ListTile(
                            leading: Image.asset(product["image"]!,
                                width: 50, height: 50, fit: BoxFit.cover),
                            title: Text(product["name"]!,
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                            subtitle: Text(
                                "Farmer: ${product["farmer"]}\n${product["price"]}"),
                            trailing: IconButton(
                              icon:
                                  Icon(Icons.remove_circle, color: Colors.red),
                              onPressed: () {
                                Provider.of<CartModel>(context, listen: false)
                                    .removeItem(product);
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Divider(thickness: 1, color: Colors.grey),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Total: ₹${cartItems.length * 50}",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.green)),
                      ElevatedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Proceeding to Checkout')));
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            padding: EdgeInsets.symmetric(
                                horizontal: 30, vertical: 15)),
                        child: Text("Checkout", style: TextStyle(fontSize: 18)),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
    );
  }
}
