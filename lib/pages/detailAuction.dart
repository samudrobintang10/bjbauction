import 'package:bjbauction/widgets/button.dart';
import 'package:bjbauction/widgets/readOnlyInputField.dart';
import 'package:flutter/material.dart';
import 'package:bjbauction/utils/color.dart';

class DetailAuction extends StatefulWidget {
  const DetailAuction({super.key});

  @override
  _DetailAuctionState createState() => _DetailAuctionState();
}

class _DetailAuctionState extends State<DetailAuction>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool isFavorite = false; // Track love button state

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {}); // Rebuild UI when tab changes
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        toolbarHeight: 80,
        title: Text(
          "Detail Informasi Aset",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: CustomColors.primary,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          // Image with Floating Love Button
          Stack(
            children: [
              Image.asset(
                "assets/images/exampleCard.png",
                width: double.infinity,
                height: 210,
                fit: BoxFit.cover,
              ),
              Positioned(
                bottom: 16,
                right: 16,
                child: FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      isFavorite = !isFavorite;
                    });
                  },
                  backgroundColor: Colors.white,
                  shape: CircleBorder(),
                  child: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? Colors.red : Colors.grey,
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Column(
              children: [
                Container(
                  color: Colors.white,
                  child: TabBar(
                    controller: _tabController,
                    labelColor: CustomColors.primary,
                    unselectedLabelColor: Colors.black,
                    indicatorColor: CustomColors.primary,
                    tabs: [Tab(text: "Detail"), Tab(text: "Jadwal")],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      // Detail Tab
                      SingleChildScrollView(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            ReadOnlyInputField(
                              label: "Nama Aset",
                              value: "Tanah Pekarangan",
                            ),
                            SizedBox(height: 80), // Space for button
                          ],
                        ),
                      ),
                      // Jadwal Tab
                      SingleChildScrollView(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            ReadOnlyInputField(
                              label: "Nama Aset",
                              value: "Tanah Pekarangan",
                            ),
                            SizedBox(height: 80), // Space for button
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(16),
        color: Colors.white,
        child: Button(
          text:
              _tabController.index == 0 ? "Daftar Lelang" : "Lihat Google Map",
          onPressed: () {
            if (_tabController.index == 0) {
              print("Daftar Lelang Pressed");
            } else {
              print("Lihat Google Map Pressed");
            }
          },
        ),
      ),
    );
  }
}
