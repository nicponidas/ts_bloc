part of 'task_type_bloc.dart';

abstract class TaskTypeState extends Equatable {
  const TaskTypeState();

  @override
  List<Object> get props => [];
}

 class TaskTypeInitial extends TaskTypeState {}

 class TaskTypeLoading extends TaskTypeState {}

 class TaskTypeLoaded extends TaskTypeState {
  final List<TaskTypeModel> taskTypes;

  const TaskTypeLoaded({
    required this.taskTypes,
  });

  @override
  List<Object> get props => [taskTypes];
}

 class TaskTypeError extends  TaskTypeState{
  final String error;

  const TaskTypeError({required this.error});

  @override
  List<Object> get props => [error];
}
