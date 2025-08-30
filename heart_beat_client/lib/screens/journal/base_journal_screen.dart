import 'package:flutter/material.dart';
import 'package:heart_beat_client/providers/auth_provider.dart';
import 'package:heart_beat_client/widgets/common/bars/custom_app_bar.dart';
import 'package:heart_beat_client/widgets/common/bars/custom_bottom_bar.dart';
import 'package:heart_beat_client/widgets/common/fonts/title_text.dart';
import 'package:provider/provider.dart';

class BaseJournalScreen extends StatelessWidget {
  const BaseJournalScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authProvider = context.read<AuthProvider>();
    final userName = authProvider.userName;

    return Scaffold(
      appBar: CustomAppBar(title: "Journal"),
      body: Column(
        children: [
          TitleText(text: "What's on your mind today, $userName?", size: 20),
          // GridView.count(
          //   crossAxisCount: 2,
          //   crossAxisSpacing: 10,
          //   mainAxisSpacing: 10,
          //   padding: EdgeInsets.all(16),
          //   children: List.generate(6, (index) {
          //     return Container(
          //       color: Colors.blue,
          //       child: Center(child: Text("Item $index")),
          //     );
          //   }),
          // ),
        ],
      ),
      bottomNavigationBar: CustomBottomBar(currentActive: "Journal"),
    );
  }
}
