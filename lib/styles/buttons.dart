import 'package:flutter/material.dart';

elevatedButtonStyle() {
  return ElevatedButton.styleFrom(
      minimumSize: const Size(150, 40),
      elevation: 2,
      primary: const Color(0xff2c3243),
      onPrimary: const Color(0xffd6d0c0),
      textStyle: const TextStyle(fontSize: 18),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)));
}
