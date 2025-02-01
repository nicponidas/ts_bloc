import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_sheet/bloc/job_bloc.dart';
import 'package:intl/intl.dart';
import 'package:time_sheet/bloc/task_bloc.dart';
import 'package:time_sheet/bloc/task_type_bloc.dart';
import 'package:time_sheet/models/task_model.dart';

class AddTaskForm extends StatefulWidget {
  const AddTaskForm({super.key, this.task});

  final TaskModel? task;

  @override
  State<AddTaskForm> createState() => _AddTaskFormState();
}

class _AddTaskFormState extends State<AddTaskForm> {
  final _formKey = GlobalKey<FormState>();
  String selectedJob = '0';
  late String selectTaskType;
  final TextEditingController _dateStartController = TextEditingController();
  final TextEditingController _timeStartController = TextEditingController();
  final TextEditingController _dateEndController = TextEditingController();
  final TextEditingController _timeEndController = TextEditingController();


  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      selectedJob = widget.task!.jobId.toString();
      selectTaskType = widget.task!.taskTypeId.toString();
      _dateStartController.text =
          DateFormat('yyyy-MM-dd').format(widget.task!.timeStart).toString();
      _timeStartController.text =
          DateFormat('HH:mm').format(widget.task!.timeStart).toString();
      _timeEndController.text =
          DateFormat('HH:mm').format(widget.task!.timeEnd!).toString();
      _dateEndController.text =
          DateFormat('yyyy-MM-dd').format(widget.task!.timeEnd!).toString();
    }
  }


  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    setState(() {
      controller.text = DateFormat('yyyy-MM-dd').format(picked!).toString();
    });
  }

  Future<void> _selectTime(
      BuildContext context, TextEditingController controller) async {
    final TimeOfDay? picked = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(DateTime.now()),
        builder: (BuildContext context, Widget? child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
            child: child!,
          );
        });
    setState(() {
      controller.text =
          '${picked!.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}';
    });
  }

  double calculateDuration(DateTime start, DateTime end) {
    Duration difference = end.difference(start);
    double differenceInHours =
        difference.inHours + (difference.inMinutes / 60.0);
    double roundedDifference = (differenceInHours / 0.25).ceilToDouble() * 0.25;
    return roundedDifference;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        spacing: 10,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(widget.task != null ? 'Update Task' : 'Add Task',
              style: Theme.of(context).textTheme.headlineSmall),
          BlocBuilder<JobBloc, JobState>(
            builder: (context, state) {
              if (state is JobLoaded) {
                return DropdownMenu(
                  initialSelection: widget.task != null
                      ? widget.task!.jobId.toString()
                      : 'Select Job',
                  hintText: 'Job Number',
                  enableFilter: true,
                  width: double.maxFinite,
                  dropdownMenuEntries: state.jobs
                      .map((element) => DropdownMenuEntry(
                          label: element.jobNumber.toString(),
                          value: element.id))
                      .toList(),
                  onSelected: (value) {
                    setState(() {
                      selectedJob = value.toString();
                    });
                  },
                );
              } else if (state is JobLoading) {
                return const CircularProgressIndicator();
              } else if (state is JobError) {
                return Text('Error: ${state.message}');
              }
              return const Text('No clients available');
            },
          ),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Start Date',
              hintText:
                  'Pick date: ${DateFormat('yyyy-MM-dd').format(DateTime.now())}',
              border: const OutlineInputBorder(),
            ),
            keyboardType: TextInputType.datetime,
            controller: _dateStartController,
            onTap: () => _selectDate(context, _dateStartController),
          ),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Start Time',
              hintText:
                  'Pick time: ${DateFormat('HH:mm').format(DateTime.now())}',
              border: const OutlineInputBorder(),
            ),
            controller: _timeStartController,
            onTap: () => _selectTime(context, _timeStartController),
          ),
          widget.task == null
              ? SizedBox(
                  height: 0,
                )
              : Column(
                  spacing: 10,
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(), labelText: 'End Date'),
                      controller: _dateEndController,
                      onTap: () => _selectDate(context, _dateEndController),
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(), labelText: 'End Time'),
                      controller: _timeEndController,
                      onTap: () => _selectTime(context, _timeEndController),
                    )
                  ],
                ),
          BlocBuilder<TaskTypeBloc, TaskTypeState>(
            builder: (context, state) {
              if (state is TaskTypeLoading) {
                return const CircularProgressIndicator();
              } else if (state is TaskTypeLoaded) {
                return DropdownMenu(
                    width: double.maxFinite,
                    initialSelection: widget.task != null
                        ? widget.task!.taskTypeId.toString()
                        : "Select Task Type",
                    hintText: "Type of Task",
                    enableFilter: true,
                    onSelected: (value) {
                      setState(() {
                        selectTaskType = value.toString();
                      });
                    },
                    dropdownMenuEntries: state.taskTypes
                        .map((e) =>
                            DropdownMenuEntry(label: e.name, value: e.id))
                        .toList());
              } else {
                return const Text('Something wrong');
              }
            },
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
              widget.task != null
                  ? ElevatedButton.icon(
                      onPressed: () {
                        final String endDateText = "${_dateEndController.text} ${_timeEndController.text}";
                        final DateTime endDate =
                            DateTime.parse(endDateText);
                        final DateTime startDate =
                        DateTime.parse("${_dateStartController.text} ${_timeStartController.text}");
                        final sumTask = calculateDuration(startDate, endDate);
                        final newTask = TaskModel(
                          id: widget.task!.id,
                          timeStart: startDate,
                          timeSummary: sumTask,
                          jobId: widget.task!.jobId,
                          taskTypeId: widget.task!.taskTypeId,
                          timeEnd: endDate,
                          userId: widget.task!.userId,
                        );
                        context.read<TaskBloc>().add(TaskUpdate(task: newTask));
                        context.read<TaskBloc>().add(TaskLoad());
                        Navigator.pop(context);
                      },
                      label: const Text('Update'),
                      icon: const Icon(Icons.update))
                  : ElevatedButton.icon(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          final String startDate =
                              "${_dateStartController.text} ${_timeStartController.text}";
                          final newTask = TaskModel(
                              id: DateTime.now().toString(),
                              timeStart: DateTime.parse(startDate),
                              timeSummary: 0.0,
                              jobId: selectedJob,
                              taskTypeId: selectTaskType,
                              userId: '1');
                          context.read<TaskBloc>().add(TaskAdd(task: newTask));
                          context.read<TaskBloc>().add(TaskLoad());
                          Navigator.pop(context);
                        }
                      },
                      label: const Text('Add'),
                      icon: const Icon(Icons.add),
                    )
            ],
          )
        ],
      ),
    );
  }
}
