import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_sheet/bloc/task_bloc.dart';
import 'package:time_sheet/widgets/add_task_form.dart';
import 'package:time_sheet/widgets/my_drawer.dart';
import 'package:time_sheet/widgets/tasks_list.dart';

class TasksListPage extends StatelessWidget {
  const TasksListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        title: Text('Tasks'),
      ),
      body: BlocBuilder<TaskBloc, TaskState>(
        builder: (context, state) {
          if(state is TaskLoading){
            return const CircularProgressIndicator();
          }else if (state is TaskLoaded) {
            return TasksList(
              tasks: state.tasks,
            );
          } else{
            return const Text('Nie ma prac');
          }
        },
      ),
      floatingActionButton: IconButton.filledTonal(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) =>
                AlertDialog(
                  content: AddTaskForm(),
                ),
          );
        },
        icon: const Icon(Icons.add),
      ),
    );
  }
}
