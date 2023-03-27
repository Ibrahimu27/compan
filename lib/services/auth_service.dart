import 'package:compan/helper/helper_function.dart';
import 'package:compan/services/database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService{

  //register
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  Future registerUserWithEmailAndPassword(String fullName, String email, String password) async {
    try {
      User user = ( await firebaseAuth.createUserWithEmailAndPassword(
              email: email, password: password)).user!;

      if(user != null){
       await DatabaseServices(uid: user.uid).UpdateUserData(fullName, email);
        return true;
      }

    } on FirebaseAuthException catch(e){
      print(e);
    }
  }

  //login
  Future loginWithEmailAndPassword(String email, String password) async {
    try {
      User user = ( await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password)).user!;

      if(user != null){
        return true;
      }

    } on FirebaseAuthException catch(e){
      print(e);
    }
  }

  //signout function
   Future signOut() async {
   try{
      await helperFunction.saveUserLoggedInStatus(false);
      await helperFunction.SaveUserEmailSF("");
      await helperFunction.SaveUserNameSF(" ");
      await firebaseAuth.signOut();
    } catch(e){
     return null;
   }
  }


  //login
}