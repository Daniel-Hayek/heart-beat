import 'package:flutter/material.dart';

class TitleText extends StatelessWidget {
  final String text;
  final double size;

  const TitleText({Key? key, required this.text, required this.size});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(fontFamily: 'montserrat', fontSize: size),
    );
  }
}
