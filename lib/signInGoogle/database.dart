import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class Database {
  static String? userUid;

  static Stream<QuerySnapshot> readUsers() {
    CollectionReference UserCollection =
        FirebaseFirestore.instance.collection("users");

    return UserCollection.snapshots();
  }
}
