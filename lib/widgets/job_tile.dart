import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_sheet/bloc/client_bloc.dart';
import 'package:time_sheet/bloc/job_bloc.dart';
// import 'package:time_sheet/dummy_data/dummy_data.dart';
// import 'package:time_sheet/models/client_model.dart';
import 'package:time_sheet/models/job_model.dart';
import 'package:time_sheet/pages/job_page.dart';
import 'package:time_sheet/widgets/add_job_form.dart';

class JobTile extends StatelessWidget {
  const JobTile({
    super.key,
    required this.jobModel,
  });

  final JobModel jobModel;



  @override
  Widget build(BuildContext context) {
    final clientName = (context.watch<ClientBloc>().state as ClientLoaded).clients
        .firstWhere((element) => element.id == jobModel.clientId).name;
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => JobPage(job: jobModel))),
      child: ListTile(
        contentPadding:
            const EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
        leading: CircleAvatar(
            radius: 25, child: Text(jobModel.jobNumber.toString(),),),
        title: Text(jobModel.title),
        subtitle: Text(clientName),
        trailing: Row(
          spacing: 5,
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton.filledTonal(
              icon: const Icon(Icons.edit),
              color: Colors.green,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    content: AddJobForm(job: jobModel),
                  ),
                );
              },
            ),
            IconButton.filledTonal(
              icon: const Icon(Icons.delete_outline),
              color: Colors.red,
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: const Text('Remove Job'),
                          content: Text(
                              'Are you sure you want to remove: \n"${jobModel.title}"?'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                context
                                    .read<JobBloc>()
                                    .add(JobDelete(jobModel));
                                context.read<JobBloc>().add(JobLoad());
                                Navigator.pop(context);
                              },
                              child: const Text('Remove'),
                            ),
                          ],
                        ));
              },
            ),
          ],
        ),
      ),
    );
  }
}
