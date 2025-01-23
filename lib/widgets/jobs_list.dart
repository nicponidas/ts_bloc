import 'package:flutter/material.dart';
import 'package:time_sheet/models/job_model.dart';
import 'package:time_sheet/widgets/job_tile.dart';

class JobsList extends StatelessWidget {
  const JobsList({
    super.key,
    required this.jobs,
  });

  final List<JobModel> jobs;

  @override
  Widget build(BuildContext context) {
    return ListView.builder( itemCount: jobs.length ,itemBuilder: (context, index) {
      return GestureDetector(
        onTap: (){
          debugPrint('Tapped ${jobs[index].jobNumber}: ${jobs[index].title}');
        },
        child: Card(
          child: JobTile(jobModel: jobs[index],),
        ),
      );
    });
  }
}
