import 'package:compan/auth/loginPage.dart';
import 'package:compan/helper/helper_function.dart';
import 'package:compan/pages/homePage.dart';
import 'package:compan/services/auth_service.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class registePage extends StatefulWidget {
  const registePage({Key? key}) : super(key: key);

  @override
  State<registePage> createState() => _registePageState();
}

class _registePageState extends State<registePage> {
  final formKey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  String fullName = "";
  bool isLoading = false;
  AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body: isLoading? const Center(
          child: CircularProgressIndicator( color: Colors.blue,),
        )
        : SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,

                children: <Widget> [
                  const Text(
                    "Compan",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  const Text(
                    "Register To Grab Your Company Today",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                  ),

                  const SizedBox(
                    height: 30,
                  ),

                  Image.asset("assets/loginImage.png"),

                  const SizedBox(
                    height: 50,
                  ),

                  TextFormField(
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      label: Text("Full Name"),
                      hintText: "Enter Your Name Here",
                      border: OutlineInputBorder(),
                    ),

                    validator: (val){
                      if(val!.length < 0){
                        return "Name Field can't be empty";
                      }
                    },

                    onChanged: (val){
                      email = val;
                    },
                  ),

                  const SizedBox(
                    height: 30,
                  ),

                  TextFormField(
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      label: Text("email"),
                      hintText: "Enter Email",
                      border: OutlineInputBorder(),
                    ),

                    validator: (val){
                      if(val!.length < 0){
                        return "email can't be empty";
                      }
                    },

                    onChanged: (val){
                      email = val;
                    },
                  ),

                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    obscureText: true,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.lock),
                      label: Text("password"),
                      hintText: "Enter Password",
                      border: OutlineInputBorder(),
                    ),

                    validator: (val){
                      if(val!.length < 6){
                        return "Password must be at least 6 characters";
                      }
                    },
                    onChanged: (val){
                      setState(() {
                        password = val;
                      });
                    },
                  ),

                  const SizedBox(
                    height:  60,
                  ),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            )
                        ),
                        onPressed: (){
                          register();

                        },
                        child: const Text( "Submit" )),
                  ),

                  const SizedBox(
                    height:  10,
                  ),

                  Text.rich(
                      TextSpan(
                          text: "Don't Have An Account ",
                          style: TextStyle(color: Colors.black, fontSize: 14),
                          children: <TextSpan>[
                            TextSpan(
                                text: "login Here",
                                style: TextStyle(color: Colors.black, decoration: TextDecoration.underline),
                                recognizer: TapGestureRecognizer()..onTap = (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => const loginPage()));
                                }),

                          ]
                      ))

                ],
              ),

            ),
          ),
        )
    );
  }

  register() async {
    if (formKey.currentState!.validate()){
      setState(() {
        isLoading = true;
      });
      await authService.registerUserWithEmailAndPassword(fullName, email, password).then((value) async{
        if(value == true){
          //saving the shared preference state
          await helperFunction.saveUserLoggedInStatus(true);
          await helperFunction.SaveUserEmailSF(email);
          await helperFunction.SaveUserNameSF(fullName);
          nextScreen(context, const homePage());

        }else{
          showSnackBar(context , value, Colors.red);
        }
      });
    }
  }
}
