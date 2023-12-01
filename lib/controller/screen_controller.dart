import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_app_getx/model/student_model.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive_flutter/hive_flutter.dart';

// ignore: constant_identifier_names

// ignore: constant_identifier_names
const String DB_NAME = 'student_database';



class ScreenController extends GetxController {

  List<StudentModel> allStudentList = <StudentModel>[].obs;



  Future<void> addStudent(StudentModel data) async {
    final db = await Hive.openBox<StudentModel>(DB_NAME);
    data.id = await db.add(data);
    db.put(data.id, data);
    await getStudents();
  }

  Future<void> editStudent(StudentModel data) async {
    final db = await Hive.openBox<StudentModel>(DB_NAME);
    db.put(data.id, data);
    await getStudents();
  }

  Future<void>deleteStudent(int id)async{
    final db = await Hive.openBox<StudentModel>(DB_NAME);
    await db.delete(id);
    await getStudents();
  }

  Future<List<StudentModel>> getAllData() async {
    final db = await Hive.openBox<StudentModel>(DB_NAME);
    return db.values.toList();
  }

  Future<void> getStudents() async {
    allStudentList.clear();
    final allStudents = await getAllData();
    Future.forEach(allStudents, (element) {
      allStudentList.add(element);
    });
  }


  Future<void> searchStudent(String name)async{
    allStudentList.clear();
    final allSrudenList = await getAllData();
    Future.forEach(allSrudenList, (element){
      if(element.name.contains(name)){
        allStudentList.add(element);
      }
    });
  }

  String image = '';

  void clearImage(){
    image = '';
    update();
  }
  Future<void> pickImage() async {
    final imgFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    image = imgFile!.path;
    update();
  }
}
