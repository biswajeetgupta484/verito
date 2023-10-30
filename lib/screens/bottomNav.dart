import 'package:flutter/material.dart';
import 'package:verito/screens/cart.dart';
import 'package:verito/screens/dashboard.dart';
import 'package:verito/screens/logout.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavstate();
}

class _BottomNavstate extends State<BottomNav> {
  int myIndex = 0;

  List tab1 = [ ProductListFromApi(),  Cart(), const Logout()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: tab1[myIndex],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: BottomNavigationBar(
          backgroundColor: const Color.fromARGB(255, 232, 235, 238),
          elevation: 30,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: true,
          onTap: (index) {
            setState(() {
              myIndex = index;
            });
          },
          currentIndex: myIndex,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Dashboard",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.category),
              label: "Cart",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.power_settings_new),
              label: "Logout ",
            )
          ],
        ),
      ),
    );
  }
}
