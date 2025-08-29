import 'dart:math';

import 'package:flutter/material.dart';
import 'package:heart_beat_client/providers/auth_provider.dart';
import 'package:heart_beat_client/widgets/auth/auth_snack_bar.dart';
import 'package:heart_beat_client/widgets/common/custom_app_bar.dart';
import 'package:heart_beat_client/widgets/common/custom_bottom_bar.dart';
import 'package:heart_beat_client/widgets/common/small_logo.dart';
import 'package:heart_beat_client/widgets/home/home_info_card.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authProvider = context.read<AuthProvider>();
    final userName = "nmae";

    return Scaffold(
      appBar: CustomAppBar(title: "Home Screen"),
      body: Column(
        children: [
          Text("How are you doing today, $userName?"),
          Column(children: [HomeInfoCard(), HomeInfoCard(), HomeInfoCard()]),
          ElevatedButton(
            onPressed: () async {
              final authProvider = context.read<AuthProvider>();
              final token = await authProvider.loadToken();
              final decodedToken = JwtDecoder.decode(token!);

              ScaffoldMessenger.of(context).showSnackBar(
                AuthSnackBar(content: Text(decodedToken.toString())),
              );
            },
            child: const Text("Get token"),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomBar(currentActive: ""),
    );
  }
}
