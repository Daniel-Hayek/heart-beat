import 'package:flutter/cupertino.dart';
import 'package:heart_beat_client/widgets/common/fonts/body_text.dart';
import 'package:heart_beat_client/widgets/common/fonts/title_text.dart';

class ProfileInfo extends StatelessWidget {
  final String label;
  final String value;

  const ProfileInfo({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleText(text: label, size: 20),
        SizedBox(height: 10),
        BodyText(text: value, size: 18, maxLines: null),
        SizedBox(height: 20),
      ],
    );
  }
}
