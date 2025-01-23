import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_sheet/bloc/client_bloc.dart';
import 'package:time_sheet/bloc/job_bloc.dart';
import 'package:time_sheet/models/job_model.dart';

class AddJobForm extends StatefulWidget {
  const AddJobForm({super.key, this.job, this.client});

  final JobModel? job;
  final String? client;

  @override
  State<AddJobForm> createState() => _AddJobFormState();
}

class _AddJobFormState extends State<AddJobForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _jobNumberController = TextEditingController();
  final TextEditingController _jobNameController = TextEditingController();
  final TextEditingController _jobUrlController = TextEditingController();
  late String selectedClient;

  TextEditingController setJobNumber(JobModel? job) {
    if (job != null) {
      _jobNumberController.text = job.jobNumber.toString();
      return _jobNumberController;
    }
    return _jobNumberController;
  }

  TextEditingController setJobName(JobModel? job) {
    if (job != null) {
      _jobNameController.text = job.title;
      return _jobNameController;
    }
    return _jobNameController;
  }

  TextEditingController setJobUrl(JobModel? job) {
    if (job != null) {
      _jobUrlController.text = job.jobUrl!;
      return _jobUrlController;
    }
    return _jobUrlController;
  }

  @override
  void initState() {
    super.initState();
    if (widget.job != null) {
      selectedClient = widget.job!.clientId;
    } else {
      // Dla nowego joba
      final state = context.read<ClientBloc>().state;
      if (state is ClientLoaded && state.clients.isNotEmpty) {
        selectedClient = state.clients.first.id;
      } else {
        selectedClient = "Select Client";
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<JobBloc, JobState>(
      builder: (context, state) {
        return Form(
          key: _formKey,
          child: Column(
            spacing: 10.0,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.job == null ? 'Add Job' : 'Update Job',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              TextFormField(
                controller: setJobNumber(widget.job),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Job Number',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Job Number';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: setJobName(widget.job),
                decoration: InputDecoration(
                  labelText: 'Job Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Job Name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: setJobUrl(widget.job),
                decoration: InputDecoration(
                  labelText: 'Job Url',
                  border: OutlineInputBorder(),
                ),
              ),
              BlocBuilder<ClientBloc, ClientState>(
                builder: (context, state) {
                  if (state is ClientLoaded) {
                    return DropdownMenu(
                        width: double.maxFinite,
                        enableFilter: true,
                        dropdownMenuEntries: state.clients
                            .map((e) => DropdownMenuEntry(
                                label: e.name, value: e.id.toString()))
                            .toList(),
                        initialSelection: selectedClient,
                        onSelected: (value) {
                          setState(() {
                            selectedClient = value.toString();
                          });
                        });
                  } else if (state is ClientLoading) {
                    return const CircularProgressIndicator();
                  } else if (state is ClientError) {
                    return Text('Error: ${state.error}');
                  }
                  return const Text('No clients available');
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
                  widget.job == null
                      ? ElevatedButton.icon(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              final newJob = JobModel(
                                id: DateTime.now().toString(),
                                clientId: selectedClient,
                                jobNumber: int.parse(_jobNumberController.text),
                                title: _jobNameController.text,
                                jobUrl: _jobUrlController.text,
                              );
                              context.read<JobBloc>().add(JobAdd(newJob));
                              context.read<JobBloc>().add(JobLoad());
                              Navigator.pop(context);
                            }
                          },
                          label: const Text('Add'),
                          icon: const Icon(Icons.add),
                        )
                      : ElevatedButton.icon(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              final updatedjob = JobModel(
                                id: widget.job!.id,
                                clientId: selectedClient,
                                jobNumber: int.parse(_jobNumberController.text),
                                title: _jobNameController.text,
                                jobUrl: _jobUrlController.text,
                              );
                              context
                                  .read<JobBloc>()
                                  .add(JobUpdate(updatedjob));
                              context.read<JobBloc>().add(JobLoad());
                              Navigator.pop(context);
                            }
                          },
                          label: const Text('Update'),
                          icon: const Icon(Icons.update),
                        ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
