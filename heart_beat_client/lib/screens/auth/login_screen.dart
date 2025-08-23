import 'package:flutter/material.dart';
import 'package:heart_beat_client/widgets/common/medium_logo.dart';

class LoginScreen extends StatelessWidget {
const LoginScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Column(
        children: [
          MediumLogo(),
          
        ],
      ),
    );
  }
}