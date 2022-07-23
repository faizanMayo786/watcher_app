import 'package:get/get.dart';
import 'package:task_schedular/db/db_helper.dart';
import 'package:task_schedular/models/task.dart';

class TaskController extends GetxController {
  @override
  void onReady() {
    super.onReady();
  }

  Future<int> addTask({required Task task}) async {
    return await DBHelper.insert(task);
  }
}
