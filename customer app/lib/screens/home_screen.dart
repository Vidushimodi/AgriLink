import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../widgets/bottom_nav_bar.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Position? _currentPosition;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  void _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _currentPosition = position;
    });
  }

  final List<Map<String, dynamic>> products = [
    {
      "name": "Roma Tomatoes",
      "price": "₹50/kg",
      "image": "assets/tomato.jpg",
      "farmer": "Ramesh",
      "location": "Mysuru, Karnataka",
      "deliveryTime": "2 Days",
      "phone": "9876543210"
    },
    {
      "name": "Golden Potatoes",
      "price": "₹30/kg",
      "image": "assets/potato.jpg",
      "farmer": "Sunil",
      "location": "Pune, Maharashtra",
      "deliveryTime": "3 Days",
      "phone": "9876543211"
    },
    {
      "name": "Organic Wheat",
      "price": "₹40/kg",
      "image": "assets/wheat.jpg",
      "farmer": "Amit",
      "location": "Indore, Madhya Pradesh",
      "deliveryTime": "4 Days",
      "phone": "9876543212"
    },
    {
      "name": "Carrots",
      "price": "₹60/kg",
      "image": "assets/carrot.jpg",
      "farmer": "Lakshmi",
      "location": "Shimla, Himachal Pradesh",
      "deliveryTime": "2 Days",
      "phone": "9876543213"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.location_on, color: Colors.white, size: 22),
            SizedBox(width: 5),
            Text(
              _currentPosition == null
                  ? "Fetching location..."
                  : "Your Location: ${_currentPosition!.latitude}, ${_currentPosition!.longitude}",
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
        backgroundColor: Colors.green,
      ),
      bottomNavigationBar:
          CustomBottomNavBar(currentIndex: 0), // ✅ Nav Bar Added
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Welcome to AgriLink! 🌱",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 5),
            Text("Find fresh produce near you",
                style: TextStyle(fontSize: 16, color: Colors.grey[600])),
            SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.80,
                ),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return ProductCard(
                    name: products[index]["name"],
                    price: products[index]["price"],
                    imagePath: products[index]["image"],
                    farmer: products[index]["farmer"],
                    location: products[index]["location"],
                    deliveryTime: products[index]["deliveryTime"],
                    phone: products[index]["phone"], // ✅ Added Phone Number
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 🛒 Product Card Widget
class ProductCard extends StatelessWidget {
  final String name, price, imagePath, farmer, location, deliveryTime, phone;

  ProductCard({
    required this.name,
    required this.price,
    required this.imagePath,
    required this.farmer,
    required this.location,
    required this.deliveryTime,
    required this.phone,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/productDetails',
          arguments: {
            "name": name,
            "price": price,
            "image": imagePath,
            "farmer": farmer,
            "location": location,
            "deliveryTime": deliveryTime,
            "phone": phone, // ✅ Pass Phone Number to Details Page
          },
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 5,
        child: Column(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                child: Image.asset(imagePath,
                    fit: BoxFit.cover, width: double.infinity),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(name,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Text("Farmer: $farmer",
                      style: TextStyle(fontSize: 14, color: Colors.grey[600])),
                  Text("Grown in: $location",
                      style: TextStyle(fontSize: 14, color: Colors.grey[600])),
                  Text("Delivery: $deliveryTime",
                      style: TextStyle(fontSize: 14, color: Colors.green)),
                  SizedBox(height: 5),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
