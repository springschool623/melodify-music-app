// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:melodify_app_project/stuff/color.dart';
import 'package:melodify_app_project/stuff/same_using.dart';

class CustomTextField extends StatefulWidget {
  final String text;
  final String icon;
  final TextEditingController controller; // Thêm controller

  const CustomTextField({
    super.key, 
    required this.text, 
    required this.icon,
    required this.controller, // Nhận controller
  });

  @override
  State<CustomTextField> createState() => CustomTextFieldState();
}

class CustomTextFieldState extends State<CustomTextField> {
  final FocusNode _focusNode = FocusNode();

  // Map để ánh xạ tên icon với các icon từ Icons
  static const Map<String, IconData> _iconMap = {
    'email': Icons.email_outlined,
    'lock': Icons.lock_outline,
    'user': Icons.person_outline,
    'birthday': Icons.cake_outlined,
    // Thêm các ánh xạ khác nếu cần
  };

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (selected != null) {
      setState(() {
        widget.controller.text = "${selected.toLocal()}".split(' ')[0]; // Format date as you like
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      focusNode: _focusNode,
      onFocusChange: (hasFocus) {
        setState(() {}); // Trigger a rebuild when focus changes
      },
      child: TextFormField(
        controller: widget.controller,
        style: changeTextColor(robotoMedium18, whiteColor),
        decoration: InputDecoration(
          labelText: widget.text,
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 10),
            child: Icon(
              _iconMap[widget.icon] ?? Icons.help_outline, // Sử dụng icon ánh xạ hoặc icon mặc định nếu không tìm thấy
              size: 30,
              color: _focusNode.hasFocus ? blueColor : lightGrey,
            ),
          ),
          suffixIcon: widget.icon == 'birthday'
              ? Padding(
                padding: const EdgeInsets.only(right: 10, left: 10),
                child: IconButton(
                    icon: Icon(
                      Icons.calendar_today,
                      color: _focusNode.hasFocus ? blueColor : lightGrey,
                    ),
                    onPressed: () {
                      _selectDate(context);
                    },
                  ),
              )
              : null,
          labelStyle: changeTextColor(robotoMedium18, lightGrey),
          floatingLabelAlignment: FloatingLabelAlignment.start,
          contentPadding: EdgeInsets.symmetric(
              vertical: 15.0, horizontal: 25.0),
          floatingLabelStyle: changeTextColor(robotoMedium18, blueColor),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
                color: lightGrey, width: 1.5, style: BorderStyle.solid),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: blueColor,
              width: 2.0,
              style: BorderStyle.solid,
            ),
          ),
        ),
      ),
    );
  }
}
