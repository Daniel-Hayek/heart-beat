import 'package:flutter/material.dart';

class SmallLogo extends StatelessWidget {
  const SmallLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 64, maxWidth: 64),
      child: Image.asset('assets/images/heart-beat-logo.png'),
    );
  }
}
