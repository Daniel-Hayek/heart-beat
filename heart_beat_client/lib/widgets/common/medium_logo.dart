import 'package:flutter/material.dart';

class MediumLogo extends StatelessWidget {
  const MediumLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 150, maxWidth: 150),
      child: Image.asset('assets/images/heart-beat-logo.png'),
    );
  }
}
