
import 'package:task/models/Task/task.dart';
import 'package:task/stores/task/task_store.dart';

class TaskService {
  
  final TaskStore taskStore;

  TaskService(this.taskStore);

  Future<List<Task>> getTasks() {
    return Future.value(taskStore.tasks);
  }

  Future<Task> saveTask(Task task) {
    taskStore.addTask(task);
    
    return Future.value(task);
  }

  void dispose() {
    
  }
}