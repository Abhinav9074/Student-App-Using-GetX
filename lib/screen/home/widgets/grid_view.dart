import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_app_getx/controller/screen_controller.dart';
import 'package:student_app_getx/screen/edit_student/edit_screen.dart';
import 'package:student_app_getx/screen/student_details/details_screen.dart';

class StudentGrid extends StatelessWidget {
  StudentGrid({super.key});

  final screenController = Get.put(ScreenController());

  @override
  Widget build(BuildContext context) {
    return GetX<ScreenController>(
      builder: (controller) {
        return GridView.count(
            crossAxisCount: 2,
            children: List.generate(controller.allStudentList.length, (index) {
              final data = controller.allStudentList[index];
              return GestureDetector(
                onTap: () {
                  Get.to(StudentProfile(name: data.name, age: data.age, std: data.std, place: data.place, image: data.image));
                },
                child: Card(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundImage: FileImage(File(data.image)),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        data.name,
                        style: const TextStyle(
                            fontFamily: 'Raleway-VariableFont_wght',
                            fontWeight: FontWeight.bold),
                      ),
                      ListTile(
                        leading: IconButton(
                          onPressed: () {
                            Get.to(EditStudent(
                                name: data.name,
                                age: data.age,
                                std: data.std,
                                place: data.place,
                                image: data.image,
                                id: data.id!));
                          },
                          icon: const Icon(Icons.edit),
                        ),
                        trailing: IconButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (ctx) {
                                  return AlertDialog(
                                    title: const Text('Are You Sure',
                                        style: TextStyle(color: Colors.red)),
                                    content: const Text(
                                        'You Wont Be Able To Retrive The Data After This Operation'),
                                    actions: [
                                      IconButton(
                                        onPressed: () {
                                          Get.back();
                                        },
                                        icon: const Icon(Icons.close),
                                      ),
                                      IconButton(
                                          onPressed: () async {
                                            await controller
                                                .deleteStudent(data.id!);
                                            Get.back();
                                            Get.snackbar('Success',
                                                'The Data Has Been Deleted',
                                                backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                                                colorText: Colors.white
                                                );
                                          },
                                          icon: const Icon(Icons.check))
                                    ],
                                  );
                                });
                          },
                          icon: const Icon(Icons.delete, color: Colors.red),
                        ),
                      )
                    ],
                  ),
                ),
              );
            }),
          );
      }
    );
  }
}
