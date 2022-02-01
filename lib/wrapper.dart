import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:teamtailgate_flutter/screens/authenticate/welcome.dart';
import 'package:teamtailgate_flutter/screens/home/home.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    if (user == null) {
      //return Welcome();
      return Home();
    } else {
      return Home();
    }
  }
}
