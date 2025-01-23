part of 'task_bloc.dart';

sealed class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object> get props => [];
}


class TaskLoad extends TaskEvent{}

class TaskAdd extends TaskEvent{
  final TaskModel task;

  const TaskAdd({required this.task});

  @override
  List<Object> get props => [task];
}

class TaskUpdate extends TaskEvent {
  final TaskModel task;

  const TaskUpdate({
    required this.task,
  });

  @override
  List<Object> get props => [task];
}

class TaskRemove extends TaskEvent {
  final TaskModel task;

  const TaskRemove({
    required this.task,
  });

  @override
  List<Object> get props => [task];
}
