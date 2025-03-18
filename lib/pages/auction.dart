import 'package:bjbauction/pages/detailAuction.dart';
import 'package:bjbauction/pages/filterAuction.dart';
import 'package:bjbauction/utils/color.dart';
import 'package:bjbauction/widgets/homeCard.dart';
import 'package:flutter/material.dart';

class Auction extends StatefulWidget {
  final String? initialCategory;

  const Auction({super.key, this.initialCategory});

  @override
  _AuctionState createState() => _AuctionState();
}

class _AuctionState extends State<Auction> {
  bool isFiltered = false;
  String appBarTitle = "Aset Lelang";
  String? selectedCategory;
  String? selectedLocation;

  List<Map<String, String>> allAssets = [
    {
      "category": "Kendaraan",
      "title": "Mobil Sedan",
      "price": "Rp. 200.000.000",
      "location": "Bandung",
    },
    {
      "category": "Properti",
      "title": "Tanah Pekarangan",
      "price": "Rp. 500.000.000",
      "location": "Bekasi",
    },
    {
      "category": "Kendaraan",
      "title": "Motor Sport",
      "price": "Rp. 50.000.000",
      "location": "Bandung",
    },
    {
      "category": "Properti",
      "title": "Rumah Subsidi",
      "price": "Rp. 300.000.000",
      "location": "Bekasi",
    },
  ];

  List<Map<String, String>> filteredAssets = [];

  @override
  void initState() {
    super.initState();
    if (widget.initialCategory != null) {
      applyFilter(widget.initialCategory, null);
    }
  }

  void applyFilter(String? category, String? location) {
    setState(() {
      selectedCategory = category;
      selectedLocation = location;
      isFiltered = true;
      appBarTitle = "Hasil Pencarian";

      filteredAssets =
          allAssets.where((asset) {
            bool matchesCategory =
                category == null || asset["category"] == category;
            bool matchesLocation =
                location == null || asset["location"] == location;
            return matchesCategory && matchesLocation;
          }).toList();
    });
  }

  void resetFilter() {
    setState(() {
      isFiltered = false;
      appBarTitle = "Aset Lelang";
      selectedCategory = null;
      selectedLocation = null;
      filteredAssets.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> displayAssets =
        isFiltered ? filteredAssets : allAssets;

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        toolbarHeight: 80,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              appBarTitle,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            IconButton(
              icon: Icon(
                isFiltered ? Icons.filter_list_off : Icons.filter_list,
                color: Colors.white,
                size: 28,
              ),
              onPressed: () {
                if (isFiltered) {
                  resetFilter();
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FilterAuction()),
                  ).then((result) {
                    if (result != null) {
                      applyFilter(result["category"], result["location"]);
                    }
                  });
                }
              },
            ),
          ],
        ),
        backgroundColor: CustomColors.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child:
            displayAssets.isEmpty
                ? Center(
                  child: Text(
                    "Tidak ada hasil",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                )
                : SingleChildScrollView(
                  child: Column(
                    children: List.generate(
                      displayAssets.length,
                      (index) => Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailAuction(),
                              ),
                            );
                          },
                          child: HomeCard(
                            imageUrl: "tes",
                            category: displayAssets[index]["category"]!,
                            title: displayAssets[index]["title"]!,
                            price: displayAssets[index]["price"]!,
                            location: displayAssets[index]["location"]!,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
      ),
    );
  }
}
