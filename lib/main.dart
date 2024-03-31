import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/configs/theme.dart';
import 'package:todo_app/providers/task_provider.dart';
// import 'package:todo_app/repositories/api_task_repository.dart';
import 'package:todo_app/services/sqlite_service.dart';
import 'package:todo_app/views/splash_screen.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => TaskProvider(
          taskRepository: SqliteService(),
        ),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeClass.lightTheme,
      home: const SplashScreen(),
    );
  }
}
