import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies_app/screens/home_screen.dart';

void main() {
  runApp(const GetMaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomeScreen(),
  ));
}
