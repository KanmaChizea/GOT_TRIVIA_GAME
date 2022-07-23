import 'package:flutter/material.dart';

import 'colors.dart';

final elevatedButtonStyle = ElevatedButton.styleFrom(
    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
    elevation: 2,
    primary: primary,
    onPrimary: white,
    textStyle: const TextStyle(fontSize: 18),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)));
