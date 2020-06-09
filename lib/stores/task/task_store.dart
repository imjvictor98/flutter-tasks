import 'package:mobx/mobx.dart';
import 'package:task/models/Task/task.dart';
import 'package:flutter/foundation.dart';

part 'task_store.g.dart';

class TaskStore = _TaskStore with _$TaskStore;

abstract class _TaskStore with Store {

  @observable
  ObservableList<Task> tasks = List<Task>().asObservable();

  @action
  addTask(Task task) {
    tasks.add(task);
  }

  @action
  setTasks(List<Task> t) {
    this.tasks = t.asObservable();
  }

  @action
  removeTask(Task task) {
    tasks.remove(task);
  }

  @action editTask(Task task) {
    var index = tasks.indexOf(task);
    tasks[index] = task;
  }

  @computed
  int get amountTasks {
    return tasks.length;
  }
  
}