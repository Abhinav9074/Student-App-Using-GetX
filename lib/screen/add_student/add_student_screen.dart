// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_app_getx/controller/screen_controller.dart';
import 'package:student_app_getx/model/student_model.dart';
import 'package:student_app_getx/theme/theme.dart';

class AddStudent extends StatelessWidget {
  AddStudent({super.key});

  TextEditingController nameCont = TextEditingController();
  TextEditingController ageCont = TextEditingController();
  TextEditingController stdCont = TextEditingController();
  TextEditingController placeCont = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final controller = Get.put(ScreenController());

  @override
  Widget build(BuildContext context) {
    controller.image = '';
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Student',
          style: MyTextStyle.appBarText,
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              controller.image = '';
              Get.back();
            },
            icon: const Icon(Icons.arrow_back_ios)),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: TextFormField(
                        controller: nameCont,
                        onChanged: (value) {
                          formKey.currentState!.validate();
                        },
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text('Name'),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'This Value Is Required';
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        controller: ageCont,
                        onChanged: (value) {
                          formKey.currentState!.validate();
                        },
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text('Age'),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'This Value Is Required';
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        controller: stdCont,
                        onChanged: (value) {
                          formKey.currentState!.validate();
                        },
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text('Standard'),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'This Value Is Required';
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: TextFormField(
                        controller: placeCont,
                        onChanged: (value) {
                          formKey.currentState!.validate();
                        },
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text('Place'),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'This Value Is Required';
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                  ],
                ),
                ElevatedButton.icon(
                    onPressed: () async {
                      await controller.pickImage();
                    },
                    icon: const Icon(Icons.upload),
                    label: const Text('Upload Image')),
                GetBuilder<ScreenController>(builder: (controller) {
                  return Container(
                      width: 150,
                      height: 150,
                      child: controller.image.isEmpty
                          ? Center(child: Text('No Image Uploaded'))
                          : Image.file(
                              File(controller.image as String),
                              width: 150,
                              height: 150,
                            ));
                }),
                ElevatedButton.icon(
                    onPressed: () async {
                      
                      if (formKey.currentState!.validate() &&
                          controller.image.isNotEmpty) {
                        await onAdd();
                        Get.snackbar(
                          'Success',
                          "Student Data Added",
                          colorText: Colors.white,
                          backgroundColor: const Color.fromARGB(255, 4, 178, 91),
                          icon: const Icon(Icons.done),
                        );
                        clear();
                      }else if (controller.image.isEmpty) {
                        Get.snackbar(
                          'Error',
                          "Please Add Image",
                          colorText: Colors.white,
                          backgroundColor: const Color.fromARGB(255, 178, 4, 4),
                          icon: const Icon(Icons.error),
                        );
                      }
                    },
                    icon: const Icon(Icons.check),
                    label: const Text('Add Student'))
              ],
            ),
          ),
        ),
      )),
    );
  }

  Future<void> onAdd() async {
    final data = StudentModel(
        name: nameCont.text,
        std: stdCont.text,
        place: placeCont.text,
        image: controller.image,
        age: ageCont.text);
    await controller.addStudent(data);
  }

  void clear(){
    nameCont.clear();
    stdCont.clear();
    placeCont.clear();
    ageCont.clear();
    controller.clearImage();
  }
}
