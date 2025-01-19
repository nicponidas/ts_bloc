import 'package:flutter/material.dart';
import 'package:time_sheet/dummy_data/dummy_data.dart';
import 'package:time_sheet/models/task_model.dart';
import 'package:time_sheet/widgets/tasks_list.dart';

class TasksListPage extends StatelessWidget {
  const TasksListPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<TaskModel> tasks = listOfTask;
    tasks.sort((elt1, elt2) => elt2.timeStart.compareTo(elt1.timeStart));
    return Scaffold(
      appBar: AppBar(
        title: Text('Tasks'),
      ),
      body: TasksList(
        tasks: tasks,
      ),
      floatingActionButton: IconButton.filledTonal(
        onPressed: () {},
        icon: const Icon(Icons.add),
      ),
    );
  }
}
