import 'package:bjbauction/utils/color.dart';
import 'package:flutter/material.dart';

class QuickMenu extends StatelessWidget {
  final String? icon;
  final String? text;

  const QuickMenu({super.key, this.icon, this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10), // Padding only top & bottom
      decoration: BoxDecoration(
        color: Colors.white, // Background color for the entire box
        borderRadius: BorderRadius.circular(15), // Rounded corners
      ),
      child: SizedBox(
        child: Column(
          mainAxisSize:
              MainAxisSize.min, // Makes column take only necessary space
          children: [
            Container(
              padding: EdgeInsets.all(10), // Padding inside the container
              decoration: BoxDecoration(
                color: CustomColors.secondary, // Background color
                borderRadius: BorderRadius.circular(10), // Rounded corners
              ),
              child: Image.asset(
                "assets/images/icons/$icon.png",
                width: 30,
                height: 30,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "$text",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
