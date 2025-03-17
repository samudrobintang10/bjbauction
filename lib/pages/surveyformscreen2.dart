import 'package:flutter/material.dart';

class SurveyFormScreen2 extends StatefulWidget {
  @override
  _SurveyFormScreen2State createState() => _SurveyFormScreen2State();
}

class _SurveyFormScreen2State extends State<SurveyFormScreen2> {
  final _nikController = TextEditingController();
  final _namaController = TextEditingController();
  final _tanggalLahirController = TextEditingController();
  final _alamatController = TextEditingController();
  final _teleponController = TextEditingController();
  String? _selectedJenisKelamin;
  String? _selectedLokasi;

  List<String> jenisKelaminList = ['Laki-Laki', 'Perempuan'];
  List<String> lokasiList = ['Kota Bandung', 'Jakarta', 'Surabaya', 'Yogyakarta'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Data Diri',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A5B8F),
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Isilah data diri dibawah ini dengan benar dan lengkap.',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 20),
              
              // NIK Field
              _buildLabelText('NIK'),
              _buildTextField(_nikController, 'Masukkan NIK', TextInputType.number),
              SizedBox(height: 16),
              
              // Nama Lengkap Field
              _buildLabelText('Nama Lengkap'),
              _buildTextField(_namaController, 'Masukkan nama lengkap'),
              SizedBox(height: 16),
              
              // Tanggal Lahir Field
              _buildLabelText('Tanggal Lahir'),
              GestureDetector(
                onTap: () => _selectDate(context),
                child: AbsorbPointer(
                  child: _buildTextField(_tanggalLahirController, 'DD/MM/YYYY', TextInputType.text, Icons.calendar_today),
                ),
              ),
              SizedBox(height: 16),
              
              // Jenis Kelamin Field
              _buildLabelText('Jenis Kelamin'),
              _buildDropdown(
                value: _selectedJenisKelamin,
                hint: 'Pilih jenis kelamin',
                items: jenisKelaminList,
                onChanged: (value) {
                  setState(() {
                    _selectedJenisKelamin = value;
                  });
                },
              ),
              SizedBox(height: 16),
              
              // Lokasi Field
              _buildLabelText('Lokasi'),
              _buildDropdown(
                value: _selectedLokasi,
                hint: 'Pilih lokasi',
                items: lokasiList,
                onChanged: (value) {
                  setState(() {
                    _selectedLokasi = value;
                  });
                },
              ),
              SizedBox(height: 16),
              
              // Nomor Telepon Field
              _buildLabelText('Nomor Telepon'),
              _buildTextField(_teleponController, 'Masukkan nomor telepon', TextInputType.phone),
              SizedBox(height: 40),
              
              // Submit Button
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _submitData,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF1A5B8F),
                    padding: EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Simpan',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.white
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabelText(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller, 
    String hintText, 
    [TextInputType? keyboardType, 
    IconData? suffixIcon]
  ) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Color(0xFF1A5B8F)),
        ),
        suffixIcon: suffixIcon != null ? Icon(suffixIcon, color: Colors.grey) : null,
      ),
    );
  }

  Widget _buildDropdown({
    required String? value,
    required String hint,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          hint: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(hint),
          ),
          icon: Icon(Icons.arrow_drop_down),
          iconSize: 24,
          elevation: 16,
          style: TextStyle(color: Colors.black87),
          onChanged: onChanged,
          items: items.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(value),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Color(0xFF1A5B8F),
            colorScheme: ColorScheme.light(primary: Color(0xFF1A5B8F)),
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _tanggalLahirController.text = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  void _submitData() {
    // Add validation logic
    if (_nikController.text.isEmpty ||
        _namaController.text.isEmpty ||
        _tanggalLahirController.text.isEmpty ||
        _selectedJenisKelamin == null ||
        _selectedLokasi == null ||
        _teleponController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Semua field harus diisi'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Navigate to next screen or show success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Data berhasil disimpan'),
        backgroundColor: Color(0xFF1A5B8F),
      ),
    );
    
    // Untuk demo, kembali ke login screen setelah submit
    Navigator.of(context).popUntil((route) => route.isFirst);
  }
}