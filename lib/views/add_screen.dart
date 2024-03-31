import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/configs/utils.dart';
import 'package:todo_app/providers/task_provider.dart';
import 'package:todo_app/views/home_screen.dart';

import '../widgets/form_input.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void validateForm() {
    if (formKey.currentState!.validate()) {
      context.navToview(const HomeScreen());
      context.read<TaskProvider>().addTask(
            title: titleController.text,
            description: descriptionController.text,
          );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          duration: Duration(milliseconds: 500),
          content: Text('Task added'),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          duration: Duration(milliseconds: 500),
          content: Text('Veuillez bien remplir le formulaire'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add Task",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: context.surface,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SvgPicture.asset(
              "assets/add_task.svg",
              width: 185,
            ),
            Form(
              key: formKey,
              child: Column(
                children: [
                  FormInput(
                    hintText: "Title",
                    controller: titleController,
                  ),
                  const Gap(20),
                  FormInput(
                    hintText: "Description",
                    controller: descriptionController,
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () => validateForm(),
              style: ElevatedButton.styleFrom(
                fixedSize: Size(
                  context.width * 0.8,
                  60,
                ),
                backgroundColor: context.primary,
                textStyle: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xfff3f3f7),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    10,
                  ),
                ),
              ),
              child: const Text(
                "Soumettre",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
