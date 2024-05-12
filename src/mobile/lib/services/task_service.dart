import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/task.dart';

class TaskService {
  final String baseUrl = 'http://192.168.15.46:3001';

  Future<List<Task>> fetchTasks() async {
    final response = await http.get(Uri.parse('$baseUrl/tasks'),
        headers: {'Authorization': '03fd5486-2030-47cf-bf14-0e569d64fad9'});
    print(response);
    if (response.statusCode == 200) {
      final Map<String, dynamic> parsed = json.decode(response.body);
      List<dynamic> tasksJson = parsed['tasks'];
      return tasksJson.map((json) => Task.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load tasks');
    }
  }

  Future<void> addTask(Task task) async {
    await http.post(
      Uri.parse('$baseUrl/create_task'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': '03fd5486-2030-47cf-bf14-0e569d64fad9'
      },
      body: json.encode({"task": task.text}),
    );
  }

  Future<void> deleteTask(String id) async {
    await http.delete(
      Uri.parse('$baseUrl/delete_task'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': '03fd5486-2030-47cf-bf14-0e569d64fad9'
      },
      body: json.encode({"task_id": id}),
    );
  }

  Future<void> updateTask(Task task) async {
    await http.put(
      Uri.parse('$baseUrl/update_task'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': '03fd5486-2030-47cf-bf14-0e569d64fad9'
      },
      body: json.encode({"task_id": task.id, "status": task.status}),
    );
  }
}
