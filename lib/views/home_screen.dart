import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/configs/utils.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/providers/task_provider.dart';
import 'package:todo_app/views/add_screen.dart';
import 'package:todo_app/views/tasks_screen.dart';

import '../widgets/home_card.dart';
import '../widgets/task_item.dart';
import '../widgets/task_stat.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final dataProvider = context.watch<TaskProvider>();
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Color(0xFFF6F6F6),
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.dark,
        ),
        elevation: 0.0,
        backgroundColor: const Color(0xFFF6F6F6),
        leading: Container(
          margin: EdgeInsets.all(context.width * 0.02),
          child: const CircleAvatar(
            backgroundImage: AssetImage("assets/user.png"),
          ),
        ),
        title: const Text(
          "Bonne arrivée !👋",
          style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          color: const Color(0xFFF6F6F6),
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 20,
          ),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: context.height * 0.20,
                padding: EdgeInsets.symmetric(
                  vertical: context.height * 0.02,
                  horizontal: context.width * 0.06,
                ),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF6854d1),
                      Color(0xFF9581FF),
                    ],
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(7),
                  ),
                ),
                child: const HomeCard(),
              ),
              Gap(context.height * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TaskStat(
                    number: dataProvider.taskCompletedLength,
                    type: "Completed Task",
                  ),
                  TaskStat(
                    number: dataProvider.taskUncompletedLength,
                    type: "Pending Task",
                  ),
                ],
              ),
              const Gap(20),
              SizedBox(
                height: context.height * 0.51,
                width: context.width * 0.9,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Tasks",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => context.navToview(const TasksScreen()),
                          child: Text(
                            "View all",
                            style: TextStyle(
                              fontSize: 13,
                              color: const Color(0xFF0F071A).withOpacity(0.3),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Gap(5),
                    Expanded(
                      child: ListView.separated(
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          Task task = dataProvider.tasks[index];
                          // Task task = tasks[index];
                          return TaskItem(
                            task: task,
                          );
                        },
                        separatorBuilder: (context, index) => const Gap(10),
                        itemCount: dataProvider.tasks.length >= 5 ? 5 : dataProvider.tasks.length,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: context.primary,
        onPressed: () {
          context.navToview(const AddScreen());
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 32,
        ),
      ),
    );
  }
}
