part of 'job_bloc.dart';

abstract class JobState extends Equatable {
  const JobState();

  @override
  List<Object> get props => [];
}

 class JobInitial extends JobState {}

 class JobLoading extends JobState {}

 class JobLoaded extends JobState {
  final List<JobModel> jobs;
  const JobLoaded({ required this.jobs});
  @override
  List<Object> get props => [jobs];
}

 class JobError extends JobState {
  final String message;
  const JobError({required this.message});
  @override
  List<Object> get props => [message];
}