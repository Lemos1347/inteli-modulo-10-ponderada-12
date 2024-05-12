import 'package:flutter/material.dart';
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
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => TasksScreen()),
            );
          },
          child: Text("Ir para Tarefas"),
        ),
      ),
    );
  }
}
