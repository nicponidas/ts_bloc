import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_sheet/bloc/job_bloc.dart';

class AddTaskForm extends StatefulWidget {
  const AddTaskForm({super.key});

  @override
  State<AddTaskForm> createState() => _AddTaskFormState();
}

class _AddTaskFormState extends State<AddTaskForm> {
  final _formKey = GlobalKey<FormState>();
  String selectedJob = 'Select job';


  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          BlocBuilder<JobBloc, JobState>(
            builder: (context, state) {
              if (state is JobLoaded) {
                return Expanded(
                    child: DropdownButton(
                      value: selectedJob,
                      items: state.jobs
                          .map((e) =>
                              DropdownMenuItem(value: e.id, child: Text(e.jobNumber.toString())))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedJob = value.toString();
                        });
                      },
                    ),
                );
              } else if (state is JobLoading) {
                return const CircularProgressIndicator();
              } else {
                return const Center(
                  child: Text('Nieznany stan'),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
