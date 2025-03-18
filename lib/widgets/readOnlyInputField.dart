import 'package:flutter/material.dart';

class ReadOnlyInputField extends StatelessWidget {
  final String label;
  final String value;

  const ReadOnlyInputField({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 5),
        TextField(
          readOnly: true, // Make it non-editable
          controller: TextEditingController(text: value),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
          style: TextStyle(fontSize: 16, color: Colors.black),
        ),
      ],
    );
  }
}
