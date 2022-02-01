import 'package:firebase_database/firebase_database.dart';

class DatabaseService {
  final DatabaseReference _teamTailgateRef =
      FirebaseDatabase.instance.reference();
}
