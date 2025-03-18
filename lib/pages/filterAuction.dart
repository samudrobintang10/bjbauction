import 'package:bjbauction/widgets/button.dart';
import 'package:bjbauction/widgets/inputField.dart';
import 'package:flutter/material.dart';
import 'package:bjbauction/utils/color.dart';

class FilterAuction extends StatefulWidget {
  const FilterAuction({super.key});

  @override
  _FilterAuctionState createState() => _FilterAuctionState();
}

class _FilterAuctionState extends State<FilterAuction> {
  String? selectedCategory;
  String? selectedLocation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        title: Text(
          "Filter Aset",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: CustomColors.primary,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              InputField(
                label: "Kategori Aset",
                keyboardType: TextInputType.none,
                isDropdown: true,
                dropdownItems: ["Kendaraan", "Properti"],
                icon: Icons.category,
                onChanged: (value) {
                  setState(() {
                    selectedCategory = value;
                  });
                },
              ),
              SizedBox(height: 16),
              InputField(
                label: "Lokasi Aset",
                keyboardType: TextInputType.none,
                isDropdown: true,
                dropdownItems: ["Bandung", "Bekasi"],
                icon: Icons.location_city,
                onChanged: (value) {
                  setState(() {
                    selectedLocation = value;
                  });
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(16),
        color: Colors.white,
        child: Button(
          text: "Cari",
          onPressed: () {
            Navigator.pop(context, {
              "category": selectedCategory,
              "location": selectedLocation,
            });
          },
        ),
      ),
    );
  }
}
