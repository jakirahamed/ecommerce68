import 'package:flutter/material.dart';

Widget categoriesButton(String text,onPressed, String seeAll) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
    child: Row(
      children: [
        Expanded(
          flex: 7,
          child: Text(
            text,
            style: TextStyle(fontSize: 22),
          ),
        ),
        Expanded(
          flex: 2,
          child: MaterialButton(
              elevation: 0.3,
              color: Colors.white,
              onPressed: onPressed,
              child: Text(seeAll)),
        ),
      ],
    ),
  );
}
