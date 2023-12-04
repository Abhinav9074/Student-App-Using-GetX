import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_app_getx/controller/screen_controller.dart';
import 'package:student_app_getx/views/home/screens/home_screen.dart';

class SplashScreen extends StatelessWidget {
   SplashScreen({super.key});

  final controller = Get.put(ScreenController());

  @override
  Widget build(BuildContext context) {
    
    Timer(const Duration(seconds: 3), () async{
      await controller.getStudents();
      Get.offAll( HomeScreen());
    });
    return  Scaffold(
      body: Center(
        child: Image.asset('assets/images/load.gif'),
      ),
    );
  }
}