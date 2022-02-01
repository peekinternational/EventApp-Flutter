import 'package:flutter/material.dart';
import 'package:teamtailgate_flutter/screens/authenticate/authenticate.dart';

class Welcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/background_3_gradient.png'),
              fit: BoxFit.cover),
        ),
        child: Expanded(
          child: Column(
            children: [
              SizedBox(
                height: 150.0,
              ),
              Image(image: AssetImage('assets/team_tailgate_logo_white.png')),
              Container(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  'Invite Friends. Forget Nothing.',
                  style: TextStyle(color: Colors.white, fontSize: 16.0),
                ),
              ),
              Expanded(
                child: Container(), //Fill space in middle
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Authenticate()));
                  },
                  child: Text('Continue with Email')),
              SizedBox(
                height: 50.0,
              )
            ],
          ),
        ),
      ),
    );
  }
}
