import 'package:compan/constants.dart';
import 'package:compan/helper/helper_function.dart';
import 'package:compan/pages/profile.dart';
import 'package:compan/services/auth_service.dart';
import 'package:compan/services/database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../auth/loginPage.dart';
import 'search_page.dart';

class homePage extends StatefulWidget {
  const homePage({Key? key}) : super(key: key);

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  AuthService authService = AuthService();
  String email = "";
  String email1 = "";
  //String userEmail = "";
  String userName = "";
  Stream? groups;
  bool isLoading = false;
  String groupName = "";
  TextEditingController groupNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getingUserData();
  }

  getingUserData() async{
      await helperFunction.getUserNameFromSf().then((value) {
        setState(() {
          userName = value;
        });
      });

      await helperFunction.getUserEmailFromSF().then((value){
        setState(() {
          email = value;
        });
      });

      await helperFunction.getUserEmail().then((value){
        setState(() {
          email1 = value!;
        });
      });

      //getting user groups
      await DatabaseServices(uid: FirebaseAuth.instance.currentUser!.uid).getUserGroups().then((snapshot){
        setState(() {
          groups = snapshot;
        });
      });
  }

   Widget GroupList()  {
    return StreamBuilder(
      stream: groups,
        builder: (BuildContext context, AsyncSnapshot snapshot){
          if(snapshot.hasData){
            if(snapshot.data['groups'] != null){
              if(snapshot.data['groups'].length != 0){
                return
                    Text("hello");
              } else{
                return noGroupWidget();
              }

            }else{
              return noGroupWidget();
            }

          }else{
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
  
  noGroupWidget() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
           icon: const Icon(Icons.add_circle,
           color: Colors.grey,
           size: 75),
          onPressed: (){
             popUpDialog(context);
          },),
          
          const Text("You've not joined any groups, tap on add icon to create or search from top to join",
            textAlign: TextAlign.center,),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text(
         "Compan", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 27),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: (){
              nextScreen(context, const searchPage());
            },)
        ],
      ),

      drawer: Drawer(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 50),
          children: [
            const Icon(
              Icons.account_circle,
              size: 150,
              color: Colors.grey,
            ),
            
            const SizedBox(height: 15,),
            
            Center(
              //padding: const EdgeInsets.symmetric(horizontal: 90.0,),
              child: Text(userName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
            ),

            const SizedBox(
              height: 10,
            ),

            Center(
              //padding: const EdgeInsets.symmetric(horizontal: 90.0,),
              child: Text(email1, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
            ),

            const Divider(
              height: 3,
            ),

            ListTile(
             // selectedTileColor: Theme.of(context).primaryColor,
              selected: true,
              contentPadding: const EdgeInsets.only(top: 70, left: 10),
              leading: const Icon(Icons.group, size: 40,),
              title:  const Text("Groups", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
              onTap: (){
                nextScreen(context, const homePage());
              },
            ),

            const SizedBox(
              height: 5,
            ),

            ListTile(
              // selectedTileColor: Theme.of(context).primaryColor,
              selected: true,
              contentPadding: const EdgeInsets.only(top: 30, left: 10),
              leading: const Icon(Icons.group, size: 40,),
              title:  const Text("Profile", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
              onTap: (){
                nextScreen(context, profile(Email: email, UserName: userName,));
              },
            ),

            const SizedBox(
              height: 5,
            ),

             ListTile(
              selected: true,
               contentPadding: const EdgeInsets.only(top: 30, left: 10),
              leading: const Icon(Icons.exit_to_app, size: 40,),
              title: const Text("Logout", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
              onTap: (){
                AlertDialog(
                  title: const Text("Are you Sure You Want To Logout"),
                  actions: [
                    IconButton(
                      icon: Icon(Icons.cancel),
                      onPressed: (){
                        Navigator.pop(context);
                      },),

                    IconButton(
                      icon: Icon(Icons.done),
                      onPressed: (){
                        authService.signOut();
                        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=> const loginPage()), (route) => false);
                      },),
                  ],
                );
                authService.signOut();
                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=> const loginPage()), (route) => false);
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        child: const Icon(Icons.add, size: 40,),
        onPressed: (){
          popUpDialog(context);
        },
      ),
      body: GroupList(),
    );
  }

   popUpDialog(BuildContext context) {
    showDialog(
        context: context, builder: (context){
          return AlertDialog(
            title: const Text("Create Group", textAlign: TextAlign.left,),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                isLoading == true ? Center(child: CircularProgressIndicator(color: Theme.of(context).primaryColor))
                    : TextField(
                        controller: groupNameController,
                        onChanged: (val){
                          setState(() {
                            groupName = val;
                          });
                        },
                         decoration: InputDecoration(
                           enabledBorder: OutlineInputBorder(
                             borderSide: BorderSide(
                               color: Theme.of(context).primaryColor),
                             borderRadius: BorderRadius.circular(20)),

                             errorBorder: OutlineInputBorder(
                                 borderSide: const BorderSide(
                                     color: Colors.red),
                                 borderRadius: BorderRadius.circular(20)),

                             focusedBorder: OutlineInputBorder(
                                 borderSide: BorderSide(
                                     color: Theme.of(context).primaryColor),
                                 borderRadius: BorderRadius.circular(20))),
                ),
              ],
            ),
            actions: [
              ElevatedButton(onPressed: (){

                 if(groupNameController.text != ""){
                   setState(() {
                     isLoading = true;
                   });

                   DatabaseServices(uid: FirebaseAuth.instance.currentUser!.uid).createGroup(userName, FirebaseAuth.instance.currentUser!.uid, groupName).whenComplete((){
                     isLoading = false;
                   });

                   Navigator.of(context).pop();
                   showSnackBar(context, "Group Created Successfully", Colors.green);
                 }else{
                   showSnackBar(context, "Group name cannot be empty", Colors.red);
                 }


                }, child: const Text("CREATE")),

              SizedBox(
                width: 40,
              ),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).primaryColor
                ),
                  onPressed: (){
                      Navigator.of(context).pop();
                  },
                  child: const Text("CANCEL")),

              SizedBox(
                width: 10,
              )
            ],
          );
    });
   }
}
