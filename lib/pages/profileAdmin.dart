import 'package:bjbauction/pages/editprofile.dart';
import 'package:bjbauction/utils/color.dart';
import 'package:bjbauction/widgets/button.dart';
import 'package:flutter/material.dart';

class ProfileAdmin extends StatelessWidget {
  const ProfileAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 20,
        ), // Padding for screen space
        child: Column(
          children: [
            Container(
              // Adds space below this widget
              padding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ), // Internal padding
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 5,
                    spreadRadius: 2,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    height: 48,
                    width: 48,
                    padding: EdgeInsets.all(5),
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
                  SizedBox(width: 16),
                  Text(
                    "David Billy",
                    style: TextStyle(
                      color: CustomColors.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Button(
              text: "Keluar",
              onPressed: () {
                print("Keluar Pressed");
              },
            ),
          ],
        ),
      ),
    );
  }
}
