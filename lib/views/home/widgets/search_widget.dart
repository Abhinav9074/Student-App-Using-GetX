import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_app_getx/controller/screen_controller.dart';

// ignore: must_be_immutable
class SearchWidget extends StatelessWidget {
  SearchWidget({super.key});

  TextEditingController searchCont = TextEditingController();

  final controller = Get.find<ScreenController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: searchCont,
        onChanged: (value) async {
          await controller.searchStudent(value);
        },
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.search),
          suffixIcon: IconButton(
              onPressed: () {
                searchCont.clear();
              },
              icon: const Icon(Icons.close)),
          border: const OutlineInputBorder(),
          label: const Text('Search Students'),
        ),
      ),
    );
  }
}
