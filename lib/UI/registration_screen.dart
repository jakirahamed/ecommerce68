import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce68/UI/login_screen.dart';
import 'package:ecommerce68/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'button_nev_controller.dart';
class Registration_Screen extends StatefulWidget {
  const Registration_Screen({Key? key}) : super(key: key);

  @override
  _Registration_ScreenState createState() => _Registration_ScreenState();
}

class _Registration_ScreenState extends State<Registration_Screen> {
  //auth
  final _auth = FirebaseAuth.instance;
//password visible
  bool _passwordVisible = false;

// from key

  final _formKey = GlobalKey<FormState>();

//from controller

  final firstNameController = new TextEditingController();
  final secondNameController = new TextEditingController();
  final emailEditingController = new TextEditingController();
  final passwordEditingController = new TextEditingController();
  final confirmPasswordEditingController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    //First Name field
    final firstNameField = TextFormField(
      autofocus: false,
      controller: firstNameController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty || !RegExp(r'^.{3,}$').hasMatch(value)) {
          return "Enter Valid First Name (min. 3 character)";
        } else {
          return null;
        }
      },
      onSaved: (value) {
        firstNameController.text = value!;
      },
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.account_circle),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "First Name",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
      textInputAction: TextInputAction.next,
    );

    //Second Name field
    final secondNameField = TextFormField(
      autofocus: false,
      controller: secondNameController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty || !RegExp(r'^.{3,}$').hasMatch(value)) {
          return "Enter Valid Second Name (min. 3 character)";
        } else {
          return null;
        }
      },
      onSaved: (value) {
        secondNameController.text = value!;
      },
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.account_circle),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Second Name",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
      textInputAction: TextInputAction.next,
    );

    //email field
    final emailEditingField = TextFormField(
      autofocus: false,
      controller: emailEditingController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty ||
            !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                .hasMatch(value)) {
          return "Enter Correct Email";
        } else {
          return null;
        }
      },
      onSaved: (value) {
        emailEditingController.text = value!;
      },
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.mail),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Email",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
      textInputAction: TextInputAction.next,
    );
    //password field
    final passwordEditingField = TextFormField(
      autofocus: false,
      controller: passwordEditingController,
      obscureText: !_passwordVisible,
      validator: (value) {
        if (value!.isEmpty || !RegExp(r'^.{6,}$').hasMatch(value)) {
          return "Enter Valid Password (min. 6 character)";
        } else {
          return null;
        }
      },
      onSaved: (value) {
        passwordEditingController.text = value!;
      },
      decoration: InputDecoration(
          prefixIcon: IconButton(
            icon: Icon(
              _passwordVisible ? Icons.visibility : Icons.visibility_off,
            ),
            onPressed: () {
              setState(() {
                _passwordVisible = !_passwordVisible;
              });
            },
          ),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Password",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
      textInputAction: TextInputAction.done,
    );
    //Confirm password field
    final confirmPasswordField = TextFormField(
      autofocus: false,
      controller: confirmPasswordEditingController,
      obscureText: !_passwordVisible,
      validator: (value) {
        if (confirmPasswordEditingController.text !=
            passwordEditingController.text) {
          return "Password don't match";
        }
        return null;
      },
      onSaved: (value) {
        confirmPasswordEditingController.text = value!;
      },
      decoration: InputDecoration(
          prefixIcon: IconButton(
            icon: Icon(
              _passwordVisible ? Icons.visibility : Icons.visibility_off,
            ),
            onPressed: () {
              setState(() {
                _passwordVisible = !_passwordVisible;
              });
            },
          ),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Confirm Password",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
      textInputAction: TextInputAction.done,
    );

    //Signup button
    final signupButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.blueAccent,
      child: MaterialButton(
          padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: MediaQuery.of(context).size.width,
          elevation: 2,
          color: Colors.blueAccent,
          child: Text(
            "Sign Up",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: () {
            signUp(emailEditingController.text, passwordEditingController.text);
          }),
    );

    return Scaffold(
      
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: Form(
                key: _formKey,
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                   SizedBox(height: 140,),
                    Text('Sign Up',style: TextStyle(fontSize: 40,fontWeight: FontWeight.w500),),
                    SizedBox(height: 70),
                    firstNameField,
                    SizedBox(height: 15),
                    secondNameField,
                    SizedBox(height: 15),
                    emailEditingField,
                    SizedBox(
                      height: 15,
                    ),
                    passwordEditingField,
                    SizedBox(
                      height: 15,
                    ),
                    confirmPasswordField,
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text("Already have an account? ",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w300),),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        Login_screen()));
                          },
                          child: Text(
                            "Login",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.blueAccent,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    signupButton,
                    SizedBox(height: 150,),
                    Center(child: Text("Or sign up with social account",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w300),)),
                    SizedBox(height: 25,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset("assets/google.png",width: 50,),
                        SizedBox(width: 25,),
                        Image.asset("assets/facebook.png",width: 50,),
                      ],
                    )
                  ],
                )),
          ),
        ),
      ),
    );
  }

  void signUp(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {postDetailsToFirestore()})
          .catchError((e) {
        Fluttertoast.showToast(msg: e!.message);
      });
    }
  }

  postDetailsToFirestore() async {
// calling our firestore
//calling our user model
//sending these values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    Usermodel usermodel = Usermodel();

//writing all the values
    usermodel.email = user!.email;
    usermodel.uid = user.uid;
    usermodel.firstName = firstNameController.text;
    usermodel.secondName = secondNameController.text;

    await firebaseFirestore
        .collection("users")
        .doc(user.email)
        .set(usermodel.toMap());
    Fluttertoast.showToast(msg: "Account Created successfully :)");
    Navigator.pushAndRemoveUntil(
        (context),
        MaterialPageRoute(builder: (context) => ButtonNavController()),
        (route) => false);
  }
}
