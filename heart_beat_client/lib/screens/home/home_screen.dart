import 'dart:math';

import 'package:flutter/material.dart';
import 'package:heart_beat_client/providers/auth_provider.dart';
import 'package:heart_beat_client/widgets/auth/auth_snack_bar.dart';
import 'package:heart_beat_client/widgets/common/bars/custom_app_bar.dart';
import 'package:heart_beat_client/widgets/common/bars/custom_bottom_bar.dart';
import 'package:heart_beat_client/widgets/common/fonts/title_text.dart';
import 'package:heart_beat_client/widgets/common/logos/small_logo.dart';
import 'package:heart_beat_client/widgets/home/home_info_card.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authProvider = context.read<AuthProvider>();
    // final userName = authProvider.loadName();

    return Scaffold(
      appBar: CustomAppBar(title: "Home Screen"),
      body: Column(
        children: [
          SizedBox(height: 20),
          TitleText(text: "How are you doing today?", size: 20),
          SizedBox(height: 20),
          Column(children: [HomeInfoCard(), HomeInfoCard(), HomeInfoCard()]),
          // ElevatedButton(
          //   onPressed: () async {
          //     final authProvider = context.read<AuthProvider>();
          //     final token = await authProvider.loadToken();
          //     final decodedToken = JwtDecoder.decode(token!);

          //     ScaffoldMessenger.of(context).showSnackBar(
          //       AuthSnackBar(content: Text(decodedToken.toString())),
          //     );
          //   },
          //   child: const Text("Get token"),
          // ),
        ],
      ),
      bottomNavigationBar: CustomBottomBar(currentActive: ""),
    );
  }
}
