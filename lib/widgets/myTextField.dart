import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget myTextField (String hinText,String labletext, keyBoardType,controller,){
  return TextField(
    
    keyboardType: keyBoardType,
    controller: controller,
    decoration: InputDecoration(
      border: OutlineInputBorder(),
    hintText: hinText,
    hintStyle: TextStyle(
      fontSize: 14.sp,
    ),
    labelText: labletext,
    labelStyle: TextStyle(
      fontSize: 14.sp,
      color: Colors.black
    ),
    // border: InputBorder.none,
    // filled: true,
    // fillColor: Colors.grey[80],
    
    
    ),
  );
}