import 'package:flutter/material.dart';
import 'package:bjbauction/pages/splashscreen.dart';

void main() {
  runApp(BJBAuctionApp());
}

class BJBAuctionApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFF1A5B8F),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Color(0xFF1A5B8F),
          secondary: Color(0xFFFFCB05),
        ),
      ),
      home: SplashScreen(),
    );
  }
}
