import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_sheet/bloc/task_type_bloc.dart';
import 'package:time_sheet/widgets/add_task_type_form.dart';
import 'package:time_sheet/widgets/my_drawer.dart';

class TaskTypePage extends StatelessWidget {
  const TaskTypePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),

      appBar: AppBar(
        title: Text('Type of task list'),
      ),
      body: BlocBuilder<TaskTypeBloc, TaskTypeState>(
        builder: (context, state) {
          if (state is TaskTypeLoading) {
            return const CircularProgressIndicator();
          } else if (state is TaskTypeLoaded) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemBuilder: (context, index) => Card(
                  child: ListTile(
                    title: Text(state.taskTypes.elementAt(index).name),
                    trailing: IconButton.filledTonal(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            content: AddTaskTypeForm(taskType: state.taskTypes.elementAt(index),),
                          ),
                        );
                      },
                      icon: Icon(Icons.edit),
                      color: Colors.green,
                    ),
                  ),
                ),
                itemCount: state.taskTypes.length,
              ),
            );
          } else {
            return Text('Something wrong');
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              content: const AddTaskTypeForm(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

