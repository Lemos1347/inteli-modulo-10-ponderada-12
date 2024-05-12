import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/task_bloc.dart';
import '../blocs/task_event.dart';
import '../blocs/task_state.dart';
import '../models/task.dart';

class TasksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gerenciador de Tarefas'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _showAddEditTaskDialog(context),
          ),
        ],
      ),
      body: BlocBuilder<TaskBloc, TaskState>(
        builder: (context, state) {
          if (state is TasksLoadInProgress) {
            BlocProvider.of<TaskBloc>(context).add(LoadTasks());
            return Center(child: CircularProgressIndicator());
          } else if (state is TasksLoadSuccess) {
            if (state.tasks.isEmpty) {
              return Center(
                  child: Text('Nenhuma tarefa disponível. Adicione uma!'));
            }
            return ListView.builder(
              itemCount: state.tasks.length,
              itemBuilder: (context, index) {
                return _taskItem(context, state.tasks[index]);
              },
            );
          } else {
            return Center(child: Text('Falha ao carregar tarefas'));
          }
        },
      ),
    );
  }

  Widget _taskItem(BuildContext context, Task task) {
    return ListTile(
      title: Text(task.text),
      subtitle: Text(task.status),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () => _showAddEditTaskDialog(context, task: task),
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () => _deleteTask(context, task.id),
          ),
        ],
      ),
    );
  }

  void _deleteTask(BuildContext context, String taskId) {
    BlocProvider.of<TaskBloc>(context).add(DeleteTask(taskId));
  }

  void _showAddEditTaskDialog(BuildContext context, {Task? task}) {
    final _titleController = TextEditingController(text: task?.text ?? '');
    final _descriptionController =
        TextEditingController(text: task?.status ?? '');

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(task == null ? 'Adicionar Tarefa' : 'Editar Tarefa'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Tarefa'),
              ),
              TextField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Status'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            child: Text('Cancelar'),
            onPressed: () => Navigator.of(dialogContext).pop(),
          ),
          TextButton(
            child: Text('Salvar'),
            onPressed: () {
              final text = _titleController.text;
              final status = _descriptionController.text;
              final updatedTask = Task(
                  id: task?.id ?? "akjdsbadjk", text: text, status: status);

              // Use `context` instead of `dialogContext` to access the TaskBloc
              BlocProvider.of<TaskBloc>(context).add(task == null
                  ? AddTask(updatedTask)
                  : UpdateTask(updatedTask));

              Navigator.of(dialogContext).pop();
            },
          ),
        ],
      ),
    );
  }
}
