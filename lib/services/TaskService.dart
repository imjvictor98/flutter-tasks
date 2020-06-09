
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:task/models/Task/task.dart';
import 'package:task/stores/task/task_store.dart';
import 'package:task/utils/date_time_form.dart';

class TaskService {
  
  final TaskStore taskStore;
  SharedPreferences _preferences;

  TaskService(this.taskStore){
    SharedPreferences.getInstance().then((value){
      _preferences = value;
    });
  }

  Future<List<Task>> getTasks() {
    return Future.value(taskStore.tasks);
  }

  Future<Task> saveTask(Task task) {
    taskStore.addTask(task);
    
    return Future.value(task);
  }

  Future<Task> deleteTask(Task task) {
    taskStore.removeTask(task);
    
    return Future.value(task);
  }

  setDone(int id) async {
    var gt = taskStore.tasks.singleWhere((element) => (element.id == id));
    
    gt.done = !gt.done;

    print(gt.done);

    var index = taskStore.tasks.lastIndexOf(gt);

    taskStore.tasks[index] = gt;

    saveTasksList();

  }

  Future<Task> editTask(Task task) async {
    var f = taskStore.tasks.singleWhere((element) => (element.id == task.id));

    var index = taskStore.tasks.lastIndexOf(f);

    taskStore.tasks[index] = task;

    saveTasksList();
    
    return Future.value(task);

  }

  Future<void> saveTasksList() async {
    List<Task> tasks = taskStore.tasks;

    final String encodedData = encodeTasks(tasks);

    _preferences.setString("tasklist", encodedData);    

    print("Salvo");
  }

  Future<List<Task>> getTasksList() async {
      final List<Task> decodedData = decodeTasks(_preferences.getString("tasklist"));

      print(decodedData[0].title);

      taskStore.setTasks(decodedData);
    
      return Future.value(decodedData);
  }

  Task fromJson(Map<String, dynamic> jsonData) {
    return Task(
      id: jsonData['id'],
      title: jsonData['title'],
      description: jsonData['description'],
      deadLine: dateFromJson(jsonData['deadLine']),
      done: jsonData['done'],
    );
  }

  Map<String, Object> toMap(Task task) => {
    'id': task.id,
    'title': task.title,
    'description': task.description,
    'deadLine': task.deadLine.toIso8601String(),
    'done': task.done
  };

  String encodeTasks(List<Task> tasks) => json.encode(    
    tasks
    .map<Map<String, dynamic>>((task) => toMap(task))    
    .toList(),
  );

  List<Task> decodeTasks(String tasks) =>
    (json.decode(tasks) as List<dynamic>)
    .map<Task>((item) => fromJson(item))
    .toList();

  
  void dispose() {
    
  }
}