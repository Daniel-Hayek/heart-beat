import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heart_beat_client/widgets/common/bars/custom_app_bar.dart';
import 'package:heart_beat_client/widgets/common/bars/custom_bottom_bar.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Mood Tracking Stats"),
      body: Container(
        padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * 0.06,
          horizontal: MediaQuery.of(context).size.width * 0.06,
        ),
      ),
      bottomNavigationBar: CustomBottomBar(),
    );
  }
}
