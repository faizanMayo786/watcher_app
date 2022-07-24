import 'package:get/get.dart';
import '../db/db_helper.dart';
import '../models/task.dart';

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
    if (val == 1) {
      taskList.remove(task);
    }
  }

  markTaskCompleted(Task task) async {
    int val = await DBHelper.update(task.id!);
    if (val == 1) {
      taskList[taskList.indexWhere((element) => element.id == task.id)] = Task(
        id: task.id,
        title: task.title,
        note: task.note,
        date: task.date,
        startTime: task.startTime,
        endTime: task.endTime,
        repeat: task.repeat,
        isCompleted: 1,
        color: task.color,
        remind: task.remind,
      );
    }
  }
}
