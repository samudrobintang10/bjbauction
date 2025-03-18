import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InputField extends StatefulWidget {
  final String label;
  final TextInputType keyboardType;
  final IconData icon;
  final bool isDatePicker;
  final bool isDropdown;
  final List<String>? dropdownItems;
  final Function(String)? onChanged;

  const InputField({
    Key? key,
    required this.label,
    required this.keyboardType,
    required this.icon,
    this.isDatePicker = false,
    this.isDropdown = false,
    this.dropdownItems,
    this.onChanged,
  }) : super(key: key);

  @override
  _InputFieldState createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  final TextEditingController _controller = TextEditingController();
  String? _selectedDropdownValue;

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
              decoration: InputDecoration(
                prefixIcon: Icon(widget.icon, color: Colors.blue.shade900),
                filled: true,
                hintText: "${widget.label}",
                hintStyle: TextStyle(height: 0),
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
              ),
            )
            : TextFormField(
              keyboardType: widget.keyboardType,
              controller: widget.isDatePicker ? _controller : null,
              readOnly: widget.isDatePicker,
              onTap: widget.isDatePicker ? () => _selectDate(context) : null,
              onChanged: widget.onChanged,
              decoration: InputDecoration(
                prefixIcon: Icon(widget.icon, color: Colors.blue.shade900),
                hintText: "${widget.label}",
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
              ),
            ),
      ],
    );
  }
}
