import 'package:flutter/material.dart';
import 'package:time_sheet/models/job_model.dart';

class JobPage extends StatelessWidget {
  const JobPage({super.key, required this.job});

  final JobModel job;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(job.jobNumber.toString()),
      ),
      body: Column(
        children: [
          Card(
            child: ListTile(
              title: Text(job.title),
              subtitle: Text(job.jobUrl!),
            ),
          ),
      ]),
    );
  }
}
