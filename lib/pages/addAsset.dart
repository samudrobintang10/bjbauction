import 'package:bjbauction/widgets/button.dart';
import 'package:bjbauction/widgets/inputField.dart';
import 'package:flutter/material.dart';
import 'package:bjbauction/utils/color.dart';
import 'dart:io';

class AddAsset extends StatelessWidget {
  const AddAsset({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        title: const Text(
          "Tambah Aset",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: CustomColors.primary,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 16),
              InputField(
                label: "Nama Aset",
                keyboardType: TextInputType.text,
                icon: Icons.person,
              ),
              const SizedBox(height: 16),
              InputField(
                label: "Gambar Aset",
                keyboardType: TextInputType.text,
                icon: Icons.upload_file,
                isImagePicker: true,
                onImagePicked: (File? image) {
                  if (image != null) {
                    print("Image path: ${image.path}");
                  }
                },
              ),
              const SizedBox(height: 16),
              InputField(
                label: "Kategori Aset",
                keyboardType: TextInputType.none,
                isDropdown: true,
                dropdownItems: [
                  "Properti",
                  "Kendaraan",
                  "Elektronik",
                  "Lainnya",
                ],
                icon: Icons.category,
                onChanged: (value) {
                  print("Selected: $value");
                },
              ),
              const SizedBox(height: 16),
              InputField(
                label: "Deskripsi Aset",
                keyboardType: TextInputType.text,
                icon: Icons.description,
              ),
              const SizedBox(height: 16),
              InputField(
                label: "Harga Aset",
                keyboardType: TextInputType.number,
                icon: Icons.price_change,
              ),
              const SizedBox(height: 16),
              InputField(
                label: "Alamat Aset",
                keyboardType: TextInputType.text,
                icon: Icons.location_on,
              ),
              const SizedBox(height: 16),
              InputField(
                label: "Tanggal Mulai Lelang",
                keyboardType: TextInputType.datetime,
                isDatePicker: true,
                icon: Icons.calendar_month,
              ),
              const SizedBox(height: 16),
              InputField(
                label: "Tanggal Berakhir Lelang",
                keyboardType: TextInputType.datetime,
                isDatePicker: true,
                icon: Icons.calendar_month,
              ),
              const SizedBox(height: 16),
              InputField(
                label: "Lokasi",
                keyboardType: TextInputType.text,
                icon: Icons.location_city,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
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
