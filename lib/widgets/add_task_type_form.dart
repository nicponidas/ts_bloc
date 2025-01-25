import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_sheet/bloc/task_type_bloc.dart';
import 'package:time_sheet/models/task_type_model.dart';

class AddTaskTypeForm extends StatefulWidget {
  const AddTaskTypeForm({super.key, this.taskType});

  final TaskTypeModel? taskType;

  @override
  State<AddTaskTypeForm> createState() => _AddTaskTypeFormState();
}

class _AddTaskTypeFormState extends State<AddTaskTypeForm> {
  final TextEditingController _typeOfTaskController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  TextEditingController setTaskType(TaskTypeModel? taskType) {
    if (taskType != null) {
      _typeOfTaskController.text = taskType.name;
    }
    return _typeOfTaskController;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 10,
        children: [
          Text(widget.taskType == null?
            'Add Type of Task' : 'Update Type of Task',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          TextFormField(
            controller: setTaskType(widget.taskType),
            decoration: InputDecoration(
                border: OutlineInputBorder(), label: Text('Type of Task')),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                },
                label: const Text('Cancel'),
                icon: const Icon(Icons.cancel_outlined),
              ),
              const Spacer(),
              widget.taskType == null
                  ? ElevatedButton.icon(
                      onPressed: () {
                        final taskType = TaskTypeModel(
                            id: DateTime.now().toString(),
                            name: _typeOfTaskController.text);
                        context.read<TaskTypeBloc>().add(TaskTypeAdd(taskType));
                        context.read<TaskTypeBloc>().add(TaskTypeLoad());
                        Navigator.pop(context);
                      },
                      label: const Text('Add'),
                      icon: const Icon(Icons.add),
                    )
                  : ElevatedButton.icon(
                      onPressed: () {
                        final taskType = TaskTypeModel(
                            id: widget.taskType!.id,
                            name: _typeOfTaskController.text);
                        context.read<TaskTypeBloc>().add(TaskTypeUpdate(taskType));
                        context.read<TaskTypeBloc>().add(TaskTypeLoad());
                        Navigator.pop(context);
                      },
                      label: const Text('Update'),
                      icon: const Icon(Icons.add),
                    ),
            ],
          )
        ],
      ),
    );
  }
}
