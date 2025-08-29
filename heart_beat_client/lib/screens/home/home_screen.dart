import 'package:flutter/material.dart';
import 'package:heart_beat_client/providers/auth_provider.dart';
import 'package:heart_beat_client/widgets/common/custom_app_bar.dart';
import 'package:heart_beat_client/widgets/common/small_logo.dart';
import 'package:heart_beat_client/widgets/home/home_info_card.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      appBar: CustomAppBar(title: "Home Screen"),
      body: Column(
        children: [
          SmallLogo(),
          Text("How are you doing today, User?"),
          Column(children: [HomeInfoCard()]),
        ],
      ),
      bottomNavigationBar: BottomAppBar(),
    );
  }
}
