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

//retrieving user groups
getUserGroups() async {
    return userCollection.doc(uid).snapshots();
}

//creating group function
Future createGroup(String userName, String UserId, String groupName ) async{
    DocumentReference groupDocumentRefernce = await groupCollection.add({
      "groupname": groupName,
      "groupIcon": "",
      "admin": "${UserId}_$userName",
      "memebers": [],
      "groupId": "",
      "recentMessage": "",
      "recentMessageCender": "",
    });

//update reference datas
  await groupDocumentRefernce.update({
    "members": FieldValue.arrayUnion(["${uid}_$userName"]),
    "groupId":  groupDocumentRefernce.id,
  });
  
//updating group informations on usertable/user collection
  DocumentReference userDocumentRefence = userCollection.doc(uid);
  return await userDocumentRefence.update({
    "groups": FieldValue.arrayUnion(["${groupDocumentRefernce.id}_$groupName"])
  });
}



}

