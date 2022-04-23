import 'package:flutter/material.dart';

elevatedButtonStyle() {
  return ElevatedButton.styleFrom(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      maximumSize: const Size(180, 50),
      elevation: 2,
      primary: Colors.orange.shade700,
      onPrimary: Colors.white,
      textStyle: const TextStyle(fontSize: 18),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)));
}
