import 'package:flutter/material.dart';

class CustomRichText extends StatelessWidget {
  const CustomRichText(this.title, this.subTitle, {super.key});

  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(
      children: <TextSpan>[
        TextSpan(
            text: '$title ',
            style: const TextStyle(
                fontWeight: FontWeight.w500, fontSize: 15, color: Colors.grey)),
        TextSpan(
            text: '$subTitle ',
            style: const TextStyle(fontSize: 15, color: Colors.grey)),
      ],
    ));
  }
}
