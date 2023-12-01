// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_app_getx/controller/screen_controller.dart';
import 'package:student_app_getx/screen/add_student/add_student_screen.dart';
import 'package:student_app_getx/screen/home/widgets/grid_view.dart';
import 'package:student_app_getx/screen/home/widgets/search_widget.dart';
import 'package:student_app_getx/theme/theme.dart';

class HomeScreen extends StatelessWidget {
   HomeScreen({super.key});

  final controller = Get.put(ScreenController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Home',
          style: MyTextStyle.appBarText,
        ),
        centerTitle: true,
      ),
      body:  SafeArea(
          child: Column(
            children: [
              SearchWidget(),
              Expanded(child: StudentGrid()),
            ],
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(AddStudent());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
