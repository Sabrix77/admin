import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  TextEditingController controller;
  String? Function(String?) validator;
  void Function(String)? onChange;
  String? label;
  String? hint;
  Widget? prefixIcon;
  Widget? suffixIcon;
  int? maxLines;
  TextInputType? textInputType;
  bool obscureText;

  Color? borderColor;

  CustomTextField({
    required this.controller,
    this.label,
    this.hint,
    required this.validator,
    this.maxLines,
    this.prefixIcon,
    this.suffixIcon,
    this.textInputType,
    this.borderColor,
    this.obscureText = false,
    this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      maxLines: maxLines ?? 1,
      obscureText: obscureText,
      keyboardType: textInputType ?? TextInputType.text,
      onChanged: onChange,
      decoration: InputDecoration(
        label: label == null ? null : Text(label!),
        hintText: hint,
        alignLabelWithHint: true,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: borderColor ?? Colors.grey,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: borderColor ?? Colors.blueGrey,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: Colors.red),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}
