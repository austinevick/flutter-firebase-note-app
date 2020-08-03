import 'package:flutter/material.dart';

final textFieldPadding = const EdgeInsets.only(left: 15, right: 15);

final textInputDecoration = const InputDecoration(
    hintStyle: TextStyle(color: Colors.grey),
    filled: true,
    fillColor: Colors.white,
    focusedBorder: InputBorder.none,
    focusColor: Colors.white,
    contentPadding: const EdgeInsets.only(left: 14, bottom: 10, top: 10),
    enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white, width: 0.0)));

final titleTextStyle = const TextStyle(
    color: Colors.black, fontSize: 16, fontWeight: FontWeight.w700);
final contentTextStyle = const TextStyle(color: Colors.black, fontSize: 16);
final buttonTextStyle = const TextStyle(color: Colors.white);
