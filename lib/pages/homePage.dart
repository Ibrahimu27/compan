import 'package:compan/auth/loginPage.dart';
import 'package:compan/constants.dart';
import 'package:compan/services/auth_service.dart';
import 'package:flutter/material.dart';

class homePage extends StatefulWidget {
  const homePage({Key? key}) : super(key: key);

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: ElevatedButton(
            child: Text("LOG OUT"),
            onPressed: (){
              authService.signOut();
              nextScreen(context, loginPage());
      })
      ),
    );
  }
}
