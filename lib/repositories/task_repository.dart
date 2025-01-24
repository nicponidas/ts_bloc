import 'package:time_sheet/dummy_data/dummy_data.dart';
import 'package:time_sheet/models/task_model.dart';

class TaskRepository {
  final List<TaskModel> _tasks = listOfTask;

  Future<List<TaskModel>> getTasks() async => _tasks..sort((elt1, elt2) => elt2.timeStart.compareTo(elt1.timeStart));

  void addTask(TaskModel task) => _tasks.add(task);

  void removeTask(TaskModel task) => _tasks.remove(task);

  void updateTask(TaskModel task) {
    final index = _tasks.indexWhere((element) => element.id == task.id);
    if (index != -1) {
      _tasks[index] = task;
    }
  }
}
