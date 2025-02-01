import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_sheet/bloc/job_bloc.dart';
import 'package:time_sheet/widgets/add_job_form.dart';
import 'package:time_sheet/widgets/jobs_list.dart';
import 'package:time_sheet/widgets/my_drawer.dart';

class JobsListPage extends StatelessWidget {
  const JobsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        title: const Text('Jobs'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<JobBloc, JobState>(
          builder: (context, state) {
            if (state is JobLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is JobLoaded) {
              return JobsList(
                jobs: state.jobs,
              );
            } else {
              return const Center(
                child: Text('Nieznany stan'),
              );
            }
          },
        ),
      ),
      floatingActionButton: IconButton.filledTonal(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              content: const AddJobForm(),
            ),
          );
        },
        icon: const Icon(Icons.add),
      ),
    );
  }
}
