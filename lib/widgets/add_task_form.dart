import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_sheet/bloc/job_bloc.dart';
import 'package:intl/intl.dart';

class AddTaskForm extends StatefulWidget {
  const AddTaskForm({super.key});

  @override
  State<AddTaskForm> createState() => _AddTaskFormState();
}

class _AddTaskFormState extends State<AddTaskForm> {
  final _formKey = GlobalKey<FormState>();
  String selectedJob = '0';
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final state = context.read<JobBloc>().state;
    if (state is JobLoaded && state.jobs.isNotEmpty) {
      selectedJob = state.jobs.first.id.toString();
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    setState(() {
      _dateController.text =
          DateFormat('yyyy-MM-dd').format(picked!).toString();
    });
  }

  Future<void> _selectTime(BuildContext context) async {
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
      _timeController.text =
          '${picked!.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        spacing: 10,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Add Task', style: Theme.of(context).textTheme.headlineSmall),
          Flexible(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: Colors.black45,
                ),
              ),
              width: double.maxFinite,
              child: BlocBuilder<JobBloc, JobState>(
                builder: (context, state) {
                  if (state is JobLoaded) {
                    return DropdownMenu(
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
            ),
          ),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Start Date',
              hintText:
                  'Pick date: ${DateFormat('yyyy-MM-dd').format(DateTime.now())}',
              border: const OutlineInputBorder(),
            ),
            keyboardType: TextInputType.datetime,
            controller: _dateController,
            onTap: () => _selectDate(context),
          ),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Start Time',
              hintText:
                  'Pick time: ${DateFormat('HH:mm').format(DateTime.now())}',
              border: const OutlineInputBorder(),
            ),
            controller: _timeController,
            onTap: () => _selectTime(context),
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
              ElevatedButton.icon(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
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
