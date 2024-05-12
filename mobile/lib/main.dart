import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'screens/welcome_screen.dart';
import 'blocs/task_bloc.dart';
import 'services/task_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: BlocProvider(
        create: (context) => TaskBloc(taskService: TaskService()),
        child: WelcomeScreen(),
      ),
    );
  }
}
