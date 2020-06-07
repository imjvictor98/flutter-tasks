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

  @computed
  int get amountTasks {
    return tasks.length;
  }
  
}