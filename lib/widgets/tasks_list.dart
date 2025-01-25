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
          color: tasks.elementAt(index).timeSummary == 0.0 ||
                  tasks.elementAt(index).timeEnd == null
              ? Colors.green[200]
              : Colors.white,
          child: TaskTile(
            task: tasks[index],
          ),
        ),
      ),
    );
  }
}
