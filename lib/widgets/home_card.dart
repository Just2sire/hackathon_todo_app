import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/configs/utils.dart';
import 'package:todo_app/providers/task_provider.dart';
import 'package:todo_app/widgets/loading_animation.dart';

class HomeCard extends StatelessWidget {
  const HomeCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dataProvider = context.watch<TaskProvider>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Pending Tasks",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFFF6F6F6),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 6,
                  height: 6,
                  decoration: const BoxDecoration(
                    color: Color(0xFFF6F6F6),
                    shape: BoxShape.circle,
                  ),
                ),
                Gap(context.width * 0.02),
                Text(
                  "All ${dataProvider.tasks.length}",
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFFF6F6F6),
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 6,
                  height: 6,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFFC804),
                    shape: BoxShape.circle,
                  ),
                ),
                Gap(context.width * 0.02),
                Text(
                  "Done ${dataProvider.taskCompletedLength}",
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFFF6F6F6),
                  ),
                ),
              ],
            ),
          ],
        ),
        LoadingCircle(
          percent: dataProvider.taskPercent.isNaN ? 0 : dataProvider.taskPercent,
          progressColor: context.tertiary,
          size: 100,
          strokeWidth: 15,
          backgroundColor: Colors.white,
          content: Text(
            dataProvider.taskPercent.isNaN ? "0%" : "${(dataProvider.taskPercent * 100).toStringAsFixed(0)}%",
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
