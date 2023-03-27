import 'package:compan/helper/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'pages/homePage.dart';
import 'auth/loginPage.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(compan());
}

class compan extends StatefulWidget {
  const compan({Key? key}) : super(key: key);

  @override
  State<compan> createState() => _companState();
}

class _companState extends State<compan> {
  bool isSignedIn = false;

  @override
  void initState() {
    getUserLoggedInStatus();
  }

  getUserLoggedInStatus() async {
    await helperFunction.getUserLOggedInStatus().then((value)
        {
          if(value != null){
            setState(() {
              isSignedIn = value;
            });
          }
        }
    );
}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: isSignedIn ? homePage() : loginPage(),
    );
  }
}
