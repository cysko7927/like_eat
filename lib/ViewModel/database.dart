import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  //collection of reference
  final CollectionReference = FirebaseFirestore.instance.collection("User");
}
