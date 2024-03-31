import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/configs/utils.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/providers/task_provider.dart';

class TaskDetails extends StatefulWidget {
  const TaskDetails({
    super.key,
    required this.id,
  });

  final String id;

  @override
  State<TaskDetails> createState() => _TaskDetailsState();
}

class _TaskDetailsState extends State<TaskDetails> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Task(
      :title,
      :description,
      // :isCompleted,
      :createdAt,
    ) = context.watch<TaskProvider>().tasks[int.parse(widget.id) - 1];

    return Material(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Details",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          leading: IconButton(
            onPressed: () {
              context.navBack();
            },
            icon: const Icon(
              Icons.arrow_back_rounded,
              size: 30,
              color: Colors.white,
            ),
          ),
          backgroundColor: context.primary,
          elevation: 0,
        ),
        body: Container(
          color: const Color(0xFFF6F6F6),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                child: Column(
                  children: [
                    Container(
                      height: context.width * 0.30,
                      decoration: BoxDecoration(color: context.primary),
                    ),
                    Expanded(
                      child: Container(
                        decoration:
                            const BoxDecoration(color: Color(0xFFF6F6F6)),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: context.height * 0.075,
                child: Container(
                  width: context.width * 0.85,
                  height: context.height * 0.14,
                  decoration: const BoxDecoration(
                    // color: Colors.amber,
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: context.width * 0.022,
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 170, 155, 243),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(context.width * 0.03),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              width: context.width * 0.5,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Icon(
                                        Icons.access_time,
                                        size: 22,
                                        color: const Color(0xFF0F071A)
                                            .withOpacity(0.2),
                                      ),
                                      Gap(context.width * 0.011),
                                      Text(
                                        context
                                            .formatTime(createdAt)
                                            .toString(),
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: const Color(0xFF0F071A)
                                              .withOpacity(0.2),
                                        ),
                                      ),
                                      Gap(context.width * 0.035),
                                      Icon(
                                        Icons.calendar_month,
                                        size: 22,
                                        color: const Color(0xFF0F071A)
                                            .withOpacity(0.2),
                                      ),
                                      Gap(context.width * 0.011),
                                      Text(
                                        context
                                            .formatDate(createdAt)
                                            .toString(),
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: const Color(0xFF0F071A)
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
                      Gap(context.width * 0.1),
                      IconButton(
                        onPressed: () {},
                        color: context.primary,
                        icon: DecoratedBox(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: context.primary.withOpacity(0.15),
                          ),
                          child: const Icon(
                            Icons.keyboard_arrow_down,
                            size: 33,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: context.width * 0.455,
                child: SizedBox(
                  height: context.height * 0.58,
                  width: context.width * 0.84,
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    children: [
                      Container(
                        height: context.height * 0.58,
                        width: context.width * 0.84,
                        padding: EdgeInsets.all(context.height * 0.02),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Text(
                          description,
                          style: TextStyle(
                            color: const Color(0xFF0F071A).withOpacity(0.4),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
