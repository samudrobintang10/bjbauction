import 'package:bjbauction/pages/detailAuction.dart';
import 'package:bjbauction/widgets/homeCard.dart';
import 'package:flutter/material.dart';
import 'package:bjbauction/utils/color.dart';

class OtherAuction extends StatelessWidget {
  const OtherAuction({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        toolbarHeight: 80,
        title: Row(
          children: [
            Text(
              "Aset Lainnya",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ],
        ),
        backgroundColor: CustomColors.primary,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            children: List.generate(
              5,
              (index) => Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => DetailAuction(
                              // title: "Tanah Pekarangan ${index + 1}",
                              // price: "Rp. ${230 + index * 10}.000.000",
                              // location: "Kabupaten Bandung",
                              // imageUrl: "tes",
                            ),
                      ),
                    );
                  },
                  child: HomeCard(
                    imageUrl: "tes",
                    category: "Kendaraan",
                    title: "Tanah Pekarangan ${index + 1}",
                    price: "Rp. ${230 + index * 10}.000.000",
                    location: "Kabupaten Bandung",
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
