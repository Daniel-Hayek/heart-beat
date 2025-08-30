import 'package:flutter/material.dart';

class BodyText extends StatelessWidget {
  final String text;
  final double size;

  const BodyText({Key? key, required this.text, required this.size})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontFamily: 'nunito', fontSize: size),
      textAlign: TextAlign.left,
      overflow: TextOverflow.ellipsis,
    );
  }
}
