import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class InputField extends StatefulWidget {
  final String label;
  final TextInputType keyboardType;
  final IconData icon;
  final bool isDatePicker;
  final bool isDropdown;
  final bool isImagePicker;
  final List<String>? dropdownItems;
  final Function(String)? onChanged;
  final Function(File?)? onImagePicked;

  const InputField({
    Key? key,
    required this.label,
    required this.keyboardType,
    required this.icon,
    this.isDatePicker = false,
    this.isDropdown = false,
    this.isImagePicker = false,
    this.dropdownItems,
    this.onChanged,
    this.onImagePicked,
  }) : super(key: key);

  @override
  _InputFieldState createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  final TextEditingController _controller = TextEditingController();
  String? _selectedDropdownValue;
  File? _selectedImage;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      setState(() {
        _controller.text = formattedDate;
      });
      if (widget.onChanged != null) {
        widget.onChanged!(formattedDate);
      }
    }
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
      });
      if (widget.onImagePicked != null) {
        widget.onImagePicked!(_selectedImage);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 6),
        widget.isDropdown
            ? DropdownButtonFormField<String>(
              value: _selectedDropdownValue,
              items:
                  widget.dropdownItems?.map((String item) {
                    return DropdownMenuItem(value: item, child: Text(item));
                  }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedDropdownValue = value;
                });
                if (widget.onChanged != null) {
                  widget.onChanged!(value!);
                }
              },
              decoration: _inputDecoration(),
            )
            : widget.isImagePicker
            ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue.shade200),
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                    ),
                    child:
                        _selectedImage == null
                            ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.image,
                                    color: Colors.blue.shade900,
                                    size: 50,
                                  ),
                                  Text("Upload Gambar"),
                                ],
                              ),
                            )
                            : ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.file(
                                _selectedImage!,
                                width: double.infinity,
                                height: 200,
                                fit: BoxFit.cover,
                              ),
                            ),
                  ),
                ),
              ],
            )
            : TextFormField(
              keyboardType: widget.keyboardType,
              controller: widget.isDatePicker ? _controller : null,
              readOnly: widget.isDatePicker,
              onTap: widget.isDatePicker ? () => _selectDate(context) : null,
              onChanged: widget.onChanged,
              decoration: _inputDecoration(),
            ),
      ],
    );
  }

  InputDecoration _inputDecoration() {
    return InputDecoration(
      prefixIcon: Icon(widget.icon, color: Colors.blue.shade900),
      hintText: widget.label,
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.blue.shade200),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.blue.shade200),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.blue, width: 2),
      ),
    );
  }
}
