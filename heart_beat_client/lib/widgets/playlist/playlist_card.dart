import 'dart:math';

import 'package:flutter/material.dart';

class PlaylistCard extends StatelessWidget {
  final List<Color> colors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.indigo,
    Colors.pink,
  ];

  PlaylistCard({super.key});

  Color getRandomColor() {
    final Random random = Random();
    return colors[random.nextInt(colors.length)];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 270,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: getRandomColor(),
        border: Border.all(color: Colors.black, width: 1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text("This is a playlist"),
    );
  }
}
