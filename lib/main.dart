import 'package:bjbauction/pages/auction.dart';
import 'package:bjbauction/pages/home.dart';
import 'package:bjbauction/pages/profile.dart';
import 'package:bjbauction/pages/wishlist.dart';
import 'package:bjbauction/pages/splashscreen.dart';
import 'package:bjbauction/utils/color.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(BJBAuctionApp());
}

class BJBAuctionApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BJB Auction',
      theme: ThemeData(
        fontFamily: "PlusJakartaSans",
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Color(0xFF1A5B8F),
          secondary: Color(0xFFFFCB05),
        ),
      ),
      home: SplashScreen(), // Show SplashScreen first
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  // List of pages to navigate
  final List<Widget> _pages = [Home(), Auction(), Wishlist(), Profile()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: _pages),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        selectedItemColor: CustomColors.primary, // Ensure CustomColors is defined
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.category), label: "Aset"),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Favorite"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Akun"),
        ],
        onTap: _onItemTapped, // Call the function to update index
      ),
    );
  }
}
