import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_sheet/bloc/client_bloc.dart';
import 'package:time_sheet/bloc/task_bloc.dart';
import 'package:time_sheet/bloc/task_type_bloc.dart';
import 'package:time_sheet/dummy_data/dummy_data.dart';
import 'package:time_sheet/models/job_model.dart';
import 'package:time_sheet/widgets/tasks_list.dart';

class JobPage extends StatelessWidget {
  const JobPage({super.key, required this.job});

  final JobModel job;


  @override
  Widget build(BuildContext context) {
    var clientList =
        (context.watch<ClientBloc>().state as ClientLoaded).clients.firstWhere(
              (element) => element.id == job.clientId,
            );
    var taskList = (context.watch<TaskBloc>().state as TaskLoaded)
        .tasks
        .where((element) => element.jobId == job.id);
    var taskTypeList = (context.watch<TaskTypeBloc>().state as TaskTypeLoaded)
        .taskTypes
        .toList();
    return Scaffold(
      appBar: AppBar(
        title: Text(job.jobNumber.toString()),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: ListTile(
                title: Text('${clientList.name}: ${job.title}'),
                subtitle: Text(job.jobUrl ?? 'No URL'),
              ),
            ),
          ),
          SizedBox(
            height: 400,
            width: 400,
            child: BlocBuilder<TaskBloc, TaskState>(
              builder: (context, state) {
                if(state is TaskLoading) {
                  return const CircularProgressIndicator();
                } else if (state is TaskLoaded) {
                  return PieChart(
                    PieChartData(
                      sections: taskList
                          .map(
                            (task) => PieChartSectionData(
                              value: task.timeSummary,
                              color: Colors.lightBlue,
                              title: taskTypeList
                                  .firstWhere((element) =>
                                      element.id == task.taskTypeId)
                                  .name,
                              radius: 100,
                              gradient: const LinearGradient(
                                colors: [Colors.blue, Colors.lightGreen],
                                transform: GradientRotation(60),
                              ),
                            ),
                          )
                          .toList(),
                      borderData: FlBorderData(
                        border: Border.all(width: 1),
                      ),
                      centerSpaceRadius: 40,
                      sectionsSpace: 5,
                    ),
                  );
                }
                else {
                  return Container();
                }
              },
            ),
          ),
          Expanded(
            child: TasksList(tasks: taskList.toList()),
          ),
        ],
      ),
    );
  }
}
