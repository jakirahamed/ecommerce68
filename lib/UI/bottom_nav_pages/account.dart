import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce68/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../login_screen.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({ Key? key }) : super(key: key);

  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  User? user = FirebaseAuth.instance.currentUser;
Usermodel loggedInUser = Usermodel();

@override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
    .collection("users")
    .doc(user!.email)
    .get()
    .then((value) => {
      this.loggedInUser = Usermodel.fromMap(value.data()),
    setState((){})
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome"),
        centerTitle: true,

      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 80,
              child: Image.asset("assets/wh-10.png"),
            ),
            SizedBox(height: 30,),
            Text("Welcome Admin",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600)),
            SizedBox(height: 10,),
            Text("${loggedInUser.firstName} ${loggedInUser.secondName}"),
            SizedBox(height: 10,),
            Text("${loggedInUser.email}"),
            SizedBox(height: 15,),
            ActionChip(label: Text("Logout"), onPressed: (){
              logout(context);
            }),


          ],
        ),
      ),
    );
  }
}


Future<void> logout (BuildContext context) async
{
  await FirebaseAuth.instance.signOut();
  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Login_screen()));
}