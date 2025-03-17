import 'package:flutter/material.dart';
import 'package:bjbauction/pages/surveyformscreen2.dart';

class SurveyFormScreen1 extends StatelessWidget {
  const SurveyFormScreen1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              // Use Expanded to ensure content takes proper space
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/welcome.png',
                      height: 250,
                      // Jika gambar tidak tersedia, ganti dengan placeholder
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 250,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Icon(Icons.people, size: 100, color: Colors.grey),
                        );
                      },
                    ),
                    SizedBox(height: 40),
                    Text(
                      'Selamat Datang di BJB Auction',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              
              // Button with fixed position at bottom
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(bottom: 20),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SurveyFormScreen2()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF1A5B8F),
                    padding: EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Lanjutkan',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.white, // Ensure text color is visible
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}