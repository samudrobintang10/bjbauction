import 'package:bjbauction/pages/homeAdmin.dart';
import 'package:bjbauction/pages/profileAdmin.dart';
import 'package:flutter/material.dart';
import 'package:bjbauction/pages/auction.dart';
import 'package:bjbauction/pages/home.dart';
import 'package:bjbauction/pages/profile.dart';
import 'package:bjbauction/pages/wishlist.dart';
import 'package:bjbauction/pages/splashscreen.dart';
import 'package:bjbauction/utils/color.dart';

void main() => runApp(const BJBAuctionApp());

class BJBAuctionApp extends StatelessWidget {
  const BJBAuctionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BJB Auction',
      theme: ThemeData(
        fontFamily: "PlusJakartaSans",
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color(0xFF1A5B8F),
          secondary: const Color(0xFFFFCB05),
        ),
      ),
      home: SplashScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  final bool isAdmin;

  const MainScreen({super.key, required this.isAdmin});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages =
        widget.isAdmin
            ? [const HomeAdmin(), const ProfileAdmin()]
            : [
              const Home(),
              const Auction(),
              const Wishlist(),
              const Profile(),
            ];
  }

  void _onItemTapped(int index) => setState(() => _selectedIndex = index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: _pages),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        selectedItemColor: CustomColors.primary,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        onTap: _onItemTapped,
        items:
            widget.isAdmin
                ? const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: "Home",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person),
                    label: "Akun",
                  ),
                ]
                : const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: "Home",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.category),
                    label: "Aset",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.favorite),
                    label: "Favorite",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person),
                    label: "Akun",
                  ),
                ],
      ),
    );
  }
}
