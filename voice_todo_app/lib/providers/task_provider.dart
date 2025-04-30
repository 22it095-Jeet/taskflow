import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/task.dart';

final taskProvider = StateNotifierProvider<TaskNotifier, List<Task>>((ref) {
  return TaskNotifier();
});

class TaskNotifier extends StateNotifier<List<Task>> {
  TaskNotifier() : super([]) {
    _loadTasks();
  }

  final _box = Hive.box('tasks');

  Future<void> _loadTasks() async {
    final tasks = _box.values.map((e) => e as Task).toList();
    state = tasks;
  }

  Future<void> addTask(String title) async {
    final task = Task(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      createdAt: DateTime.now(),
    );
    await _box.put(task.id, task);
    state = [...state, task];
  }

  Future<void> toggleTask(String id) async {
    final taskIndex = state.indexWhere((task) => task.id == id);
    if (taskIndex != -1) {
      final task = state[taskIndex];
      final updatedTask = task.copyWith(
        isCompleted: !task.isCompleted,
        completedAt: !task.isCompleted ? DateTime.now() : null,
      );
      await _box.put(id, updatedTask);
      state = [
        ...state.sublist(0, taskIndex),
        updatedTask,
        ...state.sublist(taskIndex + 1),
      ];
    }
  }

  Future<void> deleteTask(String id) async {
    await _box.delete(id);
    state = state.where((task) => task.id != id).toList();
  }
} 