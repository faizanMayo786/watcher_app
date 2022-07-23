import 'package:get/get.dart';
import 'package:task_schedular/db/db_helper.dart';
import 'package:task_schedular/models/task.dart';

class TaskController extends GetxController {
  var taskList = <Task>[].obs;
  @override
  void onReady() {
    super.onReady();
    getTask();
  }

  Future<int> addTask({required Task task}) async {
    return await DBHelper.insert(task);
  }

  void getTask() async {
    List<Map<String, dynamic>> tasks = await DBHelper.query();
    taskList.assignAll(tasks.map((e) => Task.fromMap(e)).toList());
  }

  void delete(Task task) async {
    var val = await DBHelper.delete(task);
    print(val);
    if (val == 1) {
      taskList.remove(task);
    }
  }
}
