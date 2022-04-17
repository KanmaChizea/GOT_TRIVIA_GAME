import 'package:flutter/material.dart';

elevatedButtonStyle() {
  return ElevatedButton.styleFrom(
      maximumSize: const Size(150, 50),
      elevation: 2,
      primary: Colors.orange.shade600,
      onPrimary: Colors.white,
      textStyle: const TextStyle(fontSize: 18),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)));
}
