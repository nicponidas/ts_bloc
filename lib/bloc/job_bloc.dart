import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_sheet/models/job_model.dart';
import 'package:equatable/equatable.dart';
import 'package:time_sheet/repositories/job_repository.dart';

part 'job_event.dart';
part 'job_state.dart';

class JobBloc extends Bloc<JobEvent, JobState> {

  final JobRepository _jobRepository;
  JobBloc({required JobRepository jobRepository}) : _jobRepository = jobRepository, super(JobInitial()) {
    on<JobLoad>((event, emit) async {
      emit(JobLoading());
      try {
        final jobs = await _jobRepository.getJobs();
        emit(JobLoaded(jobs: jobs));
      } catch (e) {
        emit(JobError(message: e.toString()));
      }
    });

    on<JobAdd>((event, emit) async {
      emit(JobLoading());
      try {
         _jobRepository.addJob(event.job);
         final job = await _jobRepository.getJobs();
         emit(JobLoaded(jobs: job));
      } catch (e) {
        emit(JobError(message: e.toString()));
      }
    });

    on<JobUpdate>((event, emit) async {
      emit(JobLoading());
      try {
        _jobRepository.updateJob(event.job);
        final job = await _jobRepository.getJobs();
        emit(JobLoaded(jobs: job));
      } catch (e) {
        emit(JobError(message: e.toString()));
      }
    });

    on<JobDelete>((event, emit) async {
      emit(JobLoading());
      try {
        _jobRepository.removeJob(event.job);
        final job = await _jobRepository.getJobs();
        emit(JobLoaded(jobs: job));
      } catch (e) {
        emit(JobError(message: e.toString()));
      }
    });
  }
}
