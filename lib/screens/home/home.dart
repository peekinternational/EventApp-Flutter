import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:teamtailgate_flutter/services/auth_service.dart';
import 'FeedFragment.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();
  int _currentIndex = 0;

  //_MyCreation

  _getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return FeedFragment();
      case 1:
      return Center(
          child: Text('Upcoming'),
        );
      case 2:
        return Center(
          child: Text('Add'),
        );
      case 3:
        return Center(
          child: Text('Notifs'),
        );
      case 4:
        return Center(
          child: Text('Profile'),
        );
      default:
        return new Text("Error");
    }
  }


  final screens = [
    Center(
      child: Text("feed"),
    ),
    Center(
      child: Text('Upcoming'),
    ),
    Center(
      child: Text('Add'),
    ),
    Center(
      child: Text('Notifs'),
    ),
    Center(
      child: Text('Profile'),
    )
  ];

  void getFeedFromFirebase() {
    setState(() {
      // final dbRef = FirebaseDatabase.instance.reference().child("workshops");
      // Future<DataSnapshot> getData() async{
      //   var user = FirebaseAuth.instance.currentUser!;
      //   final dbRef = FirebaseDatabase.instance.reference().child('Manager').child(user.uid).child(accountKey!);
      //   return await dbRef.once();
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[100],
      appBar: AppBar(
        title: Text('Feed'),
        backgroundColor: Colors.blue,
        elevation: 0.0,
        actions: <Widget>[
          TextButton(
            child: Text(
              'Logout',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () async {
              await _auth.signOut();
            },
          )
        ],
      ),
      // body: screens[_currentIndex],
      body: _getDrawerItemWidget(_currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Feed'),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today), label: 'Upcoming'),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'New Event'),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications), label: 'Notifications'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: (index) => setState(() => _currentIndex = index),
      ),
    );
  }
}


