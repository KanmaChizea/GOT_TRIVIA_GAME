import 'package:flutter/material.dart';

TextStyle headings() {
  return const TextStyle(
      fontSize: 25, color: Colors.white70, fontWeight: FontWeight.bold);
}

TextStyle body() {
  return const TextStyle(fontSize: 20, color: Colors.white);
}

TextStyle result() {
  return const TextStyle(
      fontSize: 50, color: Colors.white, fontWeight: FontWeight.bold);
}

TextStyle statisticsHeaders() {
  return const TextStyle(color: Color(0xffFFFDD0), fontSize: 20);
}

TextStyle tableHeader() {
  return const TextStyle(
      fontWeight: FontWeight.w700, color: Color(0xffFFFDD0), fontSize: 17);
}

TextStyle tableBody() {
  return const TextStyle(
      fontWeight: FontWeight.w500, color: Color(0xffFFFDD0), fontSize: 15);
}
