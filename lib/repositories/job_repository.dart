import 'package:time_sheet/dummy_data/dummy_data.dart';
import 'package:time_sheet/models/job_model.dart';

class JobRepository {
  final List<JobModel> _jobs = listOfJobs;

  Future<List<JobModel>> getJobs() async => _jobs;

  void addJob(JobModel job) {
        _jobs.add(job);
  }

  void removeJob(JobModel job) {
    _jobs.removeWhere((element) => element.id == job.id);
  }

  void updateJob(JobModel job) => _jobs[_jobs.indexWhere((element) => element.id == job.id)] = job;
}