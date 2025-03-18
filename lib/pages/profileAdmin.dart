import 'package:bjbauction/pages/loginScreen.dart';
import 'package:bjbauction/utils/color.dart';
import 'package:bjbauction/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ProfileAdmin extends StatefulWidget {
  const ProfileAdmin({super.key});

  @override
  State<ProfileAdmin> createState() => _ProfileAdminState();
}

class _ProfileAdminState extends State<ProfileAdmin> {
  String _albumTitle = "Loading...";
  bool _isLoading = false;

  Future<void> fetchAlbum() async {
    setState(() {
      _isLoading = true;
    });

    final url = Uri.parse('https://jsonplaceholder.typicode.com/albums/1');
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token'); // Retrieve token

      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token', // Send token for authentication
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _albumTitle = data['title'];
        });
      } else {
        setState(() {
          _albumTitle = "Failed to load data";
        });
      }
    } catch (e) {
      setState(() {
        _albumTitle = "Error fetching data";
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchAlbum(); // Fetch data when the page loads
  }

  // Fungsi logout
  Future<void> _logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // Hapus semua data yang tersimpan
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
      (route) => false, // Menghapus semua history navigation
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        title: Row(
          children: [
            const Text(
              "BJB",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const SizedBox(width: 4),
            Text(
              "Auction",
              style: TextStyle(
                color: CustomColors.tertiary,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ],
        ),
        backgroundColor: CustomColors.primary,
      ),
      body: RefreshIndicator(
        onRefresh: fetchAlbum, // Refresh trigger
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(), // Allow scrolling
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 5,
                      spreadRadius: 2,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      height: 48,
                      width: 48,
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: CustomColors.secondary,
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "DB",
                        style: TextStyle(
                          color: CustomColors.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "David Billy",
                          style: TextStyle(
                            color: CustomColors.primary,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        _isLoading
                            ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.blue,
                              ),
                            )
                            : Text(
                              _albumTitle, // Display fetched album title
                              style: const TextStyle(
                                color: Colors.black54,
                                fontSize: 16,
                              ),
                            ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Button(text: "Keluar", onPressed: () => _logout(context)),
            ],
          ),
        ),
      ),
    );
  }
}
