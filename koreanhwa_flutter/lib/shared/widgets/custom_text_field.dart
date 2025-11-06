import 'package:flutter/material.dart';
import 'package:koreanhwa_flutter/shared/widgets/app_input.dart';

class CustomTextField extends StatelessWidget {
  final String? label;
  final String? hintText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? errorText;
  final void Function(String)? onChanged;

  const CustomTextField({
    super.key,
    this.label,
    this.hintText,
    this.controller,
    this.keyboardType,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
    this.errorText,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return AppInput(
      label: label,
      hintText: hintText,
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      prefix: prefixIcon,
      suffix: suffixIcon,
      errorText: errorText,
      onChanged: onChanged,
    );
  }
}


