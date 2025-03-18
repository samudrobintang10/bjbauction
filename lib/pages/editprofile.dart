import 'package:bjbauction/widgets/button.dart';
import 'package:bjbauction/widgets/inputField.dart';
import 'package:flutter/material.dart';
import 'package:bjbauction/utils/color.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        title: Row(
          children: [
            Text(
              "Edit Informasi Akun",
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
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              InputField(
                label: "Email",
                keyboardType: TextInputType.emailAddress,
                icon: Icons.email,
              ),
              SizedBox(height: 16),
              InputField(
                label: "Nomor Induk Kependudukan (NIK)",
                keyboardType: TextInputType.number,
                icon: Icons.list,
              ),
              SizedBox(height: 16),
              InputField(
                label: "Nama Lengkap",
                keyboardType: TextInputType.text,
                icon: Icons.person,
              ),
              SizedBox(height: 16),
              InputField(
                label: "Tanggal Lahir",
                keyboardType: TextInputType.datetime,
                isDatePicker: true,
                icon: Icons.calendar_month,
              ),
              SizedBox(height: 16),
              InputField(
                label: "Jenis Kelamin",
                keyboardType: TextInputType.none,
                isDropdown: true,
                dropdownItems: ["Laki-Laki", "Perempuan"],
                icon: Icons.person_outline,
                onChanged: (value) {
                  print("Selected: $value");
                },
              ),
              SizedBox(height: 16),
              InputField(
                label: "Lokasi",
                keyboardType: TextInputType.text,
                icon: Icons.location_city,
              ),
              SizedBox(height: 16),
              InputField(
                label: "Nomor Telepon",
                keyboardType: TextInputType.phone,
                icon: Icons.phone,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(16),
        color: Colors.white,
        child: Button(
          text: "Simpan",
          onPressed: () {
            print("Simpan Pressed");
          },
        ),
      ),
    );
  }
}
