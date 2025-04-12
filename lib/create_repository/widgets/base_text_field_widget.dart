import 'package:flutter/material.dart';

class BaseTextFieldWidget extends StatelessWidget {
  final String description;
  final String hintText;
  final TextEditingController controller;
  final Widget? suffixIcon;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;

  const BaseTextFieldWidget({
    required this.description,
    required this.hintText,
    required this.controller,
    this.suffixIcon,
    this.onChanged,
    this.validator,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(description),
        SizedBox(
          width: 300,
          // height: 35,
          child: TextFormField(
            controller: controller,
            onChanged: onChanged,
            validator: validator,
            decoration: InputDecoration(
              suffixIcon: suffixIcon,
              hintText: hintText,
              fillColor: Colors.transparent,
              hoverColor: Colors.transparent,
            ),
          ),
        ),
      ],
    );
  }
}
