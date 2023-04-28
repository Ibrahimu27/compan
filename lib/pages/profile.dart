import 'package:flutter/material.dart';

class profile extends StatefulWidget {
  String UserName;
  String Email;
  profile({Key? key, required this.Email, required this.UserName}) : super(key: key);

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.UserName),
      ),
      body: SafeArea(
        child: Center(
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 110, vertical: 150),
                child: IconButton(
                  icon: const Icon(Icons.account_circle, size: 150,),
                  onPressed: (){},),
              ),

              const SizedBox(height: 60,),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 70.0),
                child: Row(
                  children: [
                    const Text("UserName:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25), ),

                    const SizedBox(width: 15,),

                    Text(widget.UserName, style: TextStyle(),),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 70.0, vertical: 10),
                child: Row(
                  children: [
                    const Text("Email:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25), ),

                    const SizedBox(width: 15,),

                    Text(widget.Email, style: TextStyle(),),
                  ],
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}
