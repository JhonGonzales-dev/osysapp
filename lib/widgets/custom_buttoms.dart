import 'package:flutter/material.dart';

class CustomButtom extends StatelessWidget {
  final VoidCallback onpress;
  final String text;
  final Color colorButtom;
  final bool isEmpty;
  final double paddingHorizontal, paddingVertical, borderRadius;
  const CustomButtom(
      {Key? key,
      required this.onpress,
      required this.text,
      required this.borderRadius,
      required this.colorButtom,
      required this.paddingHorizontal,
      required this.paddingVertical,
      required this.isEmpty})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius)),
        disabledColor: Colors.grey,
        elevation: 0,
        color: colorButtom,
        onPressed: isEmpty ? null : onpress,
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: paddingHorizontal, vertical: paddingVertical),
          child: Text(text, style: const TextStyle(color: Colors.white)),
        ));
  }
}
