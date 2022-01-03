import 'package:ecommerce68/UI/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812),
      builder: ()=> MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Email and Password Login',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Login_screen(),
      ),
    );
  }
}
