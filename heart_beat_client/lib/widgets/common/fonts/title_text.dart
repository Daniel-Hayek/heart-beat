import 'package:flutter/material.dart';

class TitleText extends StatelessWidget {
  final String text;
  final double size;
  final TextAlign align;

  const TitleText({
    super.key,
    required this.text,
    required this.size,
    this.align = TextAlign.center,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 2,
      softWrap: true,
      textAlign: align,
      style: TextStyle(
        fontFamily: 'montserrat',
        fontSize: size,
        color: Colors.white,
      ),
    );
  }
}
