import 'package:flutter/material.dart';
import 'package:teamtailgate_flutter/screens/authenticate/create_account.dart';
import 'package:teamtailgate_flutter/screens/authenticate/login.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showLogin = true;

  void toggleView() {
    setState(() => showLogin = !showLogin);
  }

  @override
  Widget build(BuildContext context) {
    if (showLogin) {
      return Login(toggleView: toggleView);
    } else {
      return CreateAccount(toggleView: toggleView);
    }
  }
}
