import 'package:flutter/material.dart';
import 'package:heart_beat_client/providers/auth_provider.dart';
import 'package:heart_beat_client/widgets/common/bars/custom_app_bar.dart';
import 'package:heart_beat_client/widgets/common/bars/custom_bottom_bar.dart';
import 'package:heart_beat_client/widgets/common/fonts/title_text.dart';
import 'package:heart_beat_client/widgets/home/home_info_card.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = context.read<AuthProvider>();
    final userName = authProvider.userName;

    return Scaffold(
      appBar: CustomAppBar(title: "Home Screen"),
      body: Column(
        children: [
          SizedBox(height: 20),
          TitleText(text: "How are you doing today, $userName?", size: 20),
          SizedBox(height: 20),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [HomeInfoCard(), HomeInfoCard(), HomeInfoCard()],
            ),
          ),
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
      bottomNavigationBar: CustomBottomBar(),
    );
  }
}
