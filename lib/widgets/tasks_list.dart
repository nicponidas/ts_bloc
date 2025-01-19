import 'package:flutter/material.dart';
import 'package:time_sheet/models/task_model.dart';
import 'package:time_sheet/widgets/task_tile.dart';

class TasksList extends StatelessWidget {
  const TasksList({super.key, required this.tasks});
  final List<TaskModel> tasks;


  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) => GestureDetector(
        onTap: () {
          debugPrint('Tapped ${tasks[index].id}: ${tasks[index].timeStart}');
        },
        child: Card(
          child: TaskTile(task: tasks[index],),
        ),
      ),
    );
  }
}
