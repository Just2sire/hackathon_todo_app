import 'package:flutter/material.dart';
import 'package:todo_app/configs/utils.dart';

class TaskStat extends StatelessWidget {
  final int number;
  final String type;
  const TaskStat({
    super.key,
    required this.number,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width * 0.44,
      padding: EdgeInsets.symmetric(
        vertical: context.width * 0.02,
        horizontal: context.width * 0.03,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(7),
      ),
      child: Column(
        children: [
          Text(
            "$number",
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            type,
            style: TextStyle(
              fontSize: 17,
              color: const Color(0xFF0F071A).withOpacity(0.3),
            ),
          ),
        ],
      ),
    );
  }
}
