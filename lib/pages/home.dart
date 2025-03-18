import 'package:bjbauction/sections/homeView.dart';
import 'package:bjbauction/utils/color.dart';
import 'package:bjbauction/widgets/QuickMenu.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        toolbarHeight: 80,
        title: Row(
          children: [
            Container(
              height: 48,
              width: 48,
              padding: EdgeInsets.all(5), // Padding inside the circle
              decoration: BoxDecoration(
                color: Colors.white, // Background color
                shape: BoxShape.circle, // Makes it a circle
              ),
              alignment: Alignment.center, // Ensures text is centered
              child: Text(
                "DB",
                style: TextStyle(
                  color: CustomColors.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
            SizedBox(width: 16),
            Text(
              "David Billy",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ],
        ),
        backgroundColor: CustomColors.primary,
      ),
      body: Container(
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
                  child: Text(
                    "Kategori Aset",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: CustomColors.primary,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: QuickMenu(
                          icon: "kendaraanIcon",
                          text: "Kendaraan",
                        ),
                      ),
                      SizedBox(width: 24),
                      Expanded(
                        child: QuickMenu(
                          icon: "propertiIcon",
                          text: "Properti",
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 32), // Add spacing
            HomeView(),
          ],
        ),
      ),
    );
  }
}
