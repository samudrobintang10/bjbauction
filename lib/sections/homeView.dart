import 'package:bjbauction/pages/detailAuction.dart';
import 'package:bjbauction/pages/otherAuction.dart';
import 'package:bjbauction/pages/scheduleAuction.dart';
import 'package:bjbauction/utils/color.dart';
import 'package:bjbauction/widgets/homeCard.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              Text(
                "Jadwal Lelang Terdekat",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: CustomColors.primary,
                  fontSize: 14,
                ),
              ),
              Spacer(), // Pushes "Lihat Semua" to the right
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ScheduleAuction()),
                  );
                },
                child: Text(
                  "Lihat Semua",
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    color: CustomColors.primary,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 8),
        SizedBox(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal, // Enable horizontal scrolling
            child: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Row(
                children: List.generate(5, (index) {
                  return Padding(
                    padding: EdgeInsets.only(
                      right: 16,
                    ), // Add spacing between cards
                    child: SizedBox(
                      width: 230, // Set the width of each card
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
                  );
                }),
              ),
            ),
          ),
        ),
        SizedBox(height: 32),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              Text(
                "Aset Lainnya",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: CustomColors.primary,
                  fontSize: 14,
                ),
              ),
              Spacer(), // Pushes "Lihat Semua" to the right
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => OtherAuction()),
                  );
                },
                child: Text(
                  "Lihat Semua",
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    color: CustomColors.primary,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 8),
        SizedBox(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal, // Enable horizontal scrolling
            child: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Row(
                children: List.generate(5, (index) {
                  return Padding(
                    padding: EdgeInsets.only(
                      right: 16,
                    ), // Add spacing between cards
                    child: SizedBox(
                      width: 230, // Set the width of each card
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
                  );
                }),
              ),
            ),
          ),
        ),
        SizedBox(height: 16),
      ],
    );
  }
}
