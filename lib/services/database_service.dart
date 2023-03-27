import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseServices{
  final String? uid;
  DatabaseServices({this.uid});

  //reference for our collection
  final CollectionReference userCollection = FirebaseFirestore.instance.collection("user");
  final CollectionReference groupCollection = FirebaseFirestore.instance.collection("groups");

  //function to updating user data
  Future UpdateUserData(String fullName, String email) async {
    return await userCollection.doc(uid).set({
      "fullname": fullName,
      "email": email,
      "groups": [],
      "profilePic": "",
      "uid": uid,
    });
  }

//retrieving user data from the databse
Future gettingUserData(String email) async {
    QuerySnapshot snapshot = await userCollection.where("email", isEqualTo: email).get();
    return snapshot;
}

}

