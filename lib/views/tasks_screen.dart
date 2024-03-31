import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/configs/utils.dart';
import 'package:todo_app/models/task.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_app/providers/task_provider.dart';
import 'package:todo_app/views/task_details.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  @override
  void initState() {
    super.initState();
  }

  String parseStringData(String data) {
    String res = data;
    if (data.length > 40) {
      res = "${data.substring(0, 40)}...";
    }
    return res;
  }

  @override
  Widget build(BuildContext context) {
    final dataProvider = context.watch<TaskProvider>();

    return DefaultTabController(
      length: 3,
      animationDuration: const Duration(milliseconds: 600),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Personal Tasks",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          leading: IconButton(
            onPressed: () => context.navBack(),
            icon: const Icon(
              Icons.arrow_back_rounded,
              size: 30,
              color: Colors.white,
            ),
          ),
          backgroundColor: context.primary,
          bottom: const TabBar(
            indicatorColor: Colors.white,
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: [
              Tab(
                child: Text(
                  "All",
                  style: TextStyle(fontSize: 17, color: Colors.white),
                ),
              ),
              Tab(
                child: Text(
                  "In Progress",
                  style: TextStyle(fontSize: 17, color: Colors.white),
                ),
              ),
              Tab(
                child: Text(
                  "Done",
                  style: TextStyle(fontSize: 17, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: context.height * 0.03),
              child: ListView.builder(
                // itemCount: taskDone.length,
                itemCount: dataProvider.tasks.length,
                itemBuilder: (context, index) {
                  final Task(
                    :id,
                    :title,
                    :description,
                    :author,
                    :createdAt,
                  ) = dataProvider.tasks[index];
                  return GestureDetector(
                    onTap: () => context.navToview(
                      TaskDetails(
                        id: id!,
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: context.width * 0.04,
                        right: context.width * 0.04,
                        top: index == 0 ? 0 : context.height * 0.03,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Slidable(
                            endActionPane: ActionPane(
                              motion: const ScrollMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: (context) {
                                    setState(() {
                                      context
                                          .read<TaskProvider>()
                                          .notComplete(id!);
                                    });
                                  },
                                  label: "Progress",
                                  foregroundColor:
                                      const Color(0xFF0F071A).withOpacity(0.4),
                                  backgroundColor:
                                      context.primary.withOpacity(0.3),
                                  borderRadius: const BorderRadius.horizontal(
                                    right: Radius.circular(3),
                                  ),
                                ),
                                SlidableAction(
                                  onPressed: (context) {
                                    setState(() {
                                      context
                                          .read<TaskProvider>()
                                          .complete(id!);
                                    });
                                  },
                                  label: "Done",
                                  foregroundColor:
                                      const Color(0xFF0F071A).withOpacity(0.4),
                                  borderRadius: const BorderRadius.horizontal(
                                    right: Radius.circular(3),
                                  ),
                                  backgroundColor:
                                      const Color(0xFF0F071A).withOpacity(0.1),
                                ),
                              ],
                            ),
                            child: Container(
                              width: context.width * 0.97,
                              height: context.height * 0.18,
                              decoration: const BoxDecoration(
                                // color: Colors.amber,
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: context.width * 0.022,
                                    decoration: BoxDecoration(
                                      color: context.primary,
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        bottomLeft: Radius.circular(10),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.all(context.width * 0.03),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          title,
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          parseStringData(description),
                                          maxLines: 2,
                                          overflow: TextOverflow
                                              .fade, // Ajoutez ceci pour montrer "..." en cas de coupure
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: const Color(0xFF0F071A)
                                                .withOpacity(0.3),
                                          ),
                                        ),
                                        SizedBox(
                                          width: context.width * 0.75,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                author,
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  color: const Color(0xFF0F071A)
                                                      .withOpacity(0.2),
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Icon(
                                                    Icons.access_time,
                                                    size: 22,
                                                    color:
                                                        const Color(0xFF0F071A)
                                                            .withOpacity(0.2),
                                                  ),
                                                  Gap(context.width * 0.011),
                                                  Text(
                                                    context
                                                        .formatTime(createdAt)
                                                        .toString(),
                                                    style: TextStyle(
                                                      fontSize: 13,
                                                      color: const Color(
                                                              0xFF0F071A)
                                                          .withOpacity(0.2),
                                                    ),
                                                  ),
                                                  Gap(context.width * 0.035),
                                                  Icon(
                                                    Icons.calendar_month,
                                                    size: 22,
                                                    color:
                                                        const Color(0xFF0F071A)
                                                            .withOpacity(0.2),
                                                  ),
                                                  Gap(context.width * 0.011),
                                                  Text(
                                                    context
                                                        .formatDate(createdAt)
                                                        .toString(),
                                                    style: TextStyle(
                                                      fontSize: 13,
                                                      color: const Color(
                                                              0xFF0F071A)
                                                          .withOpacity(0.2),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: context.height * 0.03),
              child: ListView.builder(
                itemCount: dataProvider.taskUncompleted.length,
                itemBuilder: (context, index) {
                  final Task(
                    :id,
                    :title,
                    :description,
                    :author,
                    :createdAt,
                  ) = dataProvider.taskUncompleted[index];

                  return GestureDetector(
                    onTap: () => context.navToview(
                      TaskDetails(
                        id: id!,
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: context.width * 0.04,
                        right: context.width * 0.04,
                        top: index == 0 ? 0 : context.height * 0.03,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Slidable(
                            endActionPane: ActionPane(
                              motion: const ScrollMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: (context) {
                                    setState(() {
                                      context
                                          .read<TaskProvider>()
                                          .complete(id!);
                                    });
                                  },
                                  label: "Done",
                                  foregroundColor:
                                      const Color(0xFF0F071A).withOpacity(0.4),
                                  borderRadius: const BorderRadius.horizontal(
                                    right: Radius.circular(3),
                                  ),
                                  backgroundColor:
                                      const Color(0xFF0F071A).withOpacity(0.1),
                                ),
                              ],
                            ),
                            child: Container(
                              width: context.width * 0.97,
                              height: context.height * 0.18,
                              decoration: const BoxDecoration(
                                // color: Colors.amber,
                                color: Colors.white,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: context.width * 0.022,
                                    decoration: BoxDecoration(
                                      color: context.primary,
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        bottomLeft: Radius.circular(10),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.all(context.width * 0.03),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          title,
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          parseStringData(description),
                                          maxLines: 2,
                                          overflow: TextOverflow
                                              .fade, // Ajoutez ceci pour montrer "..." en cas de coupure
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: const Color(0xFF0F071A)
                                                .withOpacity(0.3),
                                          ),
                                        ),
                                        SizedBox(
                                          width: context.width * 0.75,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                author,
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  color: const Color(0xFF0F071A)
                                                      .withOpacity(0.2),
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Icon(
                                                    Icons.access_time,
                                                    size: 22,
                                                    color:
                                                        const Color(0xFF0F071A)
                                                            .withOpacity(0.2),
                                                  ),
                                                  Gap(context.width * 0.011),
                                                  Text(
                                                    context
                                                        .formatTime(createdAt)
                                                        .toString(),
                                                    style: TextStyle(
                                                      fontSize: 13,
                                                      color: const Color(
                                                              0xFF0F071A)
                                                          .withOpacity(0.2),
                                                    ),
                                                  ),
                                                  Gap(context.width * 0.035),
                                                  Icon(
                                                    Icons.calendar_month,
                                                    size: 22,
                                                    color:
                                                        const Color(0xFF0F071A)
                                                            .withOpacity(0.2),
                                                  ),
                                                  Gap(context.width * 0.011),
                                                  Text(
                                                    context
                                                        .formatDate(
                                                          createdAt,
                                                        )
                                                        .toString(),
                                                    style: TextStyle(
                                                      fontSize: 13,
                                                      color: const Color(
                                                              0xFF0F071A)
                                                          .withOpacity(0.2),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: context.height * 0.03),
              child: ListView.builder(
                itemCount: dataProvider.taskCompleted.length,
                itemBuilder: (context, index) {
                  final Task(
                    :id,
                    :title,
                    :description,
                    :author,
                    :createdAt,
                  ) = dataProvider.taskCompleted[index];
                  return GestureDetector(
                    onTap: () => context.navToview(
                      TaskDetails(
                        id: id!,
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: context.width * 0.04,
                        right: context.width * 0.04,
                        top: index == 0 ? 0 : 15,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Slidable(
                            endActionPane: ActionPane(
                              motion: const ScrollMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: (context) {
                                    setState(() {
                                      context
                                          .read<TaskProvider>()
                                          .notComplete(id!);
                                    });
                                  },
                                  label: "Progress",
                                  foregroundColor:
                                      const Color(0xFF0F071A).withOpacity(0.4),
                                  backgroundColor:
                                      context.primary.withOpacity(0.3),
                                  borderRadius: const BorderRadius.horizontal(
                                    right: Radius.circular(3),
                                  ),
                                ),
                              ],
                            ),
                            child: Container(
                              width: context.width * 0.97,
                              height: context.height * 0.18,
                              decoration: const BoxDecoration(
                                // color: Colors.amber,
                                color: Colors.white,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: context.width * 0.022,
                                    decoration: BoxDecoration(
                                      color: context.primary,
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        bottomLeft: Radius.circular(10),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.all(context.width * 0.03),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          title,
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          parseStringData(description),
                                          maxLines: 2,
                                          overflow: TextOverflow
                                              .fade, // Ajoutez ceci pour montrer "..." en cas de coupure
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: const Color(0xFF0F071A)
                                                .withOpacity(0.3),
                                          ),
                                        ),
                                        SizedBox(
                                          width: context.width * 0.75,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                author,
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  color: const Color(0xFF0F071A)
                                                      .withOpacity(0.2),
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Icon(
                                                    Icons.access_time,
                                                    size: 22,
                                                    color:
                                                        const Color(0xFF0F071A)
                                                            .withOpacity(0.2),
                                                  ),
                                                  Gap(context.width * 0.011),
                                                  Text(
                                                    context
                                                        .formatTime(createdAt)
                                                        .toString(),
                                                    style: TextStyle(
                                                      fontSize: 13,
                                                      color: const Color(
                                                              0xFF0F071A)
                                                          .withOpacity(0.2),
                                                    ),
                                                  ),
                                                  Gap(context.width * 0.035),
                                                  Icon(
                                                    Icons.calendar_month,
                                                    size: 22,
                                                    color:
                                                        const Color(0xFF0F071A)
                                                            .withOpacity(0.2),
                                                  ),
                                                  Gap(context.width * 0.011),
                                                  Text(
                                                    context
                                                        .formatDate(createdAt)
                                                        .toString(),
                                                    style: TextStyle(
                                                      fontSize: 13,
                                                      color: const Color(
                                                              0xFF0F071A)
                                                          .withOpacity(0.2),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
