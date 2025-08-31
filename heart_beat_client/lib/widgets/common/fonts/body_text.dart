import 'package:flutter/material.dart';

class BodyText extends StatelessWidget {
  final String text;
  final double size;
  final int? maxLines;

  const BodyText({
    super.key,
    required this.text,
    required this.size,
    required this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontFamily: 'nunito', fontSize: size),
      textAlign: TextAlign.left,
      overflow: TextOverflow.ellipsis,
      maxLines: maxLines,
      softWrap: true,
    );
  }
}
