part of 'job_bloc.dart';

abstract class JobEvent extends Equatable {
  const JobEvent();

  @override
  List<Object> get props => [];
}

class JobLoad extends JobEvent {}

class JobAdd extends JobEvent {
  final JobModel job;

  const JobAdd(this.job);

  @override
  List<Object> get props => [job];
}

class JobDelete extends JobEvent {
  final JobModel job;

  const JobDelete(this.job);

  @override
  List<Object> get props => [job];
}

class JobUpdate extends JobEvent {
  final JobModel job;

  const JobUpdate(this.job);

  @override
  List<Object> get props => [job];
}
