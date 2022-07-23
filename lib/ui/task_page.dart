import 'dart:developer';

import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:task_schedular/controllers/task_controller.dart';
import 'package:task_schedular/models/task.dart';
import 'package:task_schedular/ui/widgets/task_tile.dart';
import '../services/notification_services.dart';
import 'add_task_page.dart';
import 'widgets/button.dart';
import '../utils/theme.dart';
import '../services/theme_services.dart';

class TaskView extends StatefulWidget {
  const TaskView({Key? key}) : super(key: key);

  @override
  State<TaskView> createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  late NotifyHelper notifyHelper;
  final TaskController _taskController = Get.put(TaskController());
  DateTime _selectedDate = DateTime.now();
  @override
  void initState() {
    super.initState();
    notifyHelper = NotifyHelper();
    notifyHelper.initializeNotification();
    notifyHelper.requestIOSPermissions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: _appBar(),
      body: Column(
        children: [
          _addTaskBar(),
          _addDateBar(),
          SizedBox(
            height: 10,
          ),
          _showTasks(),
        ],
      ),
    );
  }

  _showTasks() {
    return Expanded(
      child: Obx(
        () {
          return ListView.builder(
            itemCount: _taskController.taskList.length,
            itemBuilder: (context, index) {
              print(_taskController.taskList.length.toString());
              var taskList = _taskController.taskList[index];
              return AnimationConfiguration.staggeredList(
                position: index,
                child: SlideAnimation(
                  child: FadeInAnimation(
                      child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          _showBottomSheet(context, taskList);
                        },
                        child: TaskTile(taskList),
                      )
                    ],
                  )),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Container _addDateBar() {
    return Container(
      margin: EdgeInsets.only(top: 20, left: 20),
      child: DatePicker(
        DateTime.now(),
        height: 100,
        width: 80,
        initialSelectedDate: DateTime.now(),
        selectionColor: primaryColor,
        dateTextStyle: GoogleFonts.lato(
          textStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.grey,
          ),
        ),
        dayTextStyle: GoogleFonts.lato(
          textStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.grey,
          ),
        ),
        monthTextStyle: GoogleFonts.lato(
          textStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.grey,
          ),
        ),
        selectedTextColor: Colors.white,
        onDateChange: (selectedDate) => _selectedDate = selectedDate,
      ),
    );
  }

  Container _addTaskBar() {
    return Container(
      margin: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat.yMMMMd().format(DateTime.now()),
                style: subHeadingStyle,
              ),
              Text(
                'Today',
                style: headingStyle,
              ),
            ],
          ),
          MyButton(
            label: '+ Add Task',
            onTap: () async {
              await Get.to(() => AddTaskPage());
              _taskController.getTask();
            },
          ),
        ],
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: context.theme.backgroundColor,
      leading: GestureDetector(
        onTap: () {
          ThemeService().switchTheme();
          notifyHelper.displayNotification(
            title: 'Theme Changed',
            body: !Get.isDarkMode
                ? 'Activated Dark Theme'
                : 'Activated Light Theme',
          );
          // notifyHelper.scheduledNotification();
        },
        child: Icon(
          !Get.isDarkMode ? Icons.nightlight_outlined : Icons.wb_sunny_outlined,
          size: 20,
          color: Get.isDarkMode ? Colors.white : Colors.black,
        ),
      ),
      actions: [
        CircleAvatar(
          backgroundColor: Colors.red,
        ),
        const SizedBox(width: 20),
      ],
    );
  }

  void _showBottomSheet(BuildContext context, Task task) {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.only(top: 4),
        height: task.isCompleted == 1
            ? MediaQuery.of(context).size.height * 0.24
            : MediaQuery.of(context).size.height * 0.32,
        color: Get.isDarkMode ? darkGreyColor : Colors.white,
        child: Column(
          children: [
            Container(
              height: 6,
              width: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Get.isDarkMode
                    ? Colors.grey.shade600
                    : Colors.grey.shade300,
              ),
            ),
            task.isCompleted == 1
                ? Container()
                : _bottomButton(
                    label: "Task Completed",
                    onTap: () {
                      Get.back();
                    },
                    color: primaryColor,
                    context: context),
          ],
        ),
      ),
    );
  }

  _bottomButton(
      {required String label,
      required Function()? onTap,
      required Color color,
      required BuildContext context,
      bool isClose = false}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        height: 55,
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
          color: isClose == true ? Colors.red : color,
          border: Border.all(
            color: isClose == true ? Colors.red : color,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
