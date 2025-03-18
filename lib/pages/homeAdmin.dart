import 'dart:convert';
import 'package:bjbauction/pages/addAsset.dart';
import 'package:bjbauction/pages/updateAsset.dart';
import 'package:bjbauction/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class HomeAdmin extends StatefulWidget {
  const HomeAdmin({super.key});

  @override
  State<HomeAdmin> createState() => _HomeAdminState();
}

class _HomeAdminState extends State<HomeAdmin> {
  bool _isLoading = false;
  List<dynamic> _assets = [];

  Future<void> fetchData() async {
    setState(() {
      _isLoading = true;
    });

    final url = Uri.parse('http://10.100.3.240:8000/assets');
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      final response = await http.get(
        url,
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _assets = data['data'];
        });
      } else {
        setState(() {
          _assets = [];
        });
      }
    } catch (e) {
      setState(() {
        _assets = [];
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
    fetchData(); // Fetch data when the page loads
  }

  String capitalize(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1).toLowerCase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        toolbarHeight: 80,
        title: Row(
          children: [
            Text(
              "BJB",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            SizedBox(width: 4),
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
        onRefresh: fetchData,
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Container(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Table (Sticky)
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text("Nama Aset", style: _headerStyle()),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text("Kategori Aset", style: _headerStyle()),
                      ),
                      Expanded(
                        flex: 3,
                        child: Text(
                          "Aksi",
                          style: _headerStyle(),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(color: CustomColors.primary, thickness: 1),

                // Scrollable Table Body
                Expanded(
                  child:
                      _isLoading
                          ? Center(child: CircularProgressIndicator())
                          : _assets.isEmpty
                          ? Center(child: Text("Tidak ada data aset"))
                          : ListView.builder(
                            itemCount: _assets.length,
                            itemBuilder: (context, index) {
                              final asset = _assets[index];
                              return _buildTableRow(
                                asset['name'],
                                capitalize(asset['category'].toString()),
                              );
                            },
                          ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddAsset()),
          );
        },
        backgroundColor: CustomColors.primary,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  // Style untuk header tabel
  TextStyle _headerStyle() {
    return TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 14,
      color: Colors.black,
    );
  }

  // Membangun baris tabel
  Widget _buildTableRow(String name, String category) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: CustomColors.primary, width: 0.8),
        ),
      ),
      child: Row(
        children: [
          Expanded(flex: 2, child: Text(name, style: TextStyle(fontSize: 12))),
          Expanded(
            flex: 2,
            child: Text(category, style: TextStyle(fontSize: 12)),
          ),
          Expanded(
            flex: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => UpdateAsset()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: CustomColors.primary,
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  child: Text(
                    "Ubah",
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
                SizedBox(width: 4),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  child: Text(
                    "Hapus",
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
