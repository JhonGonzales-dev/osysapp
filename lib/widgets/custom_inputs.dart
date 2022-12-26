import 'package:flutter/material.dart';

class CustomInputs {
  static InputDecoration loginInputDecoration(
      {String? hint,
      IconData? icon,
      bool isPrefixIcon = true,
      Widget? suffixIcons,
      bool borderside = false,
      double borderRadius = 50,
      String? initialvalue,
      Color fillcolor = Colors.grey}) {
    return InputDecoration(
      labelText: initialvalue,
      filled: true,
      fillColor: fillcolor,
      isDense: true,
      border: OutlineInputBorder(
          borderSide:
              borderside ? BorderSide(color: fillcolor) : BorderSide.none,
          borderRadius: BorderRadius.circular(borderRadius)),
      enabledBorder: OutlineInputBorder(
          borderSide:
              borderside ? BorderSide(color: fillcolor) : BorderSide.none,
          borderRadius: BorderRadius.circular(borderRadius)),
      hintText: hint,
      prefixIcon: isPrefixIcon ? Icon(icon) : null,
      suffixIcon: suffixIcons,
      labelStyle: const TextStyle(color: Colors.black),
      hintStyle: TextStyle(color: Colors.black.withOpacity(0.5)),
    );
  }
}
