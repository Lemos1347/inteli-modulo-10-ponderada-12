import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/task_bloc.dart';
import 'tasks_screen.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bem-Vindo"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Continua capturando o TaskBloc antes de usar o Navigator
            final taskBloc = BlocProvider.of<TaskBloc>(context, listen: false);

            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => BlocProvider.value(
                  value: taskBloc,
                  child: TasksScreen(),
                ),
              ),
            );
          },
          child: Text("Ir para Tarefas"),
        ),
      ),
    );
  }
}
