import 'dart:async';

import 'package:bjbauction/main.dart';
import 'package:bjbauction/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:bjbauction/pages/signupscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus(); // Check if user is already logged in
  }

  Future<void> _checkLoginStatus() async {
    await Future.delayed(const Duration(seconds: 2)); // Simulate splash delay

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token != null && !JwtDecoder.isExpired(token)) {
      String role = prefs.getString('role') ?? 'user';
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MainScreen(isAdmin: role == "admin"),
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => WalkthroughScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'BJB\n',
                style: TextStyle(
                  color: CustomColors.primary,
                  fontSize: 72,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text: 'Auction',
                style: TextStyle(
                  color: Color(0xFFFFCB05),
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class WalkthroughScreen extends StatefulWidget {
  @override
  _WalkthroughScreenState createState() => _WalkthroughScreenState();
}

class _WalkthroughScreenState extends State<WalkthroughScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // Timer untuk auto-sliding
  Timer? _timer;

  final List<WalkthroughContent> _contents = [
    WalkthroughContent(
      title: 'Detail Informasi Aset',
      description:
          'Temukan berbagai macam informasi pelelangan aset secara lengkap dan terpercaya',
      image: 'assets/images/walkthrough1.png',
    ),
    WalkthroughContent(
      title: 'Favorit List Aset',
      description:
          'Kumpulkan berbagai jenis informasi aset lelang yang dapat kamu ikuti',
      image: 'assets/images/walkthrough2.png',
    ),
    WalkthroughContent(
      title: 'Lokasi Aset Terjangkau',
      description:
          'Jaringan lokasi yang tersebar hingga lebih dari 30 kota di Jawa Barat',
      image: 'assets/images/walkthrough3.png',
    ),
  ];

  @override
  void initState() {
    super.initState();
    // Jalankan auto-slider
    _startAutoSlider();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer?.cancel(); // Hentikan timer saat widget dihapus
    super.dispose();
  }

  // Method untuk memulai auto-slider
  void _startAutoSlider() {
    _timer = Timer.periodic(Duration(seconds: 20), (timer) {
      if (_currentPage < _contents.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  void _goToNextPage() {
    if (_currentPage < _contents.length - 1) {
      _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // Navigate to SignUpScreen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SignUpScreen()),
      );
    }
  }

  // Method untuk navigasi ke halaman tertentu ketika dot indicator diklik
  void _goToPage(int pageIndex) {
    _pageController.animateToPage(
      pageIndex,
      duration: Duration(milliseconds: 10000),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // App Bar
            _buildAppBar(),

            // Walkthrough content (bergerak saat diswipe)
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _contents.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  return _buildPageContent(index);
                },
              ),
            ),

            // Bottom section (tetap statis)
            _buildStaticBottomSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // App Logo
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'BJB ',
                  style: TextStyle(
                    color: CustomColors.primary,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: 'Auction',
                  style: TextStyle(
                    color: Color(0xFFFFCB05),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          // Skip button
          TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => SignUpScreen()),
              );
            },
            child: Text(
              'Lewati',
              style: TextStyle(color: CustomColors.primary),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPageContent(int index) {
    return Padding(
      padding: EdgeInsets.all(40.0),
      child: Column(
        children: [
          // Image
          Expanded(
            child: Image.asset(
              _contents[index].image,
              // Jika gambar tidak tersedia, ganti dengan placeholder
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 250,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Icon(Icons.image, size: 100, color: Colors.grey),
                );
              },
            ),
          ),

          SizedBox(height: 30),

          // Title
          Text(
            _contents[index].title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: CustomColors.primary,
            ),
          ),

          SizedBox(height: 15),

          // Description
          Text(
            _contents[index].description,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  Widget _buildStaticBottomSection() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 30),
      child: Column(
        children: [
          // Dots indicator sesuai dengan gambar di images.png
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              _contents.length,
              (i) => GestureDetector(
                onTap: () => _goToPage(i),
                child: Container(
                  width:
                      i == _currentPage
                          ? 24
                          : 8, // Lebih panjang untuk yang aktif
                  height: 8,
                  margin: EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color:
                        i == _currentPage
                            ? Color(
                              0xFF1A5B8F,
                            ) // Warna biru tua untuk yang aktif
                            : Color(
                              0xFFBBDEF8,
                            ), // Warna biru muda untuk yang tidak aktif
                  ),
                ),
              ),
            ),
          ),

          SizedBox(height: 30),

          // Button (tetap statis)
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _goToNextPage,
              style: ElevatedButton.styleFrom(
                backgroundColor: CustomColors.primary,
                padding: EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Selanjutnya',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class WalkthroughContent {
  final String title;
  final String description;
  final String image;

  WalkthroughContent({
    required this.title,
    required this.description,
    required this.image,
  });
}
