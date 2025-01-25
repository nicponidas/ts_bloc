import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_sheet/bloc/task_bloc.dart';
import 'package:time_sheet/bloc/task_type_bloc.dart';
import 'package:time_sheet/dummy_data/dummy_data.dart';
import 'package:time_sheet/models/task_model.dart';
import 'package:time_sheet/widgets/add_task_form.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({super.key, required this.task});

  final TaskModel task;

  @override
  Widget build(BuildContext context) {

    final taskType = listOfTaskType.firstWhere((element) => element.id == task.taskTypeId);
    final job = listOfJobs.firstWhere((element) => element.id == task.jobId);
    final client =
        listOfClient.firstWhere((element) => element.id == job.clientId);
    return ListTile(
      contentPadding:
          const EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
      leading: CircleAvatar(
        radius: 25,
        child: Text(
          task.timeSummary.toString(),
          textAlign: TextAlign.center,
        ),
      ),
      title: Text(
        '${job.jobNumber} | ${client.name}',
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('${job.title}\n${taskType.name}'),
        ],
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: 5,
        children: [
          task.timeSummary == 0.0 || task.timeEnd == null
              ? IconButton.filledTonal(
                  icon: const Icon(Icons.pin_end),
                  color: Colors.lightBlue,
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        content: AddTaskForm(
                          task: task,
                        ),
                      ),
                    );
                  },
                )
              : IconButton.filledTonal(
                  icon: const Icon(Icons.edit),
                  color: Colors.green,
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        content: AddTaskForm(
                          task: task,
                        ),
                      ),
                    );
                  },
                ),
          IconButton.filledTonal(
            icon: const Icon(Icons.delete_outline),
            color: Colors.red,
            onPressed: () {
              context.read<TaskBloc>().add(TaskRemove(task: task));
              context.read<TaskBloc>().add(TaskLoad());
            },
          ),
        ],
      ),
    );
  }
}
