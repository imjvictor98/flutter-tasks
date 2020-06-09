// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$TaskStore on _TaskStore, Store {
  Computed<int> _$amountTasksComputed;

  @override
  int get amountTasks =>
      (_$amountTasksComputed ??= Computed<int>(() => super.amountTasks)).value;

  final _$tasksAtom = Atom(name: '_TaskStore.tasks');

  @override
  ObservableList<Task> get tasks {
    _$tasksAtom.context.enforceReadPolicy(_$tasksAtom);
    _$tasksAtom.reportObserved();
    return super.tasks;
  }

  @override
  set tasks(ObservableList<Task> value) {
    _$tasksAtom.context.conditionallyRunInAction(() {
      super.tasks = value;
      _$tasksAtom.reportChanged();
    }, _$tasksAtom, name: '${_$tasksAtom.name}_set');
  }

  final _$_TaskStoreActionController = ActionController(name: '_TaskStore');

  @override
  dynamic addTask(Task task) {
    final _$actionInfo = _$_TaskStoreActionController.startAction();
    try {
      return super.addTask(task);
    } finally {
      _$_TaskStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setTasks(List<Task> t) {
    final _$actionInfo = _$_TaskStoreActionController.startAction();
    try {
      return super.setTasks(t);
    } finally {
      _$_TaskStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic removeTask(Task task) {
    final _$actionInfo = _$_TaskStoreActionController.startAction();
    try {
      return super.removeTask(task);
    } finally {
      _$_TaskStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic editTask(Task task) {
    final _$actionInfo = _$_TaskStoreActionController.startAction();
    try {
      return super.editTask(task);
    } finally {
      _$_TaskStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'tasks: ${tasks.toString()},amountTasks: ${amountTasks.toString()}';
    return '{$string}';
  }
}
