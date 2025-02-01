import 'package:flutter/material.dart';
import 'package:time_sheet/dummy_data/dummy_data.dart';
import 'package:time_sheet/models/job_model.dart';
import 'package:time_sheet/widgets/add_job_form.dart';
import 'package:time_sheet/widgets/jobs_list.dart';
import 'package:time_sheet/widgets/my_drawer.dart';

class ClientPage extends StatelessWidget {
  const ClientPage({super.key, required this.client});

  final String client;

  @override
  Widget build(BuildContext context) {
    List<JobModel> jobs =
        listOfJobs.where((element) => element.clientId == client).toList();
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        title: Text(
            listOfClient.firstWhere((element) => element.id == client).name),
      ),
      body: JobsList(jobs: jobs),
      floatingActionButton: IconButton.filledTonal(
        onPressed: () {
          showDialog(context: context, builder: (context) => AlertDialog(
            content: AddJobForm(client: client),
          ));
        },
        icon: Icon(Icons.add),
      ),
    );
  }
}
