import 'package:taskmanager/app/data/models/task.dart';
import 'package:taskmanager/app/data/providers/task/provider.dart';

class TaskRepository{
  TaskProvider taskProvider;
  TaskRepository({required this.taskProvider});

  List<Task> readTasks() => taskProvider.readTasks();
  void writeTasks(List<Task> tasks) => taskProvider.writeTasks(tasks);
}