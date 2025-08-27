import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () {},
        icon: const Icon(CupertinoIcons.line_horizontal_3, color: Colors.white),
      ),
      title: Text(title, style: const TextStyle(color: Colors.white)),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(CupertinoIcons.bell, color: Colors.white),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
