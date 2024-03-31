import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:todo_app/configs/utils.dart';
import 'package:todo_app/models/task.dart';

class TaskItem extends StatelessWidget {
  final Task task;
  const TaskItem({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width * 0.84,
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
            decoration: const BoxDecoration(
              color: Color(0xFF9581FF),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(context.width * 0.03),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task.title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  task.description.length < 40
                      ? task.description
                      : "${task.description.substring(0, 40)} ...",
                  maxLines: 2,
                  overflow: TextOverflow.fade, // Ajoutez ceci pour montrer "..." en cas de coupure
                  style: TextStyle(
                    fontSize: 13,
                    color: const Color(0xFF0F071A).withOpacity(0.3),
                  ),
                ),
                SizedBox(
                  width: context.width * 0.75,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        // personalTasks[index].author,
                        "Moi",
                        style: TextStyle(
                          fontSize: 10,
                          color: const Color(0xFF0F071A).withOpacity(0.2),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.access_time,
                            size: 22,
                            color: const Color(0xFF0F071A).withOpacity(0.2),
                          ),
                          Gap(context.width * 0.011),
                          Text(
                            context.formatTime(task.createdAt).toString(),
                            style: TextStyle(
                              fontSize: 13,
                              color: const Color(0xFF0F071A).withOpacity(0.2),
                            ),
                          ),
                          Gap(context.width * 0.035),
                          Icon(
                            Icons.calendar_month,
                            size: 22,
                            color: const Color(0xFF0F071A).withOpacity(0.2),
                          ),
                          Gap(context.width * 0.011),
                          Text(
                            context.formatDate(task.createdAt).toString(),
                            style: TextStyle(
                              fontSize: 13,
                              color: const Color(0xFF0F071A).withOpacity(0.2),
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
    );
  }
}
